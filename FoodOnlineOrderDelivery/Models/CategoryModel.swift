//
//  CategoryModel.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import Foundation
import SwiftUI

// MARK: - Food Item Model
struct FoodItem: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let image: String // Image name or URL
    let rating: Double
    let reviewCount: Int
    let restaurantName: String
    let deliveryTime: String
    let category: String
    let size: String
    let country: String?

    init(id: String = UUID().uuidString,
         name: String,
         description: String,
         price: Double,
         image: String,
         rating: Double = 4.5,
         reviewCount: Int = 100,
         restaurantName: String,
         deliveryTime: String = "20-30 min",
         category: String,
         size: String = "Medium",
         country: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.image = image
        self.rating = rating
        self.reviewCount = reviewCount
        self.restaurantName = restaurantName
        self.deliveryTime = deliveryTime
        self.category = category
        self.size = size
        self.country = country
    }
}

// MARK: - Category Model
struct FoodCategory: Identifiable, Codable {
    let id: String
    let name: String
    let image: String // Image name or URL
    var foodItems: [FoodItem]

    init(id: String = UUID().uuidString,
         name: String,
         image: String,
         foodItems: [FoodItem] = []) {
        self.id = id
        self.name = name
        self.image = image
        self.foodItems = foodItems
    }
}
