//
//  FoodView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import SwiftUI

struct FoodView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @State private var cartItemCount: Int = 3

    let foodItem: FoodItem

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: "Food Details",
                cartItemCount: cartItemCount,
                isMenuEnable: false,
                isBackEnable: true,
                isUserInfo: false,
                onCartTap: {
                    coordinator.coordinatorPagePush(page: .cartPage)
                }, onBackTap: {
                    coordinator.coordinatorPopToPage()
                })
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }
}

#Preview {
    FoodView(foodItem: FoodItem(
        name: "Classic Cheeseburger",
        description: "Beef patty with cheese, lettuce, tomato, and special sauce",
        price: 9.99,
        image: "burger1",
        rating: 4.6,
        reviewCount: 200,
        restaurantName: "Burger Palace",
        deliveryTime: "20-25 min",
        category: "Burger"
    ))
}
