//
//  CoordinatorView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/14/25.
//

import Foundation
import SwiftUI

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()
    @StateObject private var authManager = AuthManager.shared

    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            coordinator.currentAppView(view: coordinator.rootPage)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.currentAppView(view: page)
                        .environmentObject(coordinator)
                        .environmentObject(authManager)
                }

                .sheet(item: $coordinator.currentSheets) { sheet in
                    coordinator.currentAppSheetView(sheet: sheet)
                        .environmentObject(coordinator)
                        .environmentObject(authManager)
                }

                .fullScreenCover(item: $coordinator.currentFullCover){ fullcover in
                    coordinator.currentAppFullCoverView(fullcover: fullcover)
                        .environmentObject(coordinator)
                        .environmentObject(authManager)
                }
        }
        .environmentObject(coordinator)
        .environmentObject(authManager)
    }
}
