//
//  SubmitFeedbackUseCaseTests.swift
//  FeedBackTests
//
//  Created by Priyank Yadav on 20/06/26.
//

import XCTest
@testable import FeedBack

@MainActor
final class SubmitFeedbackUseCaseTests: XCTestCase {
    
    func test_execute_withEmptyComment_throwsEmptyCommentError() async {
        // Arrange
        let mockRepository = MockFeedbackRepository()
        let useCase = SubmitFeedbackUseCase(repository: mockRepository)

        // Act + Assert
        do {
            try await useCase.execute(userId: "u1", userName: "Priyanka", mood: .good, comment: "   ")
            XCTFail("Expected emptyComment error but no error was thrown")
        } catch FeedbackValidationError.emptyComment {
            // this is the success path — correct error was thrown
        } catch {
            XCTFail("Expected emptyComment but got \(error)")
        }
    }
    
    func test_execute_withCommentOver500Chars_throwsCommentTooLongError() async {
        // Arrange
        let mockRepository = MockFeedbackRepository()
        let useCase = SubmitFeedbackUseCase(repository: mockRepository)
        let longComment = String(repeating: "a", count: 501)

        // Act + Assert
        do {
            try await useCase.execute(userId: "u1", userName: "Priyanka", mood: .good, comment: longComment)
            XCTFail("Expected commentTooLong error but no error was thrown")
        } catch FeedbackValidationError.commentTooLong {
            // success
        } catch {
            XCTFail("Expected commentTooLong but got \(error)")
        }
    }
    
    func test_execute_withValidComment_submitsSuccessfully() async throws {
        // Arrange
        let mockRepository = MockFeedbackRepository()
        let useCase = SubmitFeedbackUseCase(repository: mockRepository)

        // Act
        try await useCase.execute(userId: "u1", userName: "Priyanka", mood: .good, comment: "Great app!")

        // Assert
        XCTAssertEqual(mockRepository.submittedFeedback?.comment, "Great app!" )
        XCTAssertEqual(mockRepository.submittedFeedback?.userId, "u1")
    }
}
