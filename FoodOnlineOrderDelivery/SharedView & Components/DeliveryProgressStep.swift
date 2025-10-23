//
//  DeliveryProgressStep.swift
//  FoodOnlineOrderDelivery
//
//  Created by RajayGoms on 10/23/25.
//

import SwiftUI

// MARK: - Delivery Progress Step
struct DeliveryProgressStep: View {
    let icon: String
    let title: String
    let subtitle: String
    let isCompleted: Bool
    let isLast: Bool
    var isActive: Bool = false

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Icon and Line
            VStack(spacing: 0) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(isCompleted ? .orange : (isActive ? .orange : .gray.opacity(0.3)))
                    .frame(width: 24, height: 24)

                if !isLast {
                    Rectangle()
                        .fill(isCompleted ? Color.orange : Color.gray.opacity(0.3))
                        .frame(width: 2, height: 40)
                }
            }

            // Text Content
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(isCompleted || isActive ? .black : .gray)

                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            Spacer()
        }
    }
}
