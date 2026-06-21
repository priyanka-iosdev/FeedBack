//
//  FetchMyFeedbackUseCaseTests.swift
//  FeedBackTests
//
//  Created by Priyank Yadav on 21/06/26.
//

import XCTest
@testable import FeedBack

@MainActor
final class FetchMyFeedbackUseCaseTests: XCTestCase {
    func test_execute_fetchMyFeedback() async throws {
        // Arrange
        let mockRepository = MockFeedbackRepository()
        let useCase = FetchMyFeedbackUseCase(repository: mockRepository)
        
        let oldFeedback = Feedback(userId: "u1", userName: "Priyanka", mood: .good, comment: "old", createdAt: Date(timeIntervalSince1970: 1000))
        let newFeedback = Feedback(userId: "u1", userName: "Priyanka", mood: .good, comment: "new", createdAt: Date(timeIntervalSince1970: 2000))
        
        mockRepository.feedbackToReturn = [oldFeedback, newFeedback]
        
       // Act
        let result = try await useCase.execute(userId: "u1")
        
        // Assert
        XCTAssertEqual(result.first?.comment, "new")
        XCTAssertEqual(result.last?.comment, "old")
    }
}
