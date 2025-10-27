//
//  OrderCard.swift
//  FoodOnlineOrderDelivery
//
//  Created by RajayGoms on 10/27/25.
//

import SwiftUI


// MARK: - Order Card Component
struct OrderCard: View {
    let orderNumber: String
    let restaurantName: String
    let orderDate: String
    let status: String
    let totalAmount: Double
    let items: [String]
    let isOngoing: Bool

    @State private var showCancelAlert = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Order Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(orderNumber)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)

                    Text(restaurantName)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                }

                Spacer()

                // Status Badge
                Text(status)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(statusColor)
                    .cornerRadius(12)
            }

            Divider()

            // Order Items
            VStack(alignment: .leading, spacing: 4) {
                ForEach(items, id: \.self) { item in
                    HStack {
                        Circle()
                            .fill(Color.orange.opacity(0.3))
                            .frame(width: 6, height: 6)

                        Text(item)
                            .font(.system(size: 14))
                            .foregroundColor(.black.opacity(0.8))
                    }
                }
            }

            Divider()

            // Order Footer
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(orderDate)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)

                    Text("$\(String(format: "%.2f", totalAmount))")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.orange)
                }

                Spacer()

                // Action Buttons
                if isOngoing {
                    Button(action: {
                        print("Track order: \(orderNumber)")
                    }) {
                        Text("Track")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.orange)
                            .cornerRadius(8)
                    }
                    
                    // Cancel Button
                    Button(action: {
                        showCancelAlert = true
                    }) {
                        Text("Cancel")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.red)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.red, lineWidth: 1.5)
                            )
                    }
                } else {
                    Button(action: {
                        print("Reorder: \(orderNumber)")
                    }) {
                        Text("Reorder")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.orange)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.orange, lineWidth: 1.5)
                            )
                    }
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 2)
        .alert("Cancel Order", isPresented: $showCancelAlert) {
            Button("No", role: .cancel) { }
            Button("Yes, Cancel", role: .destructive) {
                handleCancelOrder()
            }
        } message: {
            Text("Are you sure you want to cancel order \(orderNumber)?")
        }
    }

    private var statusColor: Color {
        switch status.lowercased() {
        case "preparing":
            return Color.blue
        case "on the way":
            return Color.orange
        case "delivered":
            return Color.green
        case "cancelled":
            return Color.red
        default:
            return Color.gray
        }
    }

    private func handleCancelOrder() {
        print("Order cancelled: \(orderNumber)")
        // TODO: Implement order cancellation logic with backend
    }
}

// MARK: - Empty Orders View
struct EmptyOrdersView: View {
    let icon: String
    let title: String
    let message: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 60))
                .foregroundColor(.gray.opacity(0.5))
                .padding(.top, 60)

            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)

            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
    }
}

