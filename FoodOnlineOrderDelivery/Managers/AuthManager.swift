//
//  AuthManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/16/25.
//

import Foundation
import SwiftUI
import Combine

enum AuthState: Hashable {
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
    @Published var generatedCode: String = "" // Store the generated code for verification

    // Track if user is new (from signup) or existing (from login)
    @Published var isNewUser: Bool = false

    // Singleton instance
    static let shared = AuthManager()

    private init() {}

    // MARK: - Authentication Methods

    /// Sign up with email, name, phone number, and password
    func signup(email: String, name: String, phoneNumber: String, password: String) async -> Bool {
        await MainActor.run {
            isLoading = true
            authState = .verifying
            errorMessage = nil
            isNewUser = true // New user signing up
        }

        // Simulate API call
        try? await Task.sleep(nanoseconds: 1_000_000_000)

        // Validate inputs
        guard !email.isEmpty, !name.isEmpty, !phoneNumber.isEmpty, !password.isEmpty else {
            await MainActor.run {
                authState = .error("All fields are required")
                errorMessage = "All fields are required"
                isLoading = false
            }
            return false
        }

        // Create user in database
        do {
            let userAccount = try await DataManager.shared.createUser(email: email, name: name, phoneNumber: phoneNumber, password: password)

            await MainActor.run {
                currentUser = userAccount.toUser()
                isLoading = false
                print("✅ Signup successful for: \(email)")
            }

            return true
        } catch DataError.userAlreadyExists {
            await MainActor.run {
                authState = .error("User with this email already exists")
                errorMessage = "User with this email already exists"
                isLoading = false
            }
            return false
        } catch {
            await MainActor.run {
                authState = .error("Signup failed: \(error.localizedDescription)")
                errorMessage = "Signup failed. Please try again."
                isLoading = false
            }
            return false
        }
    }

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

        // Validate credentials
        guard !email.isEmpty, !password.isEmpty else {
            await MainActor.run {
                authState = .error("Email and password cannot be empty")
                errorMessage = "Email and password cannot be empty"
                isLoading = false
            }
            return false
        }

        // Authenticate user from database
        do {
            if let userAccount = try await DataManager.shared.authenticateUser(email: email, password: password) {
                await MainActor.run {
                    authState = .authenticated
                    currentUser = userAccount.toUser()
                    isLoading = false
                    print("✅ Login successful for: \(email)")
                }
                return true
            } else {
                await MainActor.run {
                    authState = .error("Invalid email or password")
                    errorMessage = "Invalid email or password"
                    isLoading = false
                }
                return false
            }
        } catch {
            await MainActor.run {
                authState = .error("Login failed: \(error.localizedDescription)")
                errorMessage = "Login failed. Please try again."
                isLoading = false
            }
            return false
        }
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

        // Verification logic - check against generated code
        let isValid = fullCode == generatedCode

        if isValid {
            // Update verification status in database first
            if let userId = currentUser?.id {
                do {
                    try await DataManager.shared.updateUserVerification(userId: userId, isVerified: true)
                    print("✅ Verification successful and saved to database!")
                } catch {
                    print("⚠️ Verification successful but failed to update database: \(error)")
                }
            }

            // Update UI state
            await MainActor.run {
                isVerified = true
                authState = .authenticated
                verificationCode = fullCode
                isLoading = false
            }
        } else {
            await MainActor.run {
                errorMessage = VerificationError.invalidCode.errorDescription
                isLoading = false
            }
            print("❌ Verification failed. Expected: \(generatedCode), Got: \(fullCode)")
            throw VerificationError.invalidCode
        }

        return isValid
    }

    /// Send verification code to email
    func sendVerificationCode(to email: String) async -> Bool {
        await MainActor.run {
            isLoading = true
            errorMessage = nil
            // Generate and store the code
            generatedCode = generateCode()
            print("📧 Verification code sent to \(email): \(generatedCode)")
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

    /// Generate a 4-digit random verification code
    func generateCode() -> String {
        let randomNumber = Int.random(in: 1000...9999)
        return String(randomNumber)
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
        generatedCode = ""
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
