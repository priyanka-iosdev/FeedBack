//
//  SignUpUseCase.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

struct SignUpUseCase {
    private let authRepository: FirebaseAuthRepository
    
    init(authRepository: FirebaseAuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute(email: String, password: String, name: String, role: UserRole) async throws -> AppUser {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            throw AuthValidationError.emptyName
        }
        guard !trimmedEmail.isEmpty else {
            throw AuthValidationError.emptyEmail
        }
        guard password.count >= 6 else {
            throw AuthValidationError.weakPassword
        }
        
        return try await authRepository.signUp(email: trimmedEmail, password: password, name: trimmedName, role: role)
    }
}
