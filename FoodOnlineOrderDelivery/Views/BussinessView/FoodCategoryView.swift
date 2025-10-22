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
    @State private var openRestaurants: [Restaurant] = []

    let selectedKeyword: String
    let dataManager = CategoryDataManager.shared
    let restaurantManager = SuggestedRestaurantsManager.shared

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
                VStack(alignment: .leading, spacing: 20) {
                    // Food Items Section Header
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

                    // Open Restaurants Section
                    if !openRestaurants.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            // Section Header
                            HStack {
                                Text("Open Restaurants")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)

                                Spacer()

                                Text("\(openRestaurants.count) available")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal, 20)

                            // Restaurant List
                            VStack(spacing: 12) {
                                ForEach(openRestaurants) { restaurant in
                                    RestaurantListCard(
                                        restaurant: restaurant,
                                        onTap: {
                                            handleRestaurantTap(restaurant: restaurant)
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 8)
                    }

                    Spacer(minLength: 20)
                }
                .padding(.bottom, 20)
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .onAppear {
            loadOpenRestaurants()
        }
    }

    // MARK: - Data Loading
    private func loadOpenRestaurants() {
        openRestaurants = restaurantManager.getOpenRestaurants()
    }

    // MARK: - Actions
    private func handleAddToCart(foodItem: FoodItem) {
        print("Added to cart: \(foodItem.name)")
        // TODO: Implement cart functionality
        cartItemCount += 1
    }

    private func handleRestaurantTap(restaurant: Restaurant) {
        print("Restaurant tapped: \(restaurant.name)")
        // TODO: Navigate to restaurant details page
    }
}

#Preview {
    FoodCategoryView(selectedKeyword: "Pizza")
        .environmentObject(Coordinator())
}

