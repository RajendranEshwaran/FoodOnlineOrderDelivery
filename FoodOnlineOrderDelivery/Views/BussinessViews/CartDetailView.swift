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
    @ObservedObject private var cartManager = CartManager.shared
    @State private var showClearCartAlert: Bool = false
    @State private var deliveryAddress: String = "123 Main Street, Apt 4B, New York, NY 10001"

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // Top Panel with Clear Cart option
                TopPanel(
                    userName: "Cart",
                    cartItemCount: cartManager.itemCount,
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

                // Clear Cart Button (only show if cart has items)
                if !cartManager.isEmpty {
                    HStack {
                        Spacer()
                        Button(action: {
                            showClearCartAlert = true
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "trash")
                                    .font(.system(size: 14))
                                Text("Clear Cart")
                                    .font(.system(size: 14, weight: .medium))
                            }
                            .foregroundColor(.red)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.red.opacity(0.1))
                            .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                }

                ScrollView {
                    CartItemsListView(
                        items: cartManager.cartItems,
                        onQuantityChanged: { id, newQuantity in
                            handleQuantityChanged(id: id, newQuantity: newQuantity)
                        },
                        onRemove: { id in
                            handleRemoveItem(id: id)
                        },
                        onEditAddress: {
                            handleEditAddress()
                        },
                        onPlaceOrder: {
                            handlePlaceOrder()
                        },
                        deliveryAddress: deliveryAddress,
                        deliveryFee: cartManager.deliveryFee,
                        tax: cartManager.tax,
                        subtotal: cartManager.subtotal,
                        total: cartManager.total,
                        promoCode: cartManager.promoCode,
                        promoDiscount: cartManager.promoDiscount,
                        onApplyPromo: { code in
                            handleApplyPromo(code: code)
                        },
                        onRemovePromo: {
                            cartManager.removePromoCode()
                        }
                    )
                    .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .alert("Clear Cart", isPresented: $showClearCartAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Clear", role: .destructive) {
                cartManager.clearCart()
            }
        } message: {
            Text("Are you sure you want to remove all items from your cart?")
        }
    }

    // MARK: - Helper Methods
    private func handleQuantityChanged(id: String, newQuantity: Int) {
        if let item = cartManager.cartItems.first(where: { $0.id == id }) {
            cartManager.updateQuantity(for: item, quantity: newQuantity)
        }
    }

    private func handleRemoveItem(id: String) {
        cartManager.removeItem(withId: id)
    }

    private func handleEditAddress() {
        coordinator.coordinatorPagePush(page: .addressPage)
    }

    private func handlePlaceOrder() {
        if cartManager.isEmpty {
            return
        }
        coordinator.coordinatorPagePush(page: .paymentPage(totalAmount: cartManager.total))
    }

    private func handleApplyPromo(code: String) -> Bool {
        return cartManager.applyPromoCode(code)
    }
}

#Preview {
    CartDetailView()
}
