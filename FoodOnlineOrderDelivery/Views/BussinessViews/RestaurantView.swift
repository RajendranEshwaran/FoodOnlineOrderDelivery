//
//  RestaurantView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI

struct RestaurantView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject private var cartManager = CartManager.shared
    @State private var recentSearches: [String] = ["Pizza", "Burger", "Hot Dog", "Sandwich", "Dessert"]
    @State private var selectedSearch: String = ""
    let restaurant: Restaurant
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
                userName: "Restaurant",
                cartItemCount: cartManager.itemCount,
                isMenuEnable: false,
                isBackEnable: true,
                isUserInfo: false,
                onCartTap: {
                    coordinator.coordinatorPagePush(page: .cartPage)
                }, onBackTap: {
                    coordinator.coordinatorPopToPage()
                }
            )

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Restaurant Image
                    Image(restaurant.image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 20)

                    // Restaurant Details Section
                    VStack(alignment: .leading, spacing: 16) {
                        // Restaurant Name
                        Text(restaurant.name)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.top, 20)

                        // Rating, Delivery Option, and Delivery Time
                        HStack(spacing: 20) {
                            // Rating
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.orange)

                                Text(String(format: "%.1f", restaurant.rating))
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)
                            }

                            // Divider
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 4, height: 4)

                            // Delivery Option
                            HStack(spacing: 6) {
                                Image(systemName: "dollarsign.circle.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(restaurant.deliveryOption == .free ? .green : .orange)

                                Text(restaurant.deliveryOption.rawValue)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                            }

                            // Divider
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 4, height: 4)

                            // Delivery Duration
                            HStack(spacing: 6) {
                                Image(systemName: "clock.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.orange)

                                Text(restaurant.deliveryTime)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.black)
                            }
                        }

                        // Open Status Badge
                        HStack(spacing: 8) {
                            Circle()
                                .fill(restaurant.isOpen ? Color.green : Color.red)
                                .frame(width: 8, height: 8)

                            Text(restaurant.isOpen ? "Open Now" : "Closed")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(restaurant.isOpen ? .green : .red)
                            
                            // Bottom Action Button
                                Divider()
                                Spacer()
                                Button(action: {
                                    handleViewMenu()
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "list.bullet.rectangle")
                                            .font(.system(size: 16))

                                        Text("View Menu")
                                            .font(.system(size: 16, weight: .semibold))
                                    }
                                    .foregroundColor(.white)
                                    .frame(width: 200)
                                    .padding(.vertical, 16)
                                    .background(restaurant.isOpen ? Color.orange : Color.gray)
                                    .cornerRadius(12)
                                }
                                .disabled(!restaurant.isOpen)
                                .background(restaurant.isOpen ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                    
                        }
                        .padding(.vertical, 5)
                        .padding(.horizontal, 5)
                        .background(restaurant.isOpen ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
                        .cornerRadius(20)
//
//                        Divider()
//                            .padding(.vertical, 8)
/*
                        // Description Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("About")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)

                            Text("Welcome to \(restaurant.name)! We specialize in delivering delicious, high-quality food right to your doorstep. Our chefs prepare each dish with care using fresh ingredients to ensure the best taste and experience for our customers.")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .lineSpacing(6)
                        }
                        .padding(.vertical, 8)

                        Divider()
                            .padding(.vertical, 8)*/

                        // Recent Searches Section
                        VStack(alignment: .leading, spacing: 0) {
                            RecentSearchesView(
                                searches: recentSearches,
                                onSearchTapped: { search in
                                    self.selectedSearch = search
                                    handleSearchTapped(search: search)
                                },
                                onClearAll: {
                                    handleClearAllSearches()
                                }, isShowTitle: false,
                                isShowClearAll: false,
                                defaultSelection: self.selectedSearch
                            )
                        }
                        .padding(.bottom, 16)

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
                                            },
                                            onCardTapped: {
                                                handleFoodCardTap(foodItem: foodItem)
                                            }
                                        )
                                    }
                                }
                                .padding(.horizontal, 20)
                                Spacer(minLength: 20)
                            }
                            .padding(.bottom, 20)
                        }
                        
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 20)
            }

        }
        .background(Color.white)
        .navigationBarHidden(true)
    }

    // MARK: - Actions
    private func handleViewMenu() {
        print("View menu for: \(restaurant.name)")
        // TODO: Navigate to restaurant menu page
    }

    private func handleSearchTapped(search: String) {
        print("Search tapped: \(search)")
        coordinator.coordinatorPagePush(page: .foodCategoryPage(categoryName: search))
    }

    private func handleClearAllSearches() {
        print("Clear all searches")
        recentSearches.removeAll()
    }
    
    // MARK: - Actions
    private func handleAddToCart(foodItem: FoodItem) {
        print("Added to cart: \(foodItem.name)")
        cartManager.addItem(foodItem: foodItem, quantity: 1, size: "Medium")
    }

    private func handleFoodCardTap(foodItem: FoodItem) {
        print("Food card tapped: \(foodItem.name)")
        coordinator.coordinatorPagePush(page: .foodDetailPage(foodItem: foodItem))
    }
}

#Preview {
    RestaurantView(
        restaurant: Restaurant(
            name: "Pizza Paradise",
            image: "pizza1",
            rating: 4.7,
            deliveryTime: "25-30 min",
            isOpen: true,
            deliveryOption: .free
        ), selectedKeyword: "Pizza"
    )
    .environmentObject(Coordinator())
}
