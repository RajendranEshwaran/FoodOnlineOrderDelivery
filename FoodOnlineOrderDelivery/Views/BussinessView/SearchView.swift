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
    @State private var searchText: String = ""
    @State private var searchResults: [FoodItem] = []
    @FocusState private var isSearchFocused: Bool

    let dataManager = CategoryDataManager.shared

    var body: some View {
        VStack(spacing: 0) {
            // Top Bar with Back Button and Search
            HStack(spacing: 12) {
                // Back Button
                Button(action: {
                    coordinator.coordinatorPopToPage()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                        .frame(width: 40, height: 40)
                }

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
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)

            // Search Results
            if searchText.isEmpty {
                // Empty State
                VStack(spacing: 20) {
                    Spacer()

                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 60))
                        .foregroundColor(.gray)

                    Text("Search for dishes or restaurants")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Text("Start typing to find your favorite food")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    Spacer()
                }
                .padding()
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
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .onAppear {
            isSearchFocused = true
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
}

#Preview {
    SearchView()
}
