//
//  fetchAllFeedbackUseCase.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

struct FetchAllFeedbackUseCase {
    private let repository: FeedbackRepository
    
    init(repository: FeedbackRepository) {
        self.repository = repository
    }
    
    func fetchAllFeedback(moodFilter: Mood? = nil) async throws -> [Feedback] {
        let all = try await repository.fetchAllFeedback()
        let filtered = moodFilter.map { mood in all.filter { $0.mood == mood }} ?? all
        return filtered.sorted { $0.createdAt > $1.createdAt }
    }
}
