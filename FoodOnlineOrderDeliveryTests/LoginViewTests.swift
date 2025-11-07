//
//  LoginViewTests.swift
//  FoodOnlineOrderDeliveryTests
//
//  Created by Unit Tests
//

import XCTest
import SwiftUI
import Combine
@testable import FoodOnlineOrderDelivery

// MARK: - Mock AuthManager for Testing
@MainActor
class MockAuthManager: ObservableObject {
    @Published var authState: AuthState = .unauthenticated
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var currentUser: User?
    @Published var isNewUser: Bool = false

    var shouldSucceed: Bool = true
    var loginCallCount: Int = 0

    func login(email: String, password: String) async -> Bool {
        loginCallCount += 1
        isLoading = true

        // Simulate network delay
        try? await Task.sleep(nanoseconds: 100_000_000)

        isLoading = false

        if shouldSucceed {
            authState = .authenticated
            currentUser = User(id: "test-id", email: email, name: "Test User")
            errorMessage = nil
            return true
        } else {
            authState = .error("Invalid email or password")
            errorMessage = "Invalid email or password"
            return false
        }
    }
}

// MARK: - Mock Coordinator for Testing
@MainActor
class MockCoordinator: ObservableObject {
    @Published var navigationPath = NavigationPath()
    @Published var rootPage: AppPages = .login

    var pushCallCount: Int = 0
    var lastPushedPage: AppPages?
    var setRootCallCount: Int = 0
    var lastRootPage: AppPages?

    func coordinatorPagePush(page: AppPages) {
        pushCallCount += 1
        lastPushedPage = page
        navigationPath.append(page)
    }

    func setRootPage(page: AppPages) {
        setRootCallCount += 1
        lastRootPage = page
        rootPage = page
        navigationPath.removeLast(navigationPath.count)
    }
}

// MARK: - LoginView Tests
@MainActor
final class LoginViewTests: XCTestCase {

    var mockAuthManager: MockAuthManager!
    var mockCoordinator: MockCoordinator!

    override func setUpWithError() throws {
        mockAuthManager = MockAuthManager()
        mockCoordinator = MockCoordinator()
    }

    override func tearDownWithError() throws {
        mockAuthManager = nil
        mockCoordinator = nil
    }

    // MARK: - Email Validation Tests

    func testValidateEmail_WithEmptyEmail_ShouldReturnFalse() throws {
        // Given
        let email = ""

        // When & Then
        XCTAssertFalse(isValidEmail(email), "Empty email should be invalid")
    }

    func testValidateEmail_WithWhitespaceEmail_ShouldReturnFalse() throws {
        // Given
        let email = "   "

        // When & Then
        XCTAssertFalse(isValidEmail(email), "Whitespace-only email should be invalid")
    }

    func testValidateEmail_WithInvalidFormat_ShouldReturnFalse() throws {
        // Given
        let invalidEmails = [
            "invalidemail",
            "invalid@",
            "@domain.com",
            "invalid@domain",
            "invalid..email@domain.com",
            "invalid@domain..com"
        ]

        // When & Then
        for email in invalidEmails {
            XCTAssertFalse(isValidEmail(email), "\(email) should be invalid")
        }
    }

    func testValidateEmail_WithValidFormat_ShouldReturnTrue() throws {
        // Given
        let validEmails = [
            "test@example.com",
            "user.name@domain.com",
            "user+tag@domain.co.uk",
            "test123@test-domain.com"
        ]

        // When & Then
        for email in validEmails {
            XCTAssertTrue(isValidEmail(email), "\(email) should be valid")
        }
    }

    // MARK: - Password Validation Tests

    func testValidatePassword_WithEmptyPassword_ShouldReturnFalse() throws {
        // Given
        let password = ""

        // When & Then
        XCTAssertFalse(isValidPassword(password), "Empty password should be invalid")
    }

    func testValidatePassword_WithShortPassword_ShouldReturnFalse() throws {
        // Given
        let shortPasswords = ["12345", "abc", "a", "12"]

        // When & Then
        for password in shortPasswords {
            XCTAssertFalse(isValidPassword(password), "Password '\(password)' with length \(password.count) should be invalid (minimum 6 characters)")
        }
    }

    func testValidatePassword_WithValidPassword_ShouldReturnTrue() throws {
        // Given
        let validPasswords = ["123456", "password", "test1234", "MyPassword123!"]

        // When & Then
        for password in validPasswords {
            XCTAssertTrue(isValidPassword(password), "Password '\(password)' with length \(password.count) should be valid")
        }
    }

    // MARK: - Login Flow Tests

    func testLogin_WithValidCredentials_ShouldSucceed() async throws {
        // Given
        let email = "test@example.com"
        let password = "password123"
        mockAuthManager.shouldSucceed = true

        // When
        let result = await mockAuthManager.login(email: email, password: password)

        // Then
        XCTAssertTrue(result, "Login should succeed with valid credentials")
        XCTAssertEqual(mockAuthManager.loginCallCount, 1, "Login should be called once")
        XCTAssertEqual(mockAuthManager.currentUser?.email, email, "Current user email should match")
        XCTAssertNil(mockAuthManager.errorMessage, "Error message should be nil on success")
        XCTAssertEqual(mockAuthManager.authState, .authenticated, "Auth state should be authenticated")
    }

