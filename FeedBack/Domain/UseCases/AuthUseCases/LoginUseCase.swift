//
//  LoginUseCase.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

struct LoginUseCase {
    private let authRepository: FirebaseAuthRepository
    
    init(authRepository: FirebaseAuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute(email: String, password: String) async throws -> AppUser {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedEmail.isEmpty else {
            throw AuthValidationError.emptyEmail
        }
        guard !password.isEmpty else {
            throw AuthValidationError.emptyPassword
        }
        return try await authRepository.login(email: trimmedEmail, password: password)
    }
}
