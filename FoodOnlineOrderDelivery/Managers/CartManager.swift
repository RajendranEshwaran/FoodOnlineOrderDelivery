//
//  CartManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 11/04/25.
//

import Foundation
import SwiftUI
import Combine

class CartManager: ObservableObject {

    // MARK: - Singleton
    static let shared = CartManager()

    // MARK: - Published Properties
    @Published var cartItems: [CartItem] = []
    @Published var deliveryFee: Double = 2.99
    @Published var taxRate: Double = 0.08 // 8% tax
    @Published var promoCode: String?
    @Published var promoDiscount: Double = 0.0

    // MARK: - Private Properties
    private let cartStorageKey = "SavedCartItems"
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    // MARK: - Computed Properties

    /// Total number of items in cart
    var itemCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }

    /// Subtotal (sum of all items)
    var subtotal: Double {
        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    /// Tax amount
    var tax: Double {
        subtotal * taxRate
    }

    /// Total amount (subtotal + tax + delivery - discount)
    var total: Double {
        let total = subtotal + tax + deliveryFee - promoDiscount
        return max(total, 0) // Ensure total is never negative
    }

    /// Check if cart is empty
    var isEmpty: Bool {
        cartItems.isEmpty
    }

    // MARK: - Initialization
    private init() {
        loadCart()
    }

    // MARK: - Cart Operations

    /// Add item to cart
    func addItem(foodItem: FoodItem, quantity: Int = 1, size: String = "Medium") {
        // Check if item already exists in cart with same size
        if let index = cartItems.firstIndex(where: { $0.name == foodItem.name && $0.size == size }) {
            // Update quantity of existing item
            cartItems[index].quantity += quantity
        } else {
            // Add new item to cart
            let cartItem = CartItem(
                name: foodItem.name,
                image: foodItem.image,
                price: foodItem.price,
                size: size,
                quantity: quantity,
                restaurantName: foodItem.restaurantName
            )
            cartItems.append(cartItem)
        }

        saveCart()
    }

    /// Remove item from cart
    func removeItem(at index: Int) {
        guard index >= 0 && index < cartItems.count else { return }
        cartItems.remove(at: index)
        saveCart()
    }

    /// Remove item by ID
    func removeItem(withId id: String) {
        cartItems.removeAll { $0.id == id }
        saveCart()
    }

    /// Update item quantity
    func updateQuantity(for item: CartItem, quantity: Int) {
        guard let index = cartItems.firstIndex(where: { $0.id == item.id }) else { return }

        if quantity <= 0 {
            // Remove item if quantity is 0 or negative
            cartItems.remove(at: index)
        } else {
            // Update quantity
            cartItems[index].quantity = quantity
        }

        saveCart()
    }

    /// Increase item quantity by 1
    func incrementQuantity(for item: CartItem) {
        guard let index = cartItems.firstIndex(where: { $0.id == item.id }) else { return }
        cartItems[index].quantity += 1
        saveCart()
    }

    /// Decrease item quantity by 1
    func decrementQuantity(for item: CartItem) {
        guard let index = cartItems.firstIndex(where: { $0.id == item.id }) else { return }

        if cartItems[index].quantity > 1 {
            cartItems[index].quantity -= 1
        } else {
            // Remove item if quantity becomes 0
            cartItems.remove(at: index)
        }

        saveCart()
    }

    /// Clear all items from cart
    func clearCart() {
        cartItems.removeAll()
        promoCode = nil
        promoDiscount = 0.0
        saveCart()
    }

    /// Apply promo code
    func applyPromoCode(_ code: String) -> Bool {
        // Mock promo code validation
        let validPromoCodes: [String: Double] = [
            "SAVE10": 10.0,
            "SAVE20": 20.0,
            "FREESHIP": deliveryFee,
            "WELCOME": 5.0
        ]

        if let discount = validPromoCodes[code.uppercased()] {
            promoCode = code.uppercased()
            promoDiscount = discount
            return true
        }

        return false
    }

    /// Remove promo code
    func removePromoCode() {
        promoCode = nil
        promoDiscount = 0.0
    }

    /// Get item count for specific food item
    func getItemQuantity(for foodItem: FoodItem, size: String = "Medium") -> Int {
        return cartItems.first(where: { $0.name == foodItem.name && $0.size == size })?.quantity ?? 0
    }

    /// Check if item is in cart
    func isInCart(foodItem: FoodItem, size: String = "Medium") -> Bool {
        return cartItems.contains(where: { $0.name == foodItem.name && $0.size == size })
    }

    // MARK: - Persistence

    /// Save cart to UserDefaults
    private func saveCart() {
        do {
            let encoded = try encoder.encode(cartItems)
            UserDefaults.standard.set(encoded, forKey: cartStorageKey)
        } catch {
            print("Error saving cart: \(error.localizedDescription)")
        }
    }

    /// Load cart from UserDefaults
    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: cartStorageKey) else { return }

        do {
            cartItems = try decoder.decode([CartItem].self, from: data)
        } catch {
            print("Error loading cart: \(error.localizedDescription)")
            cartItems = []
        }
    }

    // MARK: - Utility Methods

    /// Format price as currency string
    func formatPrice(_ price: Double) -> String {
        return String(format: "$%.2f", price)
    }

    /// Get restaurant names in cart (for grouping orders)
    func getRestaurants() -> [String] {
        let restaurants = Set(cartItems.map { $0.restaurantName })
        return Array(restaurants).sorted()
    }

    /// Get items by restaurant
    func getItems(for restaurant: String) -> [CartItem] {
        return cartItems.filter { $0.restaurantName == restaurant }
    }

    /// Calculate delivery time estimate
    func estimatedDeliveryTime() -> String {
        if cartItems.isEmpty {
            return "N/A"
        }

        // Base time + additional time per item
        let baseTime = 20
        let timePerItem = 2
        let totalTime = baseTime + (cartItems.count * timePerItem)

        return "\(totalTime)-\(totalTime + 10) min"
    }
}
