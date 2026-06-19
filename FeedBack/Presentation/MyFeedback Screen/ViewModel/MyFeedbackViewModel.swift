//
//  MyFeedbackViewModel.swift
//  FeedBack
//
//  Created by Priyank Yadav on 18/06/26.
//

import Foundation

@MainActor
@Observable
final class MyFeedbackViewModel {
    var feedbackList: [Feedback] = []
    var isLoading = false
    var errorMsg: String?
    var showAddSheet = false
    
    private let fetchMyFeedbackUseCases: FetchMyFeedbackUseCase
    private let currentUser: AppUser
    
    init(fetchMyFeedbackUseCases: FetchMyFeedbackUseCase, currentUser: AppUser) {
        self.fetchMyFeedbackUseCases = fetchMyFeedbackUseCases
        self.currentUser = currentUser
    }
    
    func load() {
        isLoading = true
        errorMsg = nil
        
        Task {
            defer { isLoading = false }
            do {
                feedbackList = try await fetchMyFeedbackUseCases.execute(userId: currentUser.id)
            } catch {
                errorMsg = error.localizedDescription
            }
        }
    }
}
