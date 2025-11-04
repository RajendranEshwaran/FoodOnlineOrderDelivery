//
//  FoodCard.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI

struct FoodCard: View {
    let foodName: String
    let foodImage: String
    let price: Double
    var onAddTapped: (() -> Void)?
    var onCardTapped: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Food Image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.orange.opacity(0.1))
                    .frame(height: 140)

                AsyncImage(url: URL(string: foodImage)){ phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 120)
                    } else if phase.error != nil {
                        Image("noImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 120)
                    } else {
                        ProgressView()
                    }
                }
                    
            }
            .onTapGesture {
                onCardTapped?()
            }

            // Food Name
            Text(foodName)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .lineLimit(2)
                .frame(height: 40, alignment: .top)
                .onTapGesture {
                    onCardTapped?()
                }

            // Price and Add Button
            HStack {
                Text("$\(String(format: "%.2f", price))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(Color.orange)

                Spacer()

                // Add Button
                Button(action: {
                    onAddTapped?()
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 32, height: 32)
                        .background(Color.orange)
                        .clipShape(Circle())
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Convenience Initializer for FoodItem
extension FoodCard {
    init(foodItem: FoodItem, onAddTapped: (() -> Void)? = nil, onCardTapped: (() -> Void)? = nil) {
        self.foodName = foodItem.name
        self.foodImage = foodItem.image
        self.price = foodItem.price
        self.onAddTapped = onAddTapped
        self.onCardTapped = onCardTapped
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 20) {
            // Example 1: Using with direct parameters
            Text("Direct Parameters")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)

            HStack(spacing: 16) {
                FoodCard(
                    foodName: "Classic Cheeseburger",
                    foodImage: "burger1",
                    price: 9.99,
                    onAddTapped: {
                        print("Add button tapped")
                    }
                )
                .frame(width: 160)

                FoodCard(
                    foodName: "Pepperoni Pizza",
                    foodImage: "pizza2",
                    price: 12.99,
                    onAddTapped: {
                        print("Add button tapped")
                    }
                )
                .frame(width: 160)
            }
            .padding(.horizontal)

            // Example 2: Using with FoodItem
            Text("Using FoodItem Model")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top)

            HStack(spacing: 16) {
                FoodCard(
                    foodItem: FoodItem(
                        name: "Chocolate Cake",
                        description: "Rich chocolate cake",
                        price: 6.99,
                        image: "dessat1",
                        restaurantName: "Sweet Treats",
                        category: "Dessert"
                    ),
                    onAddTapped: {
                        print("Added Chocolate Cake")
                    }
                )
                .frame(width: 160)

                FoodCard(
                    foodItem: FoodItem(
                        name: "Hot Dog",
                        description: "Classic hot dog",
                        price: 5.99,
                        image: "hotdog1",
                        restaurantName: "Dog House",
                        category: "Hot Dog"
                    ),
                    onAddTapped: {
                        print("Added Hot Dog")
                    }
                )
                .frame(width: 160)
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}
