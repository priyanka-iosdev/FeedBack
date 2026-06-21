//
//  FetchAllFeedbackUseCaseTests.swift
//  FeedBackTests
//
//  Created by Priyank Yadav on 21/06/26.
//

import XCTest
@testable import FeedBack

@MainActor
final class FetchAllFeedbackUseCaseTests: XCTestCase {
    
    func test_execute_withNilFilter_returnsAllFeedback() async throws {
        // Arrange
        let mockRepository = MockFeedbackRepository()
        let useCase = FetchAllFeedbackUseCase(repository: mockRepository)
        
        let badFeedback = Feedback(userId: "u1", userName: "Priyanka", mood: .bad, comment: "bad one", createdAt: Date(timeIntervalSince1970: 1000))
        let goodFeedback = Feedback(userId: "u2", userName: "Vijay", mood: .good, comment: "good one", createdAt: Date(timeIntervalSince1970: 2000))
        
        mockRepository.feedbackToReturn = [badFeedback, goodFeedback]
        
        // Act
        let result = try await useCase.fetchAllFeedback(moodFilter: nil)
        
        // Assert
        XCTAssertEqual(result.count, 2)
    }
    
    func test_execute_withGoodFilter_returnsOnlyGoodFeedback() async throws {
        // Arrange
        let mockRepository = MockFeedbackRepository()
        let useCase = FetchAllFeedbackUseCase(repository: mockRepository)

        let badFeedback = Feedback(userId: "u1", userName: "Priyanka", mood: .bad, comment: "bad one", createdAt: Date(timeIntervalSince1970: 1000))
        let goodFeedback = Feedback(userId: "u2", userName: "Vijay", mood: .good, comment: "good one", createdAt: Date(timeIntervalSince1970: 2000))

        mockRepository.feedbackToReturn = [badFeedback, goodFeedback]

        // Act
        let result = try await useCase.fetchAllFeedback(moodFilter: .good)

        // Assert
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.comment, "good one")
    }
}
