//
//  FavouriteView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/27/25.
//

import SwiftUI

struct FavouriteView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State private var cartItemCount = 0
    @State private var favouriteFoodItems: [FoodItem] = []

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: "Favourites",
                cartItemCount: cartItemCount,
                isMenuEnable: false,
                isBackEnable: true,
                isUserInfo: false,
                isCartEnable: false,
                onCartTap: {
                    coordinator.coordinatorPagePush(page: .cartPage)
                },
                onBackTap: {
                    coordinator.coordinatorPopToPage()
                }
            )

            // Favourites List
            if favouriteFoodItems.isEmpty {
                EmptyFavouritesView()
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(favouriteFoodItems) { item in
                            FavouriteFoodCard(
                                foodItem: item,
                                onRemoveTapped: {
                                    removeFavourite(item)
                                },
                                onCardTapped: {
                                    print("Tapped: \(item.name)")
                                    // TODO: Navigate to food detail
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                }
            }

            Spacer()
        }
        .navigationBarHidden(true)
        .onAppear {
            loadFavourites()
        }
    }

    private func loadFavourites() {
        // Sample data - replace with actual data from backend or local storage
        favouriteFoodItems = [
            FoodItem(
                name: "Margherita Pizza",
                description: "Classic Italian pizza with fresh mozzarella and basil",
                price: 12.99,
                image: "pizza1",
                rating: 4.8,
                reviewCount: 245,
                restaurantName: "Pizza Palace",
                deliveryTime: "25-35 min",
                category: "Pizza"
            ),
            FoodItem(
                name: "Classic Cheeseburger",
                description: "Juicy beef patty with cheese, lettuce, and tomato",
                price: 9.99,
                image: "burger1",
                rating: 4.5,
                reviewCount: 189,
                restaurantName: "Burger Barn",
                deliveryTime: "20-30 min",
                category: "Burger"
            ),
            FoodItem(
                name: "California Roll",
                description: "Fresh sushi roll with crab, avocado, and cucumber",
                price: 14.50,
                image: "sushi1",
                rating: 4.7,
                reviewCount: 156,
                restaurantName: "Sushi House",
                deliveryTime: "30-40 min",
                category: "Sushi"
            ),
            FoodItem(
                name: "Chicken Tacos",
                description: "Three soft tacos with grilled chicken and salsa",
                price: 8.99,
                image: "taco1",
                rating: 4.6,
                reviewCount: 203,
                restaurantName: "Taco Town",
                deliveryTime: "15-25 min",
                category: "Mexican"
            )
        ]
    }

    private func removeFavourite(_ item: FoodItem) {
        favouriteFoodItems.removeAll { $0.id == item.id }
        print("Removed from favourites: \(item.name)")
        // TODO: Update backend/local storage
    }
}


#Preview {
    FavouriteView()
        .environmentObject(Coordinator())
}
