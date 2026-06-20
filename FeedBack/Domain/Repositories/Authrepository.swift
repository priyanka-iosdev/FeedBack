//
//  Authrepository.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

protocol Authrepository {
    func signUp(email: String, password: String, name: String, role: UserRole) async throws -> AppUser
    func login(email: String, password: String) async throws -> AppUser
    func signInWithGoogle() async throws -> AppUser
    func fetchUser(uid: String) async throws -> AppUser
    func saveUserRole(uid: String, name: String, email: String, role: UserRole) async throws
    func logout() throws
}
