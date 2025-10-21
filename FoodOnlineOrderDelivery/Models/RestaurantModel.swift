//
//  RestaurantModel.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import Foundation
import SwiftUI

// MARK: - Restaurant Model
struct Restaurant: Identifiable, Codable {
    let id: String
    let name: String
    let image: String // Image name or URL
    let rating: Double

    init(id: String = UUID().uuidString,
         name: String,
         image: String,
         rating: Double = 4.5) {
        self.id = id
        self.name = name
        self.image = image
        self.rating = rating
    }
}

// MARK: - Suggested Restaurants Data Manager
class SuggestedRestaurantsManager {
    static let shared = SuggestedRestaurantsManager()

    private init() {}

    // Suggested restaurants
    var suggestedRestaurants: [Restaurant] = [
        Restaurant(
            name: "Pizza Paradise",
            image: "pizza1",
            rating: 4.7
        ),
        Restaurant(
            name: "Burger Palace",
            image: "burger1",
            rating: 4.6
        ),
        Restaurant(
            name: "Hot Dog Haven",
            image: "hotdog1",
            rating: 4.5
        ),
        Restaurant(
            name: "Philly's Best",
            image: "sandwich2",
            rating: 4.9
        ),
        Restaurant(
            name: "Coffee Corner",
            image: "hotdrink1",
            rating: 4.7
        ),
        Restaurant(
            name: "Sweet Treats",
            image: "dessat1",
            rating: 4.8
        ),
        Restaurant(
            name: "Steakhouse Prime",
            image: "meal2",
            rating: 4.9
        ),
        Restaurant(
            name: "Smoothie Bar",
            image: "colddrink2",
            rating: 4.8
        ),
        Restaurant(
            name: "Tony's Pizzeria",
            image: "pizza2",
            rating: 4.8
        ),
        Restaurant(
            name: "Dessert Heaven",
            image: "dessat2",
            rating: 4.9
        )
    ]

    // Get random suggested restaurants
    func getRandomSuggestions(count: Int = 5) -> [Restaurant] {
        return Array(suggestedRestaurants.shuffled().prefix(count))
    }

    // Get top rated restaurants
    func getTopRatedRestaurants(count: Int = 5) -> [Restaurant] {
        return Array(suggestedRestaurants.sorted(by: { $0.rating > $1.rating }).prefix(count))
    }
}
