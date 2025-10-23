//
//  AddCardView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI

struct AddCardView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @State private var cartItemCount: Int = 3

    // Form Fields
    @State private var cardHolderName: String = ""
    @State private var cardNumber: String = ""
    @State private var expiryMonth: String = ""
    @State private var expiryYear: String = ""
    @State private var cvv: String = ""
    @State private var saveCard: Bool = true

    // Validation
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: "Add Card",
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
                VStack(alignment: .leading, spacing: 24) {
                    // Card Preview
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Card Preview")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)

                        CardPreview(
                            cardNumber: cardNumber,
                            holderName: cardHolderName,
                            expiryMonth: expiryMonth,
                            expiryYear: expiryYear
                        )
                    }
                    .padding(.top, 20)

                    // Card Details Form
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Card Details")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)

                        // Card Holder Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Cardholder Name")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)

                            TextField("John Doe", text: $cardHolderName)
                                .textFieldStyle(CustomTextFieldStyle())
                                .autocapitalization(.words)
                        }

                        // Card Number
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Card Number")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)

                            TextField("1234 5678 9012 3456", text: $cardNumber)
                                .textFieldStyle(CustomTextFieldStyle())
                                .keyboardType(.numberPad)
                                .onChange(of: cardNumber) { oldValue, newValue in
                                    cardNumber = formatCardNumber(newValue)
                                }
                        }

                        // Expiry Date and CVV
                        HStack(spacing: 16) {
                            // Expiry Date
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Expiry Date")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.gray)

                                HStack(spacing: 8) {
                                    // Month
                                    TextField("MM", text: $expiryMonth)
                                        .textFieldStyle(CustomTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .frame(maxWidth: .infinity)
                                        .onChange(of: expiryMonth) { oldValue, newValue in
                                            expiryMonth = formatMonth(newValue)
                                        }

                                    Text("/")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(.gray)

                                    // Year
                                    TextField("YY", text: $expiryYear)
                                        .textFieldStyle(CustomTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .frame(maxWidth: .infinity)
                                        .onChange(of: expiryYear) { oldValue, newValue in
                                            expiryYear = formatYear(newValue)
                                        }
                                }
                            }
                            .frame(maxWidth: .infinity)

                            // CVV
                            VStack(alignment: .leading, spacing: 8) {
                                HStack(spacing: 4) {
                                    Text("CVV")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(.gray)

                                    Image(systemName: "questionmark.circle")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }

                                TextField("123", text: $cvv)
                                    .textFieldStyle(CustomTextFieldStyle())
                                    .keyboardType(.numberPad)
                                    .onChange(of: cvv) { oldValue, newValue in
                                        cvv = formatCVV(newValue)
                                    }
                            }
                            .frame(maxWidth: .infinity)
                        }

                        // Save Card Toggle
                        HStack {
                            Toggle(isOn: $saveCard) {
                                Text("Save card for future payments")
                                    .font(.system(size: 15))
                                    .foregroundColor(.black)
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .orange))
                        }
                        .padding(.vertical, 8)
                    }

                    // Error Message
                    if showError {
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)

                            Text(errorMessage)
                                .font(.system(size: 14))
                                .foregroundColor(.red)
                        }
                        .padding(12)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                    }

                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 20)
            }

            // Add Card Button (Fixed at Bottom)
            VStack(spacing: 0) {
                Divider()

                Button(action: {
                    handleAddCard()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 18))

                        Text("Add Card")
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
    }

    // MARK: - Validation & Formatting

    private func formatCardNumber(_ input: String) -> String {
        let digits = input.filter { $0.isNumber }
        let limited = String(digits.prefix(16))

        var formatted = ""
        for (index, char) in limited.enumerated() {
            if index > 0 && index % 4 == 0 {
                formatted += " "
            }
            formatted.append(char)
        }
        return formatted
    }

    private func formatMonth(_ input: String) -> String {
        let digits = input.filter { $0.isNumber }
        let limited = String(digits.prefix(2))

        if let month = Int(limited), month > 12 {
            return "12"
        }
        return limited
    }

    private func formatYear(_ input: String) -> String {
        let digits = input.filter { $0.isNumber }
        return String(digits.prefix(2))
    }

    private func formatCVV(_ input: String) -> String {
        let digits = input.filter { $0.isNumber }
        return String(digits.prefix(3))
    }

    private func validateCard() -> Bool {
        // Reset error
        showError = false
        errorMessage = ""

        // Validate card holder name
        if cardHolderName.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Please enter cardholder name"
            showError = true
            return false
        }

        // Validate card number (basic check for 16 digits)
        let cardDigits = cardNumber.filter { $0.isNumber }
        if cardDigits.count < 15 {
            errorMessage = "Please enter a valid card number"
            showError = true
            return false
        }

        // Validate expiry month
        guard let month = Int(expiryMonth), month >= 1, month <= 12 else {
            errorMessage = "Please enter a valid expiry month (01-12)"
            showError = true
            return false
        }

        // Validate expiry year
        if expiryYear.count != 2 {
            errorMessage = "Please enter a valid expiry year (YY)"
            showError = true
            return false
        }

        // Validate CVV
        if cvv.count < 3 {
            errorMessage = "Please enter a valid CVV"
            showError = true
            return false
        }

        return true
    }

    private func handleAddCard() {
        if validateCard() {
            print("Card added successfully")
            print("Holder: \(cardHolderName)")
            print("Card Number: \(cardNumber)")
            print("Expiry: \(expiryMonth)/\(expiryYear)")
            print("Save Card: \(saveCard)")

            // TODO: Save card to backend and navigate back
            coordinator.coordinatorPopToPage()
        }
    }
}

