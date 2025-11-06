//
//  UserAccountModel.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 11/04/25.
//

import Foundation
import SwiftData

@Model
final class UserAccount {
    @Attribute(.unique) var id: String
    var email: String
    var name: String
    var phoneNumber: String?
    var profileImageURL: String?
    var passwordHash: String
    var createdAt: Date
    var lastLoginAt: Date?
    var isVerified: Bool

    init(id: String = UUID().uuidString,
         email: String,
         name: String,
         phoneNumber: String? = nil,
         profileImageURL: String? = nil,
         passwordHash: String,
         createdAt: Date = Date(),
         lastLoginAt: Date? = nil,
         isVerified: Bool = false) {
        self.id = id
        self.email = email
        self.name = name
        self.phoneNumber = phoneNumber
        self.profileImageURL = profileImageURL
        self.passwordHash = passwordHash
        self.createdAt = createdAt
        self.lastLoginAt = lastLoginAt
        self.isVerified = isVerified
    }

    // Convert to User struct for compatibility with existing code
    func toUser() -> User {
        return User(
            id: id,
            email: email,
            name: name,
            phoneNumber: phoneNumber,
            profileImageURL: profileImageURL
        )
    }
}

// Simple password hashing (for demo purposes - use proper encryption in production)
extension String {
    func simpleHash() -> String {
        // In production, use proper hashing like bcrypt or CryptoKit
        return self.data(using: .utf8)?.base64EncodedString() ?? ""
    }

    func verifyHash(_ hash: String) -> Bool {
        return self.simpleHash() == hash
    }
}
