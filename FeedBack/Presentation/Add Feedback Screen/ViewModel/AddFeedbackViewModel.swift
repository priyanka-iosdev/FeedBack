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
    
    private let submitFeedbackUseCase: SubmitFeedbackUseCase
    private let currentUser: AppUser
    
    init(submitFeedbackUseCase: SubmitFeedbackUseCase, currentUser: AppUser) {
        self.submitFeedbackUseCase = submitFeedbackUseCase
        self.currentUser = currentUser
    }
    
    
    var background: Color { DesignTokens.MoodColor.background(for: mood) }
    var accent: Color { DesignTokens.MoodColor.accent(for: mood) }
    
    func submit() {
        errorMessage = nil
        isSubmitting = true
        
        Task {
            defer { isSubmitting = false }
            do {
                try await submitFeedbackUseCase.execute(userId: currentUser.id,
                                                        userName: currentUser.name,
                                                        mood: mood,
                                                        comment: comment)
                comment = ""
                didSubmit = true
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
