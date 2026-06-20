//
//  AppCoordinator.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation
import SwiftUI
import FirebaseAuth

@MainActor
protocol Coordinator: AnyObject {
    func start()
}

@MainActor
@Observable
final class AppCoordinator: Coordinator {
    var authCoordinator: AuthCoordinator?
    var homeCoordinator: HomeCoordinator?
    var isLoggedIn: Bool = false
    var currentUser: AppUser?
    
    private let repository: FirebaseFeedbackRepository
    private let authRepository: FirebaseAuthRepository
    
    init() {
        self.repository = FirebaseFeedbackRepository()
        self.authRepository = FirebaseAuthRepository()
    }
    
    func start() {
        listenToAuthState()
    }
    
    private func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, firebaseUser in
            guard let self else { return }
            Task { @MainActor in
                if let firebaseUser {
                    await self.routeLoggedInUser(uid: firebaseUser.uid)
                } else {
                    self.isLoggedIn = false
                    self.currentUser = nil
                    self.showAuth()
                }
            }
        }
    }
    
    private func routeLoggedInUser(uid: String, retriesLeft: Int = 3) async {
        do {
            let appUser = try await authRepository.fetchUser(uid: uid)
            self.currentUser = appUser
            self.isLoggedIn = true
            self.homeCoordinator = HomeCoordinator(
                currentUser: appUser,
                repository: self.repository,
                appCoordinator: self
            )
            self.authCoordinator = nil
        } catch {
            if retriesLeft > 0 {
                // Firestore doc may not be written yet (Google sign-in race) — wait and retry
                try? await Task.sleep(nanoseconds: 400_000_000) // 0.4s
                await routeLoggedInUser(uid: uid, retriesLeft: retriesLeft - 1)
            } else {
                self.isLoggedIn = false
                self.showAuth()
            }
        }
    }
    
    private func showAuth() {
        authCoordinator = AuthCoordinator(authRepository: authRepository)
        homeCoordinator = nil
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

