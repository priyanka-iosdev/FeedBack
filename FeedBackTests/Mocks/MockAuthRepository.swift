//
//  MockAuthRepository.swift
//  FeedBackTests
//
//  Created by Priyank Yadav on 21/06/26.
//

import Foundation
@testable import FeedBack

final class MockAuthRepository: Authrepository {
    
    var signedUpUser: AppUser?
    var shouldThrowOnSignUp = false
    
    func signUp(email: String, password: String, name: String, role: FeedBack.UserRole) async throws -> FeedBack.AppUser {
        if shouldThrowOnSignUp {
            throw AuthValidationError.emptyEmail
        }
        let user = AppUser(id: "mockId", name: name, email: email, role: role)
        signedUpUser = user
        return user
    }
    
    func login(email: String, password: String) async throws -> FeedBack.AppUser {
        AppUser(id: "mockId", name: "Mock User", email: email, role: .user)
    }
    
    func signInWithGoogle() async throws -> FeedBack.AppUser {
        AppUser(id: "mockId", name: "Mock Google User", email: "mock@google.com", role: .user)
    }
    
    func fetchUser(uid: String) async throws -> FeedBack.AppUser {
        AppUser(id: uid, name: "Mock User", email: "mock@x.com", role: .user)
    }
    
    func saveUserRole(uid: String, name: String, email: String, role: FeedBack.UserRole) async throws {
                        
    }
    
    func logout() throws {
        
    }
    
    
}
