//
//  PaymentView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI

// MARK: - Payment Method Enum
enum PaymentMethod: String, CaseIterable {
    case cash = "Cash"
    case visa = "Visa"
    case mastercard = "Mastercard"
    case paypal = "PayPal"
    case bankAccount = "Bank Account"
    case venmo = "Venmo"
    case zelle = "Zelle"
    case googlePay = "Google Pay"
    case wallet = "Wallet"

    var iconName: String {
        switch self {
        case .cash: return "dollarsign.circle.fill"
        case .visa: return "creditcard.fill"
        case .mastercard: return "creditcard.fill"
        case .paypal: return "p.circle.fill"
        case .bankAccount: return "building.columns.fill"
        case .venmo: return "v.circle.fill"
        case .zelle: return "z.circle.fill"
        case .googlePay: return "g.circle.fill"
        case .wallet: return "wallet.pass.fill"
        }
    }
}

// MARK: - Stored Card Model
struct StoredCard: Identifiable {
    let id: String
    let cardType: String
    let last4Digits: String
    let expiryDate: String
    let holderName: String

    init(id: String = UUID().uuidString,
         cardType: String,
         last4Digits: String,
         expiryDate: String,
         holderName: String) {
        self.id = id
        self.cardType = cardType
        self.last4Digits = last4Digits
        self.expiryDate = expiryDate
        self.holderName = holderName
    }
}

struct PaymentView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @State private var cartItemCount: Int = 3
    @State private var selectedPaymentMethod: PaymentMethod = .cash
    @State private var storedCards: [StoredCard] = []
    @State private var selectedCard: StoredCard?

    let totalAmount: Double

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: "Payment",
                cartItemCount: cartItemCount,
                isMenuEnable: false,
                isBackEnable: true,
                isUserInfo: false,
                isCartEnable: false,
                onCartTap: {
                    print("Cart tapped")
                }, onBackTap: {
                    coordinator.coordinatorPopToPage()
                }
            )

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Payment Methods Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Payment Method")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)

                        // Payment Methods Grid
                        LazyVGrid(
                            columns: [
                                GridItem(.flexible(), spacing: 12),
                                GridItem(.flexible(), spacing: 12),
                                GridItem(.flexible(), spacing: 12)
                            ],
                            spacing: 12
                        ) {
                            ForEach(PaymentMethod.allCases, id: \.self) { method in
                                PaymentMethodButton(
                                    method: method,
                                    isSelected: selectedPaymentMethod == method,
                                    onTap: {
                                        selectedPaymentMethod = method
                                    }
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)

                    // Stored Cards Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Saved Cards")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)

                        if storedCards.isEmpty {
                            // No Cards Added State
                            VStack(spacing: 12) {
                                Image(systemName: "creditcard")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray.opacity(0.5))

                                Text("No cards added yet")
                                    .font(.headline)
                                    .foregroundColor(.gray)

                                Text("Add a card to make checkout faster")
                                    .font(.subheadline)
                                    .foregroundColor(.gray.opacity(0.8))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                            .background(Color.gray.opacity(0.05))
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                        } else {
                            // Cards List
                            VStack(spacing: 12) {
                                ForEach(storedCards) { card in
                                    StoredCardView(
                                        card: card,
                                        isSelected: selectedCard?.id == card.id,
                                        onTap: {
                                            selectedCard = card
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    // Add New Payment Button
                    Button(action: {
                        handleAddNewPayment()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 18))

                            Text("Add New Payment Method")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.orange)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                }
            }

            // Total Amount Section
            VStack(spacing: 12) {
                Divider()
                    .padding(.vertical, 8)

                HStack {
                    Text("Total Amount")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)

                    Spacer()

                    Text("$\(String(format: "%.2f", totalAmount))")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.orange)
                }

                Divider()
                    .padding(.vertical, 8)
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
            
            // Confirm Button (Fixed at Bottom)
            VStack(spacing: 0) {
                Divider()

                Button(action: {
                    handleConfirmPayment()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 18))

                        Text("Confirm Payment")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.orange)
                    .cornerRadius(12)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
        .onAppear {
            loadStoredCards()
        }
    }

    // MARK: - Actions
    private func handleAddNewPayment() {
        print("Add new payment method")
        // TODO: Navigate to add payment method page
    }

    private func handleConfirmPayment() {
        print("Confirm payment with method: \(selectedPaymentMethod.rawValue)")
        if let card = selectedCard {
            print("Using card ending in: \(card.last4Digits)")
        }
        // TODO: Process payment and navigate to confirmation
    }

    private func loadStoredCards() {
        // Sample data - replace with actual data loading
        storedCards = [
            StoredCard(
                cardType: "Visa",
                last4Digits: "4532",
                expiryDate: "12/25",
                holderName: "John Doe"
            ),
            StoredCard(
                cardType: "Mastercard",
                last4Digits: "8765",
                expiryDate: "09/26",
                holderName: "John Doe"
            )
        ]
        selectedCard = storedCards.first
    }
}

// MARK: - Payment Method Button
struct PaymentMethodButton: View {
    let method: PaymentMethod
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 8) {
                Image(systemName: method.iconName)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .white : .orange)

                Text(method.rawValue)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(isSelected ? .white : .black)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(isSelected ? Color.orange : Color.gray.opacity(0.1))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.orange : Color.gray.opacity(0.3), lineWidth: isSelected ? 2 : 1)
            )
        }
    }
}

// MARK: - Stored Card View
struct StoredCardView: View {
    let card: StoredCard
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Card Icon
                Image(systemName: "creditcard.fill")
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .orange : .gray)
                    .frame(width: 40)

                // Card Details
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(card.cardType) •••• \(card.last4Digits)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)

                    HStack(spacing: 8) {
                        Text(card.holderName)
                            .font(.system(size: 13))
                            .foregroundColor(.gray)

                        Text("•")
                            .foregroundColor(.gray)

                        Text("Exp: \(card.expiryDate)")
                            .font(.system(size: 13))
                            .foregroundColor(.gray)
                    }
                }

                Spacer()

                // Selection Indicator
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundColor(isSelected ? .orange : .gray.opacity(0.3))
            }
            .padding(16)
            .background(isSelected ? Color.orange.opacity(0.05) : Color.white)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.orange : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    PaymentView(totalAmount: 45.96)
        .environmentObject(Coordinator())
}
