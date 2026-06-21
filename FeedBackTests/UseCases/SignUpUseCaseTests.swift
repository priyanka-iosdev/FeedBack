//
//  SignUpUseCaseTests.swift
//  FeedBackTests
//
//  Created by Priyank Yadav on 21/06/26.
//

import XCTest
@testable import FeedBack

@MainActor
final class SignUpUseCaseTests: XCTestCase {
    
    func test_execute_withEmptyTrimmedName_throwsAuthValidatorError() async throws {
        // Arrange
        let mockAuthRepository = MockAuthRepository()
        let useCase = SignUpUseCase(authRepository: mockAuthRepository)
        
        do {
            try await useCase.execute(email: "test@x.com", password: "123456", name: " ", role: .user)
            XCTFail("Expected emptyName error but no error was thrown")
        } catch AuthValidationError.emptyName {
            // Success
        } catch {
            XCTFail("Expected emptyName but got \(error)")
        }
    }
    
    func test_execute_withEmptyTrimmedEmail_throwsAuthValidatorError() async throws {
        // Arrange
        let mockAuthRepository = MockAuthRepository()
        let useCase = SignUpUseCase(authRepository: mockAuthRepository)
        
        do {
            try await useCase.execute(email: " ", password: "123456", name: "Vijay", role: .user)
            XCTFail("Expected emptyEmail error but no error was thrown")
            
        } catch AuthValidationError.emptyEmail {
            // success
        } catch {
            XCTFail("Expected emptyEmail but go \(error)")
        }
    }
    
    func test_execute_withPasswordCountLessThanSix_throwsWeakPasswordError() async throws {
        // Arrange
        let mockAuthRepository = MockAuthRepository()
        let useCase = SignUpUseCase(authRepository: mockAuthRepository)
        
        // Act + Assert
        do {
            try await useCase.execute(email: "test@x.com", password: "12345", name: "Vijay", role: .user)
            XCTFail("Expected weakPassword error but no error was thrown")
        } catch AuthValidationError.weakPassword {
            // success
        } catch {
            XCTFail("Expected weakPassword but got \(error)")
        }
    }
    
    func test_execute_withValidInput_signsUpSuccessfully() async throws {
        // Arrange
        let mockAuthRepository = MockAuthRepository()
        let useCase = SignUpUseCase(authRepository: mockAuthRepository)
        
        // Act
        let result = try await useCase.execute(email: "test@x.com", password: "123456", name: "Vijay", role: .user)
        
        // Assert
        XCTAssertEqual(result.name, "Vijay")
        XCTAssertEqual(result.email, "test@x.com")
        XCTAssertEqual(mockAuthRepository.signedUpUser?.name, "Vijay")
    }
}