// MARK: - Card Preview Component
struct CardPreview: View {
    let cardNumber: String
    let holderName: String
    let expiryMonth: String
    let expiryYear: String

    var body: some View {
        ZStack {
            // Card Background
            RoundedRectangle(cornerRadius: 16)
                .fill(
                    LinearGradient(
                        colors: [Color.orange, Color.orange.opacity(0.7)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 200)

            VStack(alignment: .leading, spacing: 20) {
                // Card Type Header
                HStack {
                    Image(systemName: "wave.3.right")
                        .font(.system(size: 24))
                        .foregroundColor(.white.opacity(0.8))

                    Spacer()

                    // Card Type Logo
                    CardTypeLogo(cardType: detectCardType(cardNumber))
                }

                Spacer()

                // Card Number
                Text(cardNumber.isEmpty ? "•••• •••• •••• ••••" : cardNumber)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                    .tracking(2)

                // Card Details
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("CARD HOLDER")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))

                        Text(holderName.isEmpty ? "YOUR NAME" : holderName.uppercased())
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)
                    }

                    Spacer()

                    VStack(alignment: .leading, spacing: 4) {
                        Text("EXPIRES")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundColor(.white.opacity(0.7))

                        Text(expiryMonth.isEmpty || expiryYear.isEmpty ? "MM/YY" : "\(expiryMonth)/\(expiryYear)")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(24)
        }
        .frame(height: 200)
    }

    private func detectCardType(_ number: String) -> String {
        let digits = number.filter { $0.isNumber }

        if digits.hasPrefix("4") {
            return "VISA"
        } else if digits.hasPrefix("5") {
            return "MASTERCARD"
        } else if digits.hasPrefix("3") {
            return "AMEX"
        } else {
            return "CARD"
        }
    }
}

// MARK: - Card Type Logo Component
struct CardTypeLogo: View {
    let cardType: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white.opacity(0.2))
                .frame(width: 60, height: 40)

            Text(cardType)
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
                .padding(.horizontal, 4)
        }
    }
}

// MARK: - Custom Text Field Style
struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(14)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
}

#Preview {
    AddCardView()
        .environmentObject(Coordinator())
}
