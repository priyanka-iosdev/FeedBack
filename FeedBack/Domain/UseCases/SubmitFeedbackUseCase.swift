//
//  SubmitFeedbackUseCase.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

struct SubmitFeedbackUseCase {
    private let repository: FeedbackRepository
    
    init(repository: FeedbackRepository) {
        self.repository = repository
    }
    
    func execute(userId: String, userName: String, mood: Mood, comment: String) async throws {
        let trimmed = comment.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { throw FeedbackValidationError.emptyComment }
        guard trimmed.count <= 500 else { throw FeedbackValidationError.commentTooLong }
        
        let feedback = Feedback(userId: userId, userName: userName, mood: mood, comment: comment)
        
        try await repository.submit(feedback)
    }
}
