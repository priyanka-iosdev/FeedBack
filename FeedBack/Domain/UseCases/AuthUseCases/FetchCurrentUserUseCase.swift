//
//  FetchCurrentUserUseCase.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation
import FirebaseAuth

struct FetchCurrentUserUseCase {
    private let authRepository: FirebaseAuthRepository
    
    init(authRepository: FirebaseAuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() async throws -> AppUser? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return try await authRepository.fetchUser(uid: uid)
    }
}
