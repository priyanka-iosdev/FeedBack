//
//  FetchMyFeedbackUseCase.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

struct FetchMyFeedbackUseCase {
    private let repository: FeedbackRepository
    
    init(repository: FeedbackRepository) {
        self.repository = repository
    }
    
    func execute(userId: String) async throws -> [Feedback] {
        try await repository.fetchMyFeedback(userId: userId)
            .sorted { $0.createdAt > $1.createdAt }
    }
}
