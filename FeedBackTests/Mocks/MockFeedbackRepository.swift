//
//  MockFeedbackRepository.swift
//  FeedBackTests
//
//  Created by Priyank Yadav on 20/06/26.
//

import Foundation
@testable import FeedBack

final class MockFeedbackRepository: FeedbackRepository {
    // these record what happened, so the test can check later
    var submittedFeedback: Feedback?
    var shouldThrowOnSubmit = false
    var feedbackToReturn: [Feedback] = []

    func submit(_ feedback: Feedback) async throws {
        if shouldThrowOnSubmit {
            throw FeedbackValidationError.emptyComment
        }
        submittedFeedback = feedback
    }

    func fetchMyFeedback(userId: String) async throws -> [Feedback] {
        return feedbackToReturn
    }

    func fetchAllFeedback() async throws -> [Feedback] {
        return feedbackToReturn
    }
}
