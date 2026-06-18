//
//  AddFeedbackViewModel.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class AddFeedbackViewModel {
    var mood: Mood = .neutral
    var comment: String = ""
    var isSubmitting: Bool = false
    var errorMessage: String?
    var didSubmit: Bool = false
    
    var background: Color { DesignTokens.MoodColor.background(for: mood) }
    var accent: Color { DesignTokens.MoodColor.accent(for: mood) }
    
    func submit() {
        print("Feedback Submitted!")
    }
}
