//
//  HomeView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/16/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var authManager: AuthManager
    @State private var cartItemCount: Int = 3
    @State private var showMenu: Bool = false
    @State private var selectedCategory: String = "All"

    let dataManager = CategoryDataManager.shared

    // Computed property for time-based greeting
    private var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        default:
            return "Good Evening"
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: authManager.currentUser?.name ?? "User",
                cartItemCount: cartItemCount,
                isMenuEnable: true,
                onMenuTap: {
                    showMenu.toggle()
                    print("Menu tapped")
                },
                onCartTap: {
                    coordinator.coordinatorPagePush(page: .cartPage)
                }
            )

            // Main Content Area
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Greeting Section
                    HStack(spacing: 8) {
                        Text("Hey \(authManager.currentUser?.name ?? "User"),")
                            .font(.body)
                            .foregroundColor(.black)

                        Text(greetingMessage)
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                    // Search Bar
                    Button(action: {
                        coordinator.coordinatorPagePush(page: .searchPage)
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .font(.body)

                            Text("Search dishes, restaurants")
                                .font(.body)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)

                    // All Categories Section
                    VStack(alignment: .leading, spacing: 12) {
                        // Header with "See All"
                        HStack {
                            Text("All Categories")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)

                            Spacer()

                            Button(action: {
                                print("See All tapped")
                            }) {
                                HStack(spacing: 4) {
                                    Text("See All")
                                        .font(.subheadline)
                                        .foregroundColor(Color("ButtonColor"))

                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                        .foregroundColor(Color("ButtonColor"))
                                }
                            }
                        }
                        .padding(.horizontal, 20)

                        // Horizontal Category Scroll
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(dataManager.categories) { category in
                                    CategoryItem(
                                        title: category.name,
                                        isSelected: selectedCategory == category.name,
                                        action: {
                                            selectedCategory = category.name
                                            print("\(category.name) selected")
                                        }, icon: category.image
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    // Food Items Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Popular Dishes")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)

                        // Display food items based on selected category
                        let foodItems = dataManager.getFoodItems(for: selectedCategory)

                        ForEach(foodItems) { item in
                            FoodItemCard(foodItem: item)
                                .padding(.horizontal, 20)
                        }
                    }

                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color(UIColor.white))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    HomeView()
}
