//
//  CartView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI


// MARK: - Cart Item Card View
struct CartView: View {
    let item: CartItem
    var onQuantityChanged: ((Int) -> Void)?
    var onRemove: (() -> Void)?
   
    var body: some View {
      
        HStack(spacing: 12) {
            // Item Image
            AsyncImage(url: URL(string: item.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(12)
                        .clipped()
                } else if phase.error != nil {
                        Image("noImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .cornerRadius(12)
                            .clipped()
                    } else {
                        ProgressView()
                    }
                }
            }
                
            
            // Item Details
            VStack(alignment: .leading, spacing: 6) {
                // Item Name
                Text(item.name)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                // Restaurant Name
                Text(item.restaurantName)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                
                // Size
                Text("Size: \(item.size)")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                // Price
                Text("$\(String(format: "%.2f", item.price))")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.orange)
            }
            
            Spacer()
            
            // Quantity Controls
            VStack(spacing: 8) {
                // Remove Button
                if onRemove != nil {
                    Button(action: {
                        onRemove?()
                    }) {
                        Image(systemName: "trash")
                            .font(.system(size: 14))
                            .foregroundColor(.red)
                            .frame(width: 30, height: 30)
                            .background(Color.red.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
                
                // Quantity Adjuster
                HStack(spacing: 8) {
                    // Decrease Button
                    Button(action: {
                        if item.quantity > 1 {
                            onQuantityChanged?(item.quantity - 1)
                        }
                    }) {
                        Image(systemName: "minus")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(item.quantity > 1 ? .white : .gray)
                            .frame(width: 24, height: 24)
                            .background(item.quantity > 1 ? Color.orange : Color.gray.opacity(0.2))
                            .clipShape(Circle())
                    }
                    .disabled(item.quantity <= 1)
                    
                    // Quantity Display
                    Text("\(item.quantity)")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(minWidth: 20)
                    
                    // Increase Button
                    Button(action: {
                        onQuantityChanged?(item.quantity + 1)
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                            .background(Color.orange)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Cart Items List View
struct CartItemsListView: View {
    let items: [CartItem]
    var onQuantityChanged: ((String, Int) -> Void)?
    var onRemove: ((String) -> Void)?
    var onEditAddress: (() -> Void)?
    var onPlaceOrder: (() -> Void)?
    var deliveryAddress: String = "123 Main Street, Apt 4B, New York, NY 10001"
    var deliveryFee: Double = 2.99
    var tax: Double = 0.0
    var subtotal: Double = 0.0
    var total: Double = 0.0
    var promoCode: String? = nil
    var promoDiscount: Double = 0.0
    var onApplyPromo: ((String) -> Bool)?
    var onRemovePromo: (() -> Void)?

    @State private var promoCodeInput: String = ""
    @State private var showPromoError: Bool = false
    @State private var showPromoSuccess: Bool = false

    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Text("Cart Items")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)

                Spacer()

                Text("\(totalItems) item\(totalItems != 1 ? "s" : "")")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }

            // Items List
            if items.isEmpty {
                // Empty State
                VStack(spacing: 12) {
                    Image(systemName: "cart")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.5))

                    Text("Your cart is empty")
                        .font(.headline)
                        .foregroundColor(.gray)

                    Text("Add items to get started")
                        .font(.subheadline)
                        .foregroundColor(.gray.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
            } else {
                VStack(spacing: 12) {
                    ForEach(items) { item in
                        CartView(
                            item: item,
                            onQuantityChanged: { newQuantity in
                                onQuantityChanged?(item.id, newQuantity)
                            },
                            onRemove: {
                                onRemove?(item.id)
                            }
                        )
                    }
                }
                    

                // Delivery Address Section
                VStack(alignment: .leading, spacing: 12) {
                    Divider()
                        .padding(.vertical, 8)

                    HStack {
                        Text("Delivery Address")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)

                        Spacer()

                        Button(action: {
                            onEditAddress?()
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "pencil")
                                    .font(.system(size: 14))
                                Text("Edit")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(.orange)
                        }
                    }

                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.orange)

                        Text(deliveryAddress)
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(12)
                    .background(Color.orange.opacity(0.05))
                    .cornerRadius(12)
                }

                // Promo Code Section
                VStack(alignment: .leading, spacing: 12) {
                    Divider()
                        .padding(.vertical, 8)

                    Text("Promo Code")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)

                    if let appliedPromo = promoCode {
                        // Show applied promo code
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)

                            Text(appliedPromo)
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.green)

                            Spacer()

                            Text("-$\(String(format: "%.2f", promoDiscount))")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.green)

                            Button(action: {
                                onRemovePromo?()
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(12)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                    } else {
                        // Promo code input
                        HStack(spacing: 8) {
                            TextField("Enter promo code", text: $promoCodeInput)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .textInputAutocapitalization(.characters)

                            Button(action: {
                                applyPromoCode()
                            }) {
                                Text("Apply")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 8)
                                    .background(promoCodeInput.isEmpty ? Color.gray : Color.orange)
                                    .cornerRadius(8)
                            }
                            .disabled(promoCodeInput.isEmpty)
                        }

                        if showPromoError {
                            HStack {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .foregroundColor(.red)
                                Text("Invalid promo code")
                                    .font(.system(size: 13))
                                    .foregroundColor(.red)
                            }
                        }

                        if showPromoSuccess {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Promo code applied!")
                                    .font(.system(size: 13))
                                    .foregroundColor(.green)
                            }
                        }

                        // Show available promo codes
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Available codes:")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)

                            Text("SAVE10 • SAVE20 • FREESHIP • WELCOME")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundColor(.orange)
                        }
                        .padding(.top, 4)
                    }
                }

                // Total Section
                VStack(spacing: 12) {
                    Divider()
                        .padding(.vertical, 8)

                    HStack {
                        Text("Subtotal")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)

                        Spacer()

                        Text("$\(String(format: "%.2f", subtotal))")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }

                    HStack {
                        Text("Delivery Fee")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)

                        Spacer()

                        Text("$\(String(format: "%.2f", deliveryFee))")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }

