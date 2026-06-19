//
//  FeedbackValidationError.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

enum FeedbackValidationError: LocalizedError {
    case emptyComment
    case commentTooLong
 
    var errorDescription: String? {
        switch self {
        case .emptyComment: return "Please add a comment before submitting."
        case .commentTooLong: return "Comment is too long (max 500 characters)."
        }
    }
}
