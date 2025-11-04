//
//  DataManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Claude Code on 11/04/25.
//

import Foundation
import SwiftData

@MainActor
class DataManager {
    static let shared = DataManager()

    var modelContainer: ModelContainer?
    var modelContext: ModelContext?

    private init() {
        setupContainer()
    }

    private func setupContainer() {
        let schema = Schema([
            UserAccount.self
        ])

        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            modelContext = ModelContext(modelContainer!)
        } catch {
            print("Failed to create ModelContainer: \(error)")
        }
    }

    // MARK: - User Operations

    /// Create a new user account
    func createUser(email: String, name: String, phoneNumber: String, password: String) throws -> UserAccount {
        guard let context = modelContext else {
            throw DataError.contextNotAvailable
        }

        // Check if user already exists
        let fetchDescriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.email == email }
        )

        let existingUsers = try context.fetch(fetchDescriptor)
        if !existingUsers.isEmpty {
            throw DataError.userAlreadyExists
        }

        // Create new user
        let passwordHash = password.simpleHash()
        let newUser = UserAccount(
            email: email,
            name: name,
            phoneNumber: phoneNumber,
            passwordHash: passwordHash
        )

        context.insert(newUser)
        try context.save()

        print("✅ User created successfully: \(email)")
        return newUser
    }

    /// Find user by email
    func findUser(byEmail email: String) throws -> UserAccount? {
        guard let context = modelContext else {
            throw DataError.contextNotAvailable
        }

        let fetchDescriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.email == email }
        )

        let users = try context.fetch(fetchDescriptor)
        return users.first
    }

    /// Authenticate user with email and password
    func authenticateUser(email: String, password: String) throws -> UserAccount? {
        guard let user = try findUser(byEmail: email) else {
            return nil
        }

        // Verify password
        guard password.verifyHash(user.passwordHash) else {
            return nil
        }

        // Update last login time
        user.lastLoginAt = Date()
        try modelContext?.save()

        return user
    }

    /// Update user verification status
    func updateUserVerification(userId: String, isVerified: Bool) throws {
        guard let context = modelContext else {
            throw DataError.contextNotAvailable
        }

        let fetchDescriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.id == userId }
        )

        guard let user = try context.fetch(fetchDescriptor).first else {
            throw DataError.userNotFound
        }

        user.isVerified = isVerified
        try context.save()

        print("✅ User verification updated: \(isVerified)")
    }

    /// Update user profile
    func updateUserProfile(userId: String, name: String?, phoneNumber: String?, profileImageURL: String?) throws {
        guard let context = modelContext else {
            throw DataError.contextNotAvailable
        }

        let fetchDescriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.id == userId }
        )

        guard let user = try context.fetch(fetchDescriptor).first else {
            throw DataError.userNotFound
        }

        if let name = name {
            user.name = name
        }
        if let phoneNumber = phoneNumber {
            user.phoneNumber = phoneNumber
        }
        if let profileImageURL = profileImageURL {
            user.profileImageURL = profileImageURL
        }

        try context.save()
        print("✅ User profile updated")
    }

    /// Delete user account
    func deleteUser(userId: String) throws {
        guard let context = modelContext else {
            throw DataError.contextNotAvailable
        }

        let fetchDescriptor = FetchDescriptor<UserAccount>(
            predicate: #Predicate { $0.id == userId }
        )

        guard let user = try context.fetch(fetchDescriptor).first else {
            throw DataError.userNotFound
        }

        context.delete(user)
        try context.save()

        print("✅ User deleted: \(userId)")
    }

    /// Get all users (for debugging)
    func getAllUsers() throws -> [UserAccount] {
        guard let context = modelContext else {
            throw DataError.contextNotAvailable
        }

        let fetchDescriptor = FetchDescriptor<UserAccount>()
        return try context.fetch(fetchDescriptor)
    }
}

// MARK: - Data Errors
enum DataError: LocalizedError {
    case contextNotAvailable
    case userAlreadyExists
    case userNotFound
    case saveFailed

    var errorDescription: String? {
        switch self {
        case .contextNotAvailable:
            return "Database context is not available"
        case .userAlreadyExists:
            return "A user with this email already exists"
        case .userNotFound:
            return "User not found"
        case .saveFailed:
            return "Failed to save data"
        }
    }
}
