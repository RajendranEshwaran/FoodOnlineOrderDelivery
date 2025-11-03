//
//  LocalizationManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 11/03/25.
//

import Foundation
import SwiftUI
import Combine

class LocalizationManager: ObservableObject {
    static let shared = LocalizationManager()

    @Published var currentLanguage: String {
        didSet {
            UserDefaults.standard.set(currentLanguage, forKey: "AppLanguage")
            // Force update for all views
            objectWillChange.send()
        }
    }

    private var bundle: Bundle?

    private init() {
        // Load saved language or default to system language
        let savedLanguage = UserDefaults.standard.string(forKey: "AppLanguage")
        self.currentLanguage = savedLanguage ?? Locale.current.language.languageCode?.identifier ?? "en"
        self.updateBundle()
    }

    private func updateBundle() {
        if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            self.bundle = bundle
        } else {
            // Fallback to main bundle
            self.bundle = Bundle.main
        }
    }

    func localizedString(_ key: String, comment: String = "") -> String {
        updateBundle()
        return bundle?.localizedString(forKey: key, value: nil, table: nil) ?? NSLocalizedString(key, comment: comment)
    }

    func setLanguage(_ languageCode: String) {
        currentLanguage = languageCode
        updateBundle()
    }

    var availableLanguages: [(code: String, name: String)] {
        return [
            ("en", "English"),
            ("es", "Español")
        ]
    }

    func getLanguageName(for code: String) -> String {
        return availableLanguages.first(where: { $0.code == code })?.name ?? code
    }
}

// Helper for easy localization in SwiftUI
extension String {
    func localized(comment: String = "") -> String {
        return LocalizationManager.shared.localizedString(self, comment: comment)
    }
}
