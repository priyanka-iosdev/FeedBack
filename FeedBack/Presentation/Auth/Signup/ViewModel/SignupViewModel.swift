//
//  SignupViewModel.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//
import Foundation
import SwiftUI

@MainActor
@Observable
final class SignupViewModel {
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var selectedRole: UserRole = .user
    var isLoading = false
    var errorMessage: String?
    
    private let signUpUseCase: SignUpUseCase
    private let signInWithGoogleUseCase: SignInWithGoogleUseCase
    private weak var coordinator: AuthCoordinator?
    
    init(signUpUseCase: SignUpUseCase, signInWithGoogleUseCase: SignInWithGoogleUseCase, coordinator: AuthCoordinator) {
        self.signUpUseCase = signUpUseCase
        self.signInWithGoogleUseCase = signInWithGoogleUseCase
        self.coordinator = coordinator
    }
    
    func signUp() {
        isLoading = true
        errorMessage = nil
        Task {
            defer { isLoading = false }
            do {
                _ = try await signUpUseCase.execute(
                    email: email,
                    password: password,
                    name: name,
                    role: selectedRole
                )
                // AppCoordinator auth listener fires automatically → routes to home
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func signUpWithGoogle() {
        isLoading = true
        errorMessage = nil
        Task {
            defer { isLoading = false }
            do {
                let user = try await signInWithGoogleUseCase.execute()
                // save role to Firestore for this Google user
                let authRepo = FirebaseAuthRepository()
                try await authRepo.saveUserRole(
                    uid: user.id,
                    name: user.name,
                    email: user.email,
                    role: selectedRole
                )
                // AppCoordinator auth listener fires → routes to home
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
    
    func goBack() {
        coordinator?.popToLogin()
    }
}