                    if tax > 0 {
                        HStack {
                            Text("Tax (8%)")
                                .font(.system(size: 16))
                                .foregroundColor(.gray)

                            Spacer()

                            Text("$\(String(format: "%.2f", tax))")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }

                    if promoDiscount > 0 {
                        HStack {
                            Text("Promo Discount")
                                .font(.system(size: 16))
                                .foregroundColor(.green)

                            Spacer()

                            Text("-$\(String(format: "%.2f", promoDiscount))")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.green)
                        }
                    }

                    Divider()

                    HStack {
                        Text("Total")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)

                        Spacer()

                        Text("$\(String(format: "%.2f", total))")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.orange)
                    }
                }
                .padding(.top, 8)

                // Place Order Button
                Button(action: {
                    onPlaceOrder?()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 18))

                        Text("Place Order")
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(items.isEmpty ? Color.gray : Color.orange)
                    .cornerRadius(12)
                }
                .disabled(items.isEmpty)
                .padding(.top, 16)
            }
        }
    }

    // MARK: - Helper Methods
    private func applyPromoCode() {
        showPromoError = false
        showPromoSuccess = false

        if let onApply = onApplyPromo {
            let success = onApply(promoCodeInput)
            if success {
                showPromoSuccess = true
                promoCodeInput = ""
                // Hide success message after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    showPromoSuccess = false
                }
            } else {
                showPromoError = true
                // Hide error message after 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    showPromoError = false
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 30) {
            // Single Item
            Text("Single Cart Item")
                .font(.title2)
                .bold()

            CartView(
                item: CartItem(
                    name: "Classic Cheeseburger",
                    image: "burger1",
                    price: 9.99,
                    size: "Large",
                    quantity: 2,
                    restaurantName: "Burger Palace"
                ),
                onQuantityChanged: { newQuantity in
                    print("Quantity changed to: \(newQuantity)")
                },
                onRemove: {
                    print("Remove item")
                }
            )
            .padding(.horizontal)

            Divider()

            // Full Cart List
            Text("Cart Items List")
                .font(.title2)
                .bold()

            CartItemsListView(
                items: [
                    CartItem(
                        name: "Classic Cheeseburger",
                        image: "burger1",
                        price: 9.99,
                        size: "Large",
                        quantity: 2,
                        restaurantName: "Burger Palace"
                    ),
                    CartItem(
                        name: "Pepperoni Pizza",
                        image: "pizza2",
                        price: 12.99,
                        size: "Medium",
                        quantity: 1,
                        restaurantName: "Tony's Pizzeria"
                    ),
                    CartItem(
                        name: "Hot Dog",
                        image: "hotdog1",
                        price: 5.99,
                        size: "Small",
                        quantity: 3,
                        restaurantName: "Hot Dog Haven"
                    )
                ],
                onQuantityChanged: { id, newQuantity in
                    print("Item \(id) quantity changed to: \(newQuantity)")
                },
                onRemove: { id in
                    print("Remove item: \(id)")
                },
                onEditAddress: {
                    print("Edit address tapped")
                },
                onPlaceOrder: {
                    print("Place order tapped")
                },
                deliveryAddress: "123 Main Street, Apt 4B, New York, NY 10001"
            )
            .padding(.horizontal)

            Divider()

            // Empty Cart
            Text("Empty Cart")
                .font(.title2)
                .bold()

            CartItemsListView(
                items: [],
                onQuantityChanged: { id, newQuantity in
                    print("Quantity changed")
                },
                onRemove: { id in
                    print("Remove item")
                }
            )
            .padding(.horizontal)
        }
        .padding(.vertical)
    }
}
