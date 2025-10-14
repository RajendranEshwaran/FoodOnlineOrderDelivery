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
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
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
