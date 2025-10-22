//
//  FoodItemCard.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import SwiftUI

struct FoodItemCard: View {
    let foodItem: FoodItem

    var body: some View {
        HStack(spacing: 16) {
            // Food Image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(UIColor.orange))
                    .frame(width: 100, height: 100)

                // Placeholder for actual image
//                Text(foodItem.image)
//                    .font(.system(size: 50))
                Image(foodItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
            }

            // Food Details
            VStack(alignment: .leading, spacing: 6) {
                Text(foodItem.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .lineLimit(1)

                Text(foodItem.restaurantName)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)

                Text(foodItem.description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)

                HStack(spacing: 12) {
                    // Rating
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.orange)

                        Text(String(format: "%.1f", foodItem.rating))
                            .font(.caption)
                            .foregroundColor(.black)

                        Text("(\(foodItem.reviewCount))")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }

                    // Delivery Time
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text(foodItem.deliveryTime)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                // Price
                Text("$\(String(format: "%.2f", foodItem.price))")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("ButtonColor"))
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    FoodItemCard(foodItem: FoodItem(
        name: "Classic Cheeseburger",
        description: "Beef patty with cheese, lettuce, tomato, and special sauce",
        price: 9.99,
        image: "🍔",
        rating: 4.6,
        reviewCount: 200,
        restaurantName: "Burger Palace",
        deliveryTime: "20-25 min",
        category: "Burger",
        size: "Medium"
    ))
    .padding()
}
