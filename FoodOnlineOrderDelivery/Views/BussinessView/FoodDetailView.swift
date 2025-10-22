//
//  FoodDetailView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI

// MARK: - Food Size Enum
enum FoodSize: String, CaseIterable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
    case extraLarge = "Extra Large"
}

struct FoodDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @State private var cartItemCount: Int = 3
    @State private var quantity: Int = 1
    @State private var selectedSize: FoodSize = .medium

    let foodItem: FoodItem
    let selectedFoodName: String
    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: selectedFoodName,
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
                VStack(alignment: .leading, spacing: 0) {
                    // Food Image
                    ZStack(alignment: .topTrailing) {
                        Image(foodItem.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 30))

                        // Favorite Button
                        Button(action: {
                            print("Favorite tapped")
                        }) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                                .frame(width: 44, height: 44)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .padding(16)
                    }

                    // Food Details Section
                    VStack(alignment: .leading, spacing: 16) {
                        // Food Name and Price
                        VStack(alignment: .leading, spacing: 8) {
                            Text(foodItem.name)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)

                            Text(foodItem.restaurantName)
                                .font(.system(size: 16))
                                .foregroundColor(.gray)
                        }

                        // Rating, Reviews, and Delivery Time
                        HStack(spacing: 16) {
                            // Rating
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .font(.system(size: 14))
                                    .foregroundColor(.orange)

                                Text(String(format: "%.1f", foodItem.rating))
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.black)
                            }

                            // Reviews
                            Text("(\(foodItem.reviewCount) reviews)")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)

                            Spacer()

                            // Delivery Time
                            HStack(spacing: 4) {
                                Image(systemName: "clock")
                                    .font(.system(size: 14))
                                    .foregroundColor(.orange)

                                Text(foodItem.deliveryTime)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)

                        Divider()

                        // Description Section
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)

                            Text(foodItem.description)
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .lineSpacing(4)
                        }
                        .padding(.vertical, 8)

                        Divider()

                        // Size Selection
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Size")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(FoodSize.allCases, id: \.self) { size in
                                        Button(action: {
                                            selectedSize = size
                                        }) {
                                            Text(size.rawValue)
                                                .font(.system(size: 14, weight: .medium))
                                                .foregroundColor(selectedSize == size ? .white : .black)
                                                .padding(.horizontal, 20)
                                                .padding(.vertical, 10)
                                                .background(selectedSize == size ? Color.orange : Color.gray.opacity(0.1))
                                                .cornerRadius(20)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(selectedSize == size ? Color.orange : Color.gray.opacity(0.3), lineWidth: 1)
                                                )
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 8)

                        Divider()

                        // Quantity Selector
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Quantity")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)

                            HStack(spacing: 16) {
                                // Decrease Button
                                Button(action: {
                                    if quantity > 1 {
                                        quantity -= 1
                                    }
                                }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(quantity > 1 ? .white : .gray)
                                        .frame(width: 40, height: 40)
                                        .background(quantity > 1 ? Color.orange : Color.gray.opacity(0.2))
                                        .clipShape(Circle())
                                }
                                .disabled(quantity <= 1)

                                // Quantity Display
                                Text("\(quantity)")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                                    .frame(minWidth: 40)

                                // Increase Button
                                Button(action: {
                                    quantity += 1
                                }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(width: 40, height: 40)
                                        .background(Color.orange)
                                        .clipShape(Circle())
                                }

                                Spacer()
                            }
                        }
                        .padding(.vertical, 8)

                        Spacer(minLength: 100)
                    }
                    .padding(20)
                }
            }

            // Bottom Add to Cart Section
            VStack(spacing: 0) {
                Divider()

                HStack(spacing: 16) {
                    // Total Price
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Total Price")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)

                        Text("$\(String(format: "%.2f", foodItem.price * Double(quantity)))")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.orange)
                    }

                    Spacer()

                    // Add to Cart Button
                    Button(action: {
                        handleAddToCart()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "cart.fill")
                                .font(.system(size: 16))

                            Text("Add to Cart")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 32)
                        .padding(.vertical, 16)
                        .background(Color.orange)
                        .cornerRadius(12)
                    }
                }
                .padding(20)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }

    // MARK: - Actions
    private func handleAddToCart() {
        print("Added \(quantity) x \(selectedSize.rawValue) \(foodItem.name) to cart")
        cartItemCount += quantity
        // TODO: Implement cart functionality
    }
}

#Preview {
    FoodDetailView(
        foodItem: FoodItem(
            name: "Classic Cheeseburger",
            description: "A delicious beef patty with melted cheese, fresh lettuce, ripe tomatoes, and our special house sauce. Served on a toasted sesame seed bun with crispy pickles and caramelized onions.",
            price: 9.99,
            image: "burger1",
            rating: 4.6,
            reviewCount: 200,
            restaurantName: "Burger Palace",
            deliveryTime: "20-25 min",
            category: "Burger"
        ),
        selectedFoodName: "Classic Cheeseburger"
    )
    .environmentObject(Coordinator())
}
