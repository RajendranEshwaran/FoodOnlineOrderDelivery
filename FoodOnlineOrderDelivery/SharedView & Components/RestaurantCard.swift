//
//  RestaurentCard.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI


// MARK: - Restaurant Card Component
struct RestaurantCard: View {
    let restaurant: Restaurant
    var onTap: (() -> Void)?

    var body: some View {
        Button(action: {
            onTap?()
        }) {
            HStack(spacing: 12) {
                // Restaurant Image
                Image(restaurant.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .cornerRadius(12)
                    .clipped()

                // Restaurant Info
                VStack(alignment: .leading, spacing: 6) {
                    Text(restaurant.name)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)

                        Text(String(format: "%.1f", restaurant.rating))
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("• Restaurant")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }

                Spacer()

                // Arrow Icon
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(12)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    RestaurantCard(restaurant: Restaurant(name: "Pizza Paradise", image: "pizza1"), onTap: {
        print("Tapped restaurent")
    })
}
