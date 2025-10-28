//
//  AuthManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/16/25.
//

import Foundation
import SwiftUI
import Combine

enum AuthState {
    case unauthenticated
    case authenticated
    case verifying
    case error(String)
}

enum VerificationError: LocalizedError {
    case invalidCode
    case codeExpired
    case networkError
    case emptyCode

    var errorDescription: String? {
        switch self {
        case .invalidCode:
            return "Invalid verification code. Please try again."
        case .codeExpired:
            return "Verification code has expired. Please request a new one."
        case .networkError:
            return "Network error. Please check your connection."
        case .emptyCode:
            return "Please enter the complete verification code."
        }
    }
}

class AuthManager: ObservableObject {
    @Published var authState: AuthState = .unauthenticated
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var currentUser: User?

    // Verification properties
    @Published var verificationCode: String = ""
    @Published var isVerified: Bool = false

    // Track if user is new (from signup) or existing (from login)
    @Published var isNewUser: Bool = false

    // Singleton instance
    static let shared = AuthManager()

    private init() {}

    // MARK: - Authentication Methods

    /// Login with email and password
    func login(email: String, password: String) async -> Bool {
        await MainActor.run {
            isLoading = true
            authState = .verifying
            errorMessage = nil
            isNewUser = false // Existing user logging in
        }

        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        // Validate credentials (mock implementation)
        guard !email.isEmpty, !password.isEmpty else {
            await MainActor.run {
                authState = .error("Email and password cannot be empty")
                errorMessage = "Email and password cannot be empty"
                isLoading = false
            }
            return false
        }

        await MainActor.run {
            authState = .authenticated
            currentUser = User(id: UUID().uuidString, email: email, name: "User")
            isLoading = false
        }

        return true
    }

    /// Verify code with 4-digit verification code
    func verifyCode(_ code1: String, _ code2: String, _ code3: String, _ code4: String) async throws -> Bool {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }

        let fullCode = code1 + code2 + code3 + code4

        // Validate code is complete
        guard fullCode.count == 4 else {
            await MainActor.run {
                errorMessage = VerificationError.emptyCode.errorDescription
                isLoading = false
            }
            throw VerificationError.emptyCode
        }

        // Validate all are digits
        guard fullCode.allSatisfy({ $0.isNumber }) else {
            await MainActor.run {
                errorMessage = VerificationError.invalidCode.errorDescription
                isLoading = false
            }
            throw VerificationError.invalidCode
        }

        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_500_000_000)

        // Mock verification logic (you can replace with actual API call)
        let isValid = fullCode == "1234" // Mock: accept "1234" as valid code

        try await MainActor.run {
            if isValid {
                isVerified = true
                authState = .authenticated
                verificationCode = fullCode
            } else {
                errorMessage = VerificationError.invalidCode.errorDescription
                throw VerificationError.invalidCode
            }
            isLoading = false
        }

        return isValid
    }

    /// Send verification code to email
    func sendVerificationCode(to email: String) async -> Bool {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }

        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        // Mock implementation
        await MainActor.run {
            isLoading = false
        }

        return true
    }

    /// Resend verification code
    func resendVerificationCode() async -> Bool {
        await sendVerificationCode(to: currentUser?.email ?? "")
    }

    /// Reset password
    func resetPassword(email: String) async -> Bool {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
        }

        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        await MainActor.run {
            isLoading = false
        }

        return true
    }

    /// Logout user
    func logout() {
        authState = .unauthenticated
        currentUser = nil
        isVerified = false
        verificationCode = ""
        errorMessage = nil
    }

    /// Check if user is authenticated
    var isAuthenticated: Bool {
        if case .authenticated = authState {
            return true
        }
        return false
    }
}

// MARK: - User Model
struct User: Codable, Identifiable {
    let id: String
    let email: String
    let name: String
    var phoneNumber: String?
    var profileImageURL: String?
}
