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
    @ObservedObject private var cartManager = CartManager.shared
    @State private var showMenu: Bool = false
    @State private var selectedCategory: String = "All"
    @State private var displayedItems: [FoodItem] = []
    @State private var isLoadingMore: Bool = false

    let dataManager = CategoryDataManager.shared
    private let itemsPerPage = 20
    
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
                cartItemCount: cartManager.itemCount,
                isMenuEnable: true,
                onMenuTap: {
                    showMenu.toggle()
                },
                onCartTap: {
                    coordinator.coordinatorPagePush(page: .cartPage)
                }
            )
            // Greeting Section
            HStack(spacing: 8) {
                Text("Hey \(authManager.currentUser?.name ?? "User"),")
                    .font(.body)
                    .foregroundColor(.black)

                Text(greetingMessage)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Spacer()
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
            
            // Main Content Area
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
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
                            LazyHStack(spacing: 12) {
                                ForEach(dataManager.categories) { category in
                                    CategoryItem(
                                        title: category.name,
                                        isSelected: selectedCategory == category.name,
                                        action: {
                                            selectedCategory = category.name
                                            loadItems()
                                        }, icon: category.image
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    // Food Items Section
                    LazyVStack(alignment: .leading, spacing: 16, pinnedViews: []) {
                        Text("Popular Dishes")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)

                        // Display food items based on selected category
                        ForEach(displayedItems) { item in
                            Button(action: {
                                coordinator.coordinatorPagePush(page: .foodDetailPage(foodItem: item))
                            }) {
                                FoodItemCard(foodItem: item)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.horizontal, 20)
                            .onAppear {
                                // Load more when reaching near the end
                                if item.id == displayedItems.last?.id {
                                    loadMoreItems()
                                }
                            }
                        }

                        if isLoadingMore {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .onAppear {
                loadItems()
                // Pre-load popular categories in background
                dataManager.preloadCategories(["Burger", "Pizza", "Sandwich"])
            }
        }
        .background(Color(UIColor.white))
        .ignoresSafeArea(edges: .bottom)
        .overlay(
            Group {
                if showMenu {
                    HamburgerMenuView(
                        isPresented: $showMenu,
                        profileImage: "",
                        userName: authManager.currentUser?.name ?? "User",
                        userStatus: "Active",
                        onLogout: {
                            // Handle logout
                            authManager.logout()
                        }
                    )
                    .transition(.move(edge: .leading))
                    .zIndex(100)
                }
            }
        )
        .animation(.easeInOut(duration: 0.3), value: showMenu)
    }

    // MARK: - Helper Methods
    private func loadItems() {
        // Reset displayed items
        displayedItems = []

        // Load items for selected category with initial limit
        DispatchQueue.global(qos: .userInitiated).async {
            let items = dataManager.getFoodItems(for: selectedCategory, limit: itemsPerPage)

            DispatchQueue.main.async {
                displayedItems = items
            }
        }
    }

    private func loadMoreItems() {
        guard !isLoadingMore else { return }

        isLoadingMore = true

        DispatchQueue.global(qos: .background).async {
            // Get all items for the category
            let allItems = dataManager.getFoodItems(for: selectedCategory)

            // Check if there are more items to load
            let currentCount = displayedItems.count

            if currentCount < allItems.count {
                let nextBatch = Array(allItems[currentCount..<min(currentCount + itemsPerPage, allItems.count)])

                DispatchQueue.main.async {
                    displayedItems.append(contentsOf: nextBatch)
                    isLoadingMore = false
                }
            } else {
                DispatchQueue.main.async {
                    isLoadingMore = false
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
