//
//  LoginUseCaseTests.swift
//  FeedBackTests
//
//  Created by Priyank Yadav on 21/06/26.
//

import XCTest
@testable import FeedBack

@MainActor
final class LoginUseCaseTests: XCTestCase {

    func test_execute_withEmptyEmail_throwsEmptyEmailError() async throws {
        // Arrange
        let mockAuthRepository = MockAuthRepository()
        let useCase = LoginUseCase(authRepository: mockAuthRepository)

        // Act + Assert
        do {
            try await useCase.execute(email: " ", password: "123456")
            XCTFail("Expected emptyEmail error but no error was thrown")
        } catch AuthValidationError.emptyEmail {
            // success
        } catch {
            XCTFail("Expected emptyEmail but got \(error)")
        }
    }

    func test_execute_withEmptyPassword_throwsEmptyPasswordError() async throws {
        // Arrange
        let mockAuthRepository = MockAuthRepository()
        let useCase = LoginUseCase(authRepository: mockAuthRepository)

        // Act + Assert
        do {
            try await useCase.execute(email: "test@x.com", password: "")
            XCTFail("Expected emptyPassword error but no error was thrown")
        } catch AuthValidationError.emptyPassword {
            // success
        } catch {
            XCTFail("Expected emptyPassword but got \(error)")
        }
    }

    func test_execute_withValidInput_logsInSuccessfully() async throws {
        // Arrange
        let mockAuthRepository = MockAuthRepository()
        let useCase = LoginUseCase(authRepository: mockAuthRepository)

        // Act
        let result = try await useCase.execute(email: "test@x.com", password: "123456")

        // Assert
        XCTAssertEqual(result.email, "test@x.com")
    }
}
