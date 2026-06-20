//
//  UserDTO.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation
import FirebaseFirestore

struct UserDTO: Codable {
    @DocumentID var id: String?
    var name: String
    var email: String
    var role: String
    
    func toDomain() -> AppUser {
        AppUser(id: id ?? UUID().uuidString,
                name: name,
                email: email,
                role: UserRole(rawValue: role) ?? .user)
    }
}
