//
//  PopularFastFoodCard.swift
//  FoodOnlineOrderDelivery
//
//  Created by RajayGoms on 10/22/25.
//

import SwiftUI

// MARK: - Popular Fast Food Card Component
struct PopularFastFoodCard: View {
    let fastFood: PopularFastFood

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Food Image
            Image(fastFood.foodImage)
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 120)
                .cornerRadius(12)
                .clipped()

            // Food Info
            VStack(alignment: .leading, spacing: 4) {
                Text(fastFood.foodName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .lineLimit(1)

                Text(fastFood.restaurantName)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .padding(.horizontal, 4)
        }
        .frame(width: 140)
        .padding(8)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    PopularFastFoodCard(fastFood: PopularFastFood(foodName: "", foodImage: "", restaurantName: ""))
}
