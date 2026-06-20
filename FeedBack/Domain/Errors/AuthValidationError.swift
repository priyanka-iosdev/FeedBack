//
//  AuthValidationError.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

enum AuthValidationError: LocalizedError {
    case emptyName
    case emptyEmail
    case emptyPassword
    case weakPassword
 
    var errorDescription: String? {
        switch self {
        case .emptyName:     return "Please enter your name."
        case .emptyEmail:    return "Please enter your email."
        case .emptyPassword: return "Please enter your password."
        case .weakPassword:  return "Password must be at least 6 characters."
        }
    }
}

// MARK: - Auth Errors

enum AuthError: LocalizedError {
   case missingClientID
   case noRootViewController
   case missingToken
   case userNotFound

   var errorDescription: String? {
       switch self {
       case .missingClientID:      return "Firebase client ID missing."
       case .noRootViewController: return "Could not find root view controller."
       case .missingToken:         return "Google sign-in token missing."
       case .userNotFound:         return "User profile not found."
       }
   }
}
