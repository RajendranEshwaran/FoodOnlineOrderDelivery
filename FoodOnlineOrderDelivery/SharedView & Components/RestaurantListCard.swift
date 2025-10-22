//
//  RestaurantListCard.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI

struct RestaurantListCard: View {
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
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                    .clipped()

                // Restaurant Info
                VStack(alignment: .leading, spacing: 6) {
                    // Restaurant Name
                    Text(restaurant.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                        .lineLimit(1)

                    // Rating and Delivery Time
                    HStack(spacing: 12) {
                        // Rating
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(.orange)

                            Text(String(format: "%.1f", restaurant.rating))
                                .font(.caption)
                                .foregroundColor(.black)
                        }

                        // Delivery Time
                        HStack(spacing: 4) {
                            Image(systemName: "clock")
                                .font(.caption)
                                .foregroundColor(.orange)

                            Text(restaurant.deliveryTime)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        // Delivery Time
                        HStack(spacing: 4) {
                            Image(systemName: "car.side.rear.crop.trunk.partition")
                                .font(.caption)
                                .foregroundColor(.orange)

                            Text(restaurant.deliveryOption.rawValue)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }

                    // Open Status Badge
                    HStack(spacing: 6) {
                        Circle()
                            .fill(restaurant.isOpen ? Color.green : Color.red)
                            .frame(width: 6, height: 6)

                        Text(restaurant.isOpen ? "Open" : "Closed")
                            .font(.caption2)
                            .foregroundColor(restaurant.isOpen ? .green : .red)
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
            .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 3)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack(spacing: 16) {
        RestaurantListCard(
            restaurant: Restaurant(
                name: "Pizza Paradise",
                image: "pizza1",
                rating: 4.7,
                deliveryTime: "25-30 min",
                isOpen: true
            ),
            onTap: {
                print("Restaurant tapped")
            }
        )

        RestaurantListCard(
            restaurant: Restaurant(
                name: "Steakhouse Prime",
                image: "meal2",
                rating: 4.9,
                deliveryTime: "35-40 min",
                isOpen: false
            ),
            onTap: {
                print("Restaurant tapped")
            }
        )
    }
    .padding()
}
