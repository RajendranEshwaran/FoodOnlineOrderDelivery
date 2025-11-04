//
//  SearchView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @ObservedObject private var cartManager = CartManager.shared
    @State private var searchText: String = ""
    @State private var searchResults: [FoodItem] = []
    @FocusState private var isSearchFocused: Bool
    @State private var recentSearches: [String] = []
    @State private var suggestedRestaurants: [Restaurant] = []
    @State private var popularFastFoods: [PopularFastFood] = []
    let dataManager = CategoryDataManager.shared
    let restaurantManager = SuggestedRestaurantsManager.shared
    let fastFoodManager = PopularFastFoodManager.shared

    // Default category searches
    private let defaultRecentSearches = ["Hot Dog", "Burger", "Pizza", "Sandwich", "Dessert"]

    var body: some View {
        VStack(spacing: 0) {
            // Top Bar with Back Button and Title
            
            // Top Panel
            TopPanel(
                userName: "Search",
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
            ScrollView(.vertical, showsIndicators: false, content: {
                
                // Search Bar
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.body)
                    
                    TextField("Search dishes, restaurants", text: $searchText)
                        .font(.body)
                        .foregroundColor(.black)
                        .autocapitalization(.none)
                        .focused($isSearchFocused)
                        .onChange(of: searchText) { _, newValue in
                            performSearch(query: newValue)
                        }
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                            searchResults = []
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                                .font(.body)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 12)
                
                // Search Results
                if searchText.isEmpty {
                    // Empty State with Recent Searches
                    VStack(alignment: .leading, spacing: 20) {
                        // Recent Searches Section
                        if !recentSearches.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                HStack {
                                    Text("Recent Searches")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)

                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 12) {
                                        ForEach(recentSearches, id: \.self) { search in
                                            Button(action: {
                                                coordinator.coordinatorPagePush(page: .foodCategoryPage(categoryName: search))
                                            }) {
                                                HStack(spacing: 8) {
                                                    Image(systemName: "clock.arrow.circlepath")
                                                        .font(.caption)
                                                        .foregroundColor(.gray)

                                                    Text(search)
                                                        .font(.subheadline)
                                                        .foregroundColor(.black)
                                                }
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 8)
                                                .background(Color(UIColor.systemGray6))
                                                .cornerRadius(20)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 20)
                                }
                            }
                            .padding(.top, 20)
                        }
                        
                        // Suggested Restaurants Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Suggested Restaurants")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.top, recentSearches.isEmpty ? 20 : 0)

                            VStack(spacing: 12) {
                                ForEach(suggestedRestaurants.prefix(3)) { restaurant in
                                    RestaurantCard(restaurant: restaurant, onTap: {
                                        handleRestaurantTap(restaurant: restaurant)
                                    })
                                    .padding(.horizontal, 20)
                                }
                            }
                        }
                        
                        // Popular Fast Food Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Popular Fast Food")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.horizontal, 20)
                                .padding(.top, 10)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(popularFastFoods) { fastFood in
                                        PopularFastFoodCard(fastFood: fastFood)
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                } else if searchResults.isEmpty {
                    // No Results
                    VStack(spacing: 20) {
                        Spacer()
                        
                        Image(systemName: "exclamationmark.magnifyingglass")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        
                        Text("No results found")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text("Try searching with different keywords")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                    .padding()
                } else {
                    // Results List
                    ScrollView {
                        VStack(spacing: 16) {
                            Text("\(searchResults.count) results found")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 20)
                                .padding(.top, 10)
                            
                            ForEach(searchResults) { item in
                                FoodItemCard(foodItem: item)
                                    .padding(.horizontal, 20)
                            }
                        }
                        .padding(.bottom, 20)
                    }
                }
            })
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .onAppear {
            isSearchFocused = true
            loadRecentSearches()
            loadSuggestedRestaurants()
            loadPopularFastFoods()
        }
    }

    // MARK: - Search Logic

    private func performSearch(query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }

        let allItems = dataManager.getAllFoodItems()
        let lowercasedQuery = query.lowercased()

        searchResults = allItems.filter { item in
            item.name.lowercased().contains(lowercasedQuery) ||
            item.description.lowercased().contains(lowercasedQuery) ||
            item.restaurantName.lowercased().contains(lowercasedQuery) ||
            item.category.lowercased().contains(lowercasedQuery)
        }
    }

    // MARK: - Recent Searches Management

    private func loadRecentSearches() {
        // Load default category searches
        recentSearches = defaultRecentSearches
    }

    private func loadSuggestedRestaurants() {
        suggestedRestaurants = restaurantManager.getRandomSuggestions(count: 3)
    }

    private func loadPopularFastFoods() {
        popularFastFoods = fastFoodManager.getRandomPopularFastFoods(count: 6)
    }

    // MARK: - Actions
    private func handleRestaurantTap(restaurant: Restaurant) {
        print("Restaurant tapped: \(restaurant.name)")
        coordinator.coordinatorPagePush(page: .restaurantPage(restaurant: restaurant, selectedKeyword: "Pizza"))
    }
}



#Preview {
    SearchView()
}
