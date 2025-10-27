//
//  CartDetailView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import SwiftUI

struct CartDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @State private var cartItemCount: Int = 3

    // Sample cart items - in real app, this would come from a cart manager
    private let cartItems = [
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
    ]

    // Calculate total price
    private var totalPrice: Double {
        let subtotal = cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        let deliveryFee = 2.99
        return subtotal + deliveryFee
    }

    var body: some View {
        ZStack {
            //Color.black
            VStack {
                TopPanel(
                    userName: "Cart",
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
                    CartItemsListView(
                        items: cartItems,
                        onQuantityChanged: { id, newQuantity in
                            print("Quantity changed to \(newQuantity) for item: \(id)")
                        },
                        onRemove: { id in
                            print("Remove item: \(id)")
                        },
                        onEditAddress: {
                            print("Edit address tapped")
                            // TODO: Navigate to address edit page
                        },
                        onPlaceOrder: {
                            print("Place order tapped - Total: $\(String(format: "%.2f", totalPrice))")
                            coordinator.coordinatorPagePush(page: .paymentPage(totalAmount: totalPrice))
                        },
                        deliveryAddress: "123 Main Street, Apt 4B, New York, NY 10001"
                    )
                    .padding(.horizontal, 20)
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

#Preview {
    CartDetailView()
}
