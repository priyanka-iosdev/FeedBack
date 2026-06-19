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
    
    private let fetchAllFeedbackUseCase: FetchAllFeedbackUseCase
    
    init(fetchAllFeedbackUseCase: FetchAllFeedbackUseCase) {
        self.fetchAllFeedbackUseCase = fetchAllFeedbackUseCase
    }
    
    func load() {
        isLoading = true
        errorMessage = nil
        
        Task {
            defer { isLoading = false }
            do {
                feedbackList = try await fetchAllFeedbackUseCase.fetchAllFeedback(moodFilter: selectedMoodFilter)
            }  catch {
                errorMessage = error.localizedDescription
            }
        }
        
    }
}
