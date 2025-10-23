//
//  ConfirmationView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/23/25.
//

import SwiftUI

struct ConfirmationView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator

    let orderNumber: String
    let estimatedDeliveryTime: String

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: "Order Confirmation",
                cartItemCount: 0,
                isMenuEnable: false,
                isBackEnable: false,
                isUserInfo: false,
                isCartEnable: false,
                onCartTap: {
                    print("Cart tapped")
                }, onBackTap: {
                    coordinator.coordinatorPopToPage()
                }
            )

            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 40)

                    // Congrats Image
                    ZStack {
                        Circle()
                            .fill(Color.orange.opacity(0.1))
                            .frame(width: 150, height: 150)

                        Circle()
                            .fill(Color.orange.opacity(0.2))
                            .frame(width: 120, height: 120)

                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(.orange)
                    }
                    .padding(.top, 20)

                    // Congrats Message
                    VStack(spacing: 12) {
                        Text("Congratulations!")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)

                        Text("Your order has been placed successfully")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }

                    // Order Details Card
                    VStack(spacing: 16) {
                        // Order Number
                        HStack {
                            Text("Order Number")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)

                            Spacer()

                            Text("#\(orderNumber)")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                        }

                        Divider()

                        // Estimated Delivery Time
                        HStack {
                            Text("Estimated Delivery")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)

                            Spacer()

                            Text(estimatedDeliveryTime)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.orange)
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
                    .padding(.horizontal, 20)

                    // Success Message
                    VStack(spacing: 12) {
                        Image(systemName: "bell.badge.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.orange)

                        Text("We'll notify you once your order is ready")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                    }
                    .padding(.vertical, 20)

                    Spacer(minLength: 40)
                }
            }

            // Track Order Button (Fixed at Bottom)
            VStack(spacing: 12) {
                Divider()

                Button(action: {
                    handleTrackOrder()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 18))

                        Text("Track Order")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.orange)
                    .cornerRadius(12)
                }

                // Back to Home Button
                Button(action: {
                    handleBackToHome()
                }) {
                    Text("Back to Home")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.orange)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.white)
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }

    // MARK: - Actions
    private func handleTrackOrder() {
        print("Track order tapped - Order #\(orderNumber)")
        // TODO: Navigate to order tracking page
    }

    private func handleBackToHome() {
        print("Back to home tapped")
        coordinator.setRootPage(page: .homePage)
    }
}

#Preview {
    ConfirmationView(
        orderNumber: "2584",
        estimatedDeliveryTime: "25-30 mins"
    )
    .environmentObject(Coordinator())
}
