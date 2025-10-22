//
//  RestaurentManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by RajayGoms on 10/22/25.
//

import Foundation

// MARK: - Suggested Restaurants Data Manager
class SuggestedRestaurantsManager {
    static let shared = SuggestedRestaurantsManager()

    private init() {}

    // Suggested restaurants
    var suggestedRestaurants: [Restaurant] = [
        Restaurant(
            name: "Pizza Paradise",
            image: "pizza1",
            rating: 4.7,
            deliveryTime: "25-30 min",
            isOpen: true
        ),
        Restaurant(
            name: "Burger Palace",
            image: "burger1",
            rating: 4.6,
            deliveryTime: "20-25 min",
            isOpen: true
        ),
        Restaurant(
            name: "Hot Dog Haven",
            image: "hotdog1",
            rating: 4.5,
            deliveryTime: "15-20 min",
            isOpen: true
        ),
        Restaurant(
            name: "Philly's Best",
            image: "sandwich2",
            rating: 4.9,
            deliveryTime: "20-25 min",
            isOpen: true
        ),
        Restaurant(
            name: "Coffee Corner",
            image: "hotdrink1",
            rating: 4.7,
            deliveryTime: "10-15 min",
            isOpen: true
        ),
        Restaurant(
            name: "Sweet Treats",
            image: "dessat1",
            rating: 4.8,
            deliveryTime: "15-20 min",
            isOpen: true
        ),
        Restaurant(
            name: "Steakhouse Prime",
            image: "meal2",
            rating: 4.9,
            deliveryTime: "35-40 min",
            isOpen: false
        ),
        Restaurant(
            name: "Smoothie Bar",
            image: "colddrink2",
            rating: 4.8,
            deliveryTime: "10-15 min",
            isOpen: true
        ),
        Restaurant(
            name: "Tony's Pizzeria",
            image: "pizza2",
            rating: 4.8,
            deliveryTime: "20-30 min",
            isOpen: true
        ),
        Restaurant(
            name: "Dessert Heaven",
            image: "dessat2",
            rating: 4.9,
            deliveryTime: "15-20 min",
            isOpen: true
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

    // Get open restaurants
    func getOpenRestaurants() -> [Restaurant] {
        return suggestedRestaurants.filter { $0.isOpen }
    }

    // Get open restaurants with count limit
    func getOpenRestaurants(count: Int) -> [Restaurant] {
        return Array(suggestedRestaurants.filter { $0.isOpen }.prefix(count))
    }
}
