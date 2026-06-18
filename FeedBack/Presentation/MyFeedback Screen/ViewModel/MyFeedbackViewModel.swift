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
    
    func load() {
        isLoading = true
        errorMsg = nil
    }
}
