//
//  FoodOnlineOrderDeliveryApp.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/14/25.
//

import SwiftUI
import SwiftData

@main
struct FoodOnlineOrderDeliveryApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            UserAccount.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            let container = try ModelContainer(for: schema, configurations: [modelConfiguration])

            // Initialize DataManager with the shared container
            Task { @MainActor in
                DataManager.shared.modelContainer = container
                DataManager.shared.modelContext = ModelContext(container)
                print("✅ SwiftData initialized successfully")
            }

            return container
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            CoordinatorView()
        }
        .modelContainer(sharedModelContainer)
    }
}
