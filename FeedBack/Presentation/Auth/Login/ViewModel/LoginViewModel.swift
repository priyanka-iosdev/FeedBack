//
//  LoginViewModel.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    var isLoading = false
    var errorMessage: String?
    
    private let loginUseCase: LoginUseCase
    private let signInWithGoogleUseCase: SignInWithGoogleUseCase
    private weak var coordinator: AuthCoordinator?
    
    init(loginUseCase: LoginUseCase, signInWithGoogleUseCase: SignInWithGoogleUseCase, coordinator: AuthCoordinator) {
        self.loginUseCase = loginUseCase
        self.signInWithGoogleUseCase = signInWithGoogleUseCase
        self.coordinator = coordinator
    }
    
    func login() {
        isLoading = true
        errorMessage = nil
        Task {
            defer { isLoading = false }
            do {
                _ = try await loginUseCase.execute(email: email, password: password)
                // AppCoordinator's auth state listener handles routing automatically
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func signInWithGoogle() {
        isLoading = true
        errorMessage = nil
        Task {
            defer { isLoading = false }
            do {
                let user = try await signInWithGoogleUseCase.execute()
                // if new Google user (no role saved yet) → go to signup for role selection
                // AppCoordinator handles existing users automatically via auth listener
                _ = user
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func goToSignup() {
        coordinator?.showSignup()
    }
}
