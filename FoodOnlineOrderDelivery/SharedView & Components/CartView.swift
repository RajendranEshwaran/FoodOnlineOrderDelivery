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
            Image(item.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .clipped()
            
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

    var totalPrice: Double {
        items.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

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

                // Total Section
                VStack(spacing: 12) {
                    Divider()
                        .padding(.vertical, 8)

                    HStack {
                        Text("Subtotal")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)

                        Spacer()

                        Text("$\(String(format: "%.2f", totalPrice))")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }

                    HStack {
                        Text("Delivery Fee")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)

                        Spacer()

                        Text("$2.99")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }

                    Divider()

                    HStack {
                        Text("Total")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)

                        Spacer()

                        Text("$\(String(format: "%.2f", totalPrice + 2.99))")
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
                    .background(Color.orange)
                    .cornerRadius(12)
                }
                .padding(.top, 16)
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
