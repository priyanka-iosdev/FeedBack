//
//  User.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

enum UserRole: String, Codable {
    case user
    case admin
}
 
struct AppUser: Identifiable, Equatable {
    let id: String
    let name: String
    let email: String
    let role: UserRole
 
    var isAdmin: Bool { role == .admin }
}
