//
//  SignInWithGoogleUseCase.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

struct SignInWithGoogleUseCase {
    private let authRepository: FirebaseAuthRepository
    
    init(authRepository: FirebaseAuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() async throws -> AppUser {
        try await authRepository.signInWithGoogle()
    }
}
