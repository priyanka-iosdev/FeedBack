//
//  AdminFeedbackViewModel.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import Foundation

@MainActor
@Observable
final class AdminFeedbackViewModel {
    var feedbackList: [Feedback] = []
    var isLoading = false
    var errorMessage: String?
    var selectedMoodFilter: Mood? = nil {
        didSet {
            load()
        }
    }
    
    func load() {
        isLoading = true
        errorMessage = nil
        
    }
}
