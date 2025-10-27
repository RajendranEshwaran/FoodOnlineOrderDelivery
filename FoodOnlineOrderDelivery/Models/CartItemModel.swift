//
//  CartItemModel.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import Foundation

// MARK: - Cart Item Model
struct CartItem: Identifiable, Hashable {
    let id: String
    let name: String
    let image: String
    let price: Double
    let size: String
    var quantity: Int
    let restaurantName: String

    init(id: String = UUID().uuidString,
         name: String,
         image: String,
         price: Double,
         size: String = "Medium",
         quantity: Int = 1,
         restaurantName: String) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.size = size
        self.quantity = quantity
        self.restaurantName = restaurantName
    }
}
