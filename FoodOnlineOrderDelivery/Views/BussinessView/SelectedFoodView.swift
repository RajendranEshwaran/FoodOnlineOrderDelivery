//
//  SelectedFoodView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI

struct SelectedFoodView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @State private var cartItemCount: Int = 3

    let selectedKeyword: String
    let dataManager = CategoryDataManager.shared

    // Filtered food items based on selected keyword
    private var filteredFoods: [FoodItem] {
        dataManager.getFoodItems(for: selectedKeyword)
    }

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: selectedKeyword,
                cartItemCount: cartItemCount,
                isMenuEnable: false,
                isBackEnable: true,
                isUserInfo: false,
                onCartTap: {
                    print("Cart tapped")
                }, onBackTap: {
                    coordinator.coordinatorPopToPage()
                }
            )

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Section Header
                    Text("\(filteredFoods.count) items found")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                    // Food Grid
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible(), spacing: 16),
                            GridItem(.flexible(), spacing: 16)
                        ],
                        spacing: 16
                    ) {
                        ForEach(filteredFoods) { foodItem in
                            FoodCard(
                                foodItem: foodItem,
                                onAddTapped: {
                                    handleAddToCart(foodItem: foodItem)
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }

    // MARK: - Actions
    private func handleAddToCart(foodItem: FoodItem) {
        print("Added to cart: \(foodItem.name)")
        // TODO: Implement cart functionality
        cartItemCount += 1
    }
}

#Preview {
    SelectedFoodView(selectedKeyword: "Pizza")
        .environmentObject(Coordinator())
}
