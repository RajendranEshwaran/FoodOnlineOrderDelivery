//
//  RecentSearchesView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI

struct RecentSearchesView: View {
    let searches: [String]
    var onSearchTapped: ((String) -> Void)?
    var onClearAll: (() -> Void)?
    var isShowTitle: Bool = true
    var isShowClearAll: Bool = true
    var titleText: String = "Recent Searches"
    var defaultSelection: String? = nil
    var selectedColor: Color = .orange
    var unselectedColor: Color = Color(UIColor.systemGray6)

    @State private var selectedSearch: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                if isShowTitle && isShowClearAll {
                    Text(titleText)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    if !searches.isEmpty && onClearAll != nil {
                        Button(action: {
                            onClearAll?()
                        }) {
                            Text("Clear All")
                                .font(.caption)
                                .foregroundColor(.orange)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)


                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(searches, id: \.self) { search in
                            Button(action: {
                                selectedSearch = search
                                onSearchTapped?(search)
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "clock.arrow.circlepath")
                                        .font(.caption)
                                        .foregroundColor(selectedSearch == search ? .white : .gray)

                                    Text(search)
                                        .font(.subheadline)
                                        .foregroundColor(selectedSearch == search ? .white : .black)
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(selectedSearch == search ? selectedColor : unselectedColor)
                                .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
        }
        .onAppear {
            // Set default selection if provided
            if selectedSearch == nil, let defaultSelection = defaultSelection {
                selectedSearch = defaultSelection
            }
        }
    }
}


#Preview {
    ScrollView {
        VStack(spacing: 30) {
            // Default with no selection
            Text("No Default Selection")
                .font(.title2)
                .bold()

            RecentSearchesView(
                searches: ["Hot Dog", "Burger", "Pizza", "Sandwich", "Dessert"],
                onSearchTapped: { search in
                    print("Tapped: \(search)")
                },
                onClearAll: {
                    print("Clear all")
                }
            )
        }
        .padding(.vertical)
    }
}