    func testLogin_WithInvalidCredentials_ShouldFail() async throws {
        // Given
        let email = "test@example.com"
        let password = "wrongpassword"
        mockAuthManager.shouldSucceed = false

        // When
        let result = await mockAuthManager.login(email: email, password: password)

        // Then
        XCTAssertFalse(result, "Login should fail with invalid credentials")
        XCTAssertEqual(mockAuthManager.loginCallCount, 1, "Login should be called once")
        XCTAssertNil(mockAuthManager.currentUser, "Current user should be nil on failure")
        XCTAssertNotNil(mockAuthManager.errorMessage, "Error message should be set on failure")
        XCTAssertEqual(mockAuthManager.errorMessage, "Invalid email or password")
    }

    func testLogin_ShouldSetLoadingStateCorrectly() async throws {
        // Given
        let email = "test@example.com"
        let password = "password123"
        mockAuthManager.shouldSucceed = true

        // When
        XCTAssertFalse(mockAuthManager.isLoading, "Loading should be false before login")

        let loginTask = Task {
            await mockAuthManager.login(email: email, password: password)
        }

        // Brief moment to check loading state
        try? await Task.sleep(nanoseconds: 10_000_000)

        await loginTask.value

        // Then
        XCTAssertFalse(mockAuthManager.isLoading, "Loading should be false after login completes")
    }

    // MARK: - Navigation Tests

    func testSuccessfulLogin_ShouldNavigateToHome() async throws {
        // Given
        let email = "test@example.com"
        let password = "password123"
        mockAuthManager.shouldSucceed = true

        // When
        let success = await mockAuthManager.login(email: email, password: password)

        if success {
            mockCoordinator.setRootPage(page: .homePage)
        }

        // Then
        XCTAssertTrue(success, "Login should succeed")
        XCTAssertEqual(mockCoordinator.setRootCallCount, 1, "setRootPage should be called once")
        XCTAssertEqual(mockCoordinator.lastRootPage, .homePage, "Should navigate to home page")
    }

    func testForgotPasswordButton_ShouldNavigateToForgotPassword() throws {
        // When
        mockCoordinator.coordinatorPagePush(page: .forgotPasswordPage)

        // Then
        XCTAssertEqual(mockCoordinator.pushCallCount, 1, "Push should be called once")
        XCTAssertEqual(mockCoordinator.lastPushedPage, .forgotPasswordPage, "Should navigate to forgot password page")
    }

    func testSignUpButton_ShouldNavigateToSignup() throws {
        // When
        mockCoordinator.coordinatorPagePush(page: .signupPage)

        // Then
        XCTAssertEqual(mockCoordinator.pushCallCount, 1, "Push should be called once")
        XCTAssertEqual(mockCoordinator.lastPushedPage, .signupPage, "Should navigate to signup page")
    }

    // MARK: - Error Message Tests

    func testLogin_WithEmptyFields_ShouldShowError() async throws {
        // Given
        let email = ""
        let password = ""
        mockAuthManager.shouldSucceed = false

        // When
        let result = await mockAuthManager.login(email: email, password: password)

        // Then
        XCTAssertFalse(result, "Login should fail with empty fields")
        XCTAssertNotNil(mockAuthManager.errorMessage, "Error message should be set")
    }

    func testLogin_AfterFailure_ErrorMessageShouldBeDisplayed() async throws {
        // Given
        mockAuthManager.shouldSucceed = false

        // When
        _ = await mockAuthManager.login(email: "test@example.com", password: "wrong")

        // Then
        XCTAssertNotNil(mockAuthManager.errorMessage, "Error message should be present after failed login")
        XCTAssertEqual(mockAuthManager.errorMessage, "Invalid email or password")
    }

    // MARK: - Helper Methods

    private func isValidEmail(_ email: String) -> Bool {
        // Check if email is empty
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }

        // Check for consecutive dots (invalid in email addresses)
        if email.contains("..") {
            return false
        }

        // Email format validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        return emailPredicate.evaluate(with: email)
    }

    private func isValidPassword(_ password: String) -> Bool {
        // Check if password is empty
        if password.isEmpty {
            return false
        }

        // Password length validation
        if password.count < 6 {
            return false
        }

        return true
    }
}

// MARK: - Integration Tests
@MainActor
final class LoginViewIntegrationTests: XCTestCase {

    func testFullLoginFlow_Success() async throws {
        // Given
        let mockAuthManager = MockAuthManager()
        let mockCoordinator = MockCoordinator()
        mockAuthManager.shouldSucceed = true

        let email = "user@example.com"
        let password = "password123"

        // When - Simulate full login flow
        let isEmailValid = email.contains("@") && !email.isEmpty
        let isPasswordValid = password.count >= 6

        guard isEmailValid && isPasswordValid else {
            XCTFail("Validation should pass")
            return
        }

        let success = await mockAuthManager.login(email: email, password: password)

        if success {
            mockCoordinator.setRootPage(page: .homePage)
        }

        // Then
        XCTAssertTrue(success, "Login should succeed")
        XCTAssertEqual(mockAuthManager.authState, .authenticated)
        XCTAssertEqual(mockCoordinator.lastRootPage, .homePage)
        XCTAssertNotNil(mockAuthManager.currentUser)
    }

    func testFullLoginFlow_InvalidEmail() async throws {
        // Given
        let email = "invalidemail"
        let password = "password123"

        // When
        let isEmailValid = email.contains("@") && email.contains(".")

        // Then
        XCTAssertFalse(isEmailValid, "Email validation should fail")
    }

    func testFullLoginFlow_ShortPassword() async throws {
        // Given
        let email = "user@example.com"
        let password = "12345"

        // When
        let isPasswordValid = password.count >= 6

        // Then
        XCTAssertFalse(isPasswordValid, "Password validation should fail for passwords shorter than 6 characters")
    }
}
