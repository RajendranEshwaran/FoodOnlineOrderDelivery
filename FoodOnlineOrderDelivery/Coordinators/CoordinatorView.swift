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
    var body: some View {
        NavigationStack(path: $coordinator.navigationPath) {
            coordinator.currentAppView(view: AppPages.loginPage)
                .navigationDestination(for: AppPages.self) { page in
                    coordinator.currentAppView(view: page)
                }
            
                .sheet(item: $coordinator.currentSheets) { sheet in
                    coordinator.currentAppSheetView(sheet: sheet)
                }
            
                .fullScreenCover(item: $coordinator.currentFullCover){ fullcover in
                    coordinator.currentAppFullCoverView(fullcover: fullcover)
                }
        }.environmentObject(coordinator)
    }
}
