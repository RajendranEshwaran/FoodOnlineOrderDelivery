//
//  FavouriteFoodCard.swift
//  FoodOnlineOrderDelivery
//
//  Created by RajayGoms on 10/27/25.
//

import SwiftUI


// MARK: - Favourite Food Card Component
struct FavouriteFoodCard: View {
    let foodItem: FoodItem
    var onRemoveTapped: (() -> Void)?
    var onCardTapped: (() -> Void)?

    var body: some View {
        HStack(spacing: 12) {
            // Food Image
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.orange.opacity(0.1))
                    .frame(width: 100, height: 100)

                Image(foodItem.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 90, height: 90)
            }

            // Food Details
            VStack(alignment: .leading, spacing: 6) {
                // Food Name
                Text(foodItem.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(2)

                // Restaurant Name
                HStack(spacing: 4) {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)

                    Text(foodItem.restaurantName)
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }

                // Rating
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.orange)

                    Text(String(format: "%.1f", foodItem.rating))
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black)

                    Text("(\(foodItem.reviewCount))")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }

                Spacer()

                // Price
                Text("$\(String(format: "%.2f", foodItem.price))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.orange)
            }

            Spacer()

            // Remove Button
            Button(action: {
                onRemoveTapped?()
            }) {
                Image(systemName: "heart.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                    .frame(width: 40, height: 40)
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
        .onTapGesture {
            onCardTapped?()
        }
    }
}

// MARK: - Empty Favourites View
struct EmptyFavouritesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.slash")
                .font(.system(size: 70))
                .foregroundColor(.gray.opacity(0.5))
                .padding(.top, 100)

            Text("No Favourites Yet")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.black)

            Text("Start adding your favorite food items\nto see them here")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
