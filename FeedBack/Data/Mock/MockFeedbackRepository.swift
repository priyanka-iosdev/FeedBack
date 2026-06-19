//
//  MockFeedbackRepository.swift
//  FeedBack
//
//  Created by Priyank Yadav on 19/06/26.
//

import Foundation

enum MockFeedbackData {
    static let all: [Feedback] = [
        Feedback(userId: "u1", userName: "Asha K.", mood: .bad, comment: "App crashed on checkout", createdAt: Date().addingTimeInterval(-86_400 * 7)),
        Feedback(userId: "u2", userName: "Rohan M.", mood: .good, comment: "Loved the new onboarding flow", createdAt: Date().addingTimeInterval(-86_400 * 2)),
        Feedback(userId: "u3", userName: "Priyanka Y.", mood: .neutral, comment: "Search could be faster", createdAt: Date().addingTimeInterval(-86_400 * 5))
    ]
}
