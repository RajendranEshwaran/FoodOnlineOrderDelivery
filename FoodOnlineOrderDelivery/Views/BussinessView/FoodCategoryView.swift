//
//  FoodCategoryView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import SwiftUI

struct FoodCategoryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @State private var cartItemCount: Int = 3
    let categoryName: String

    var body: some View {
        VStack {
            // Top Panel
            TopPanel(
                userName: categoryName,
                cartItemCount: cartItemCount,
                isMenuEnable: false,
                isBackEnable: true,
                isUserInfo: false,
                onCartTap: {
                    print("Cart tapped")
                }, onBackTap: {
                    coordinator.coordinatorPopToPage()
                })
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    FoodCategoryView(categoryName: "Burger")
}
