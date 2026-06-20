//
//  FirebaseAuthRepository.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import GoogleSignInSwift
import FirebaseCore

final class FirebaseAuthRepository: Authrepository {
    private let db = Firestore.firestore()
    private let userCollection = "users"
    
    // MARK: - Email Sign Up
    
    func signUp(email: String, password: String, name: String, role: UserRole) async throws -> AppUser {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = result.user.uid
        
        let data: [String: Any] = [
            "name": name,
            "email": email,
            "role": role.rawValue
        ]
        
        try await db.collection(userCollection).document(uid).setData(data)
        
        return AppUser(id: uid, name: name, email: email, role: role)
    }
    
    // MARK: - Email Login
    
    func login(email: String, password: String) async throws -> AppUser {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        return try await fetchUser(uid: result.user.uid)
    }
    
    // MARK: - Google Sign In
    
    func signInWithGoogle() async throws -> AppUser {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            throw AuthError.missingClientID
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = await UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = await windowScene.windows.first?.rootViewController else {
            throw AuthError.noRootViewController
        }
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootVC)
        let user = result.user
        
        guard let idToken = user.idToken?.tokenString else {
            throw AuthError.missingToken
        }
        
        let credential = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )
        
        let authResult = try await Auth.auth().signIn(with: credential)
        let uid = authResult.user.uid
        
        // check if user already exists in Firestore
        let doc = try await db.collection(userCollection).document(uid).getDocument()
        if doc.exists {
            return try await fetchUser(uid: uid)
        }
        
        // new Google user — return without role, SignupViewModel will save it
        let name = user.profile?.name ?? "User"
        let email = user.profile?.email ?? ""
        return AppUser(id: uid, name: name, email: email, role: .user)
    }
    
    // MARK: - Fetch User
    
    func fetchUser(uid: String) async throws -> AppUser {
        let doc = try await db.collection(userCollection).document(uid).getDocument()
        guard let dto = try? doc.data(as: UserDTO.self) else {
            throw AuthError.userNotFound
        }
        return dto.toDomain()
    }
    
    // MARK: - Save Role (after Google sign in)
    
    func saveUserRole(uid: String, name: String, email: String, role: UserRole) async throws {
        let data: [String: Any] = [
            "name": name,
            "email": email,
            "role": role.rawValue
        ]
        try await db.collection(userCollection).document(uid).setData(data)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
}
