//
//  PopularFoodManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import Foundation

// MARK: - Popular Fast Food Data Manager
class PopularFastFoodManager {
    static let shared = PopularFastFoodManager()

    private init() {}

    // Popular fast food items
    var popularFastFoods: [PopularFastFood] = [
        PopularFastFood(
            foodName: "Classic Cheeseburger",
            foodImage: "burger1",
            restaurantName: "Burger Palace"
        ),
        PopularFastFood(
            foodName: "Pepperoni Pizza",
            foodImage: "pizza2",
            restaurantName: "Tony's Pizzeria"
        ),
        PopularFastFood(
            foodName: "Chicago Style Dog",
            foodImage: "hotdog3",
            restaurantName: "Windy City Dogs"
        ),
        PopularFastFood(
            foodName: "Philly Cheesesteak",
            foodImage: "sandwich2",
            restaurantName: "Philly's Best"
        ),
        PopularFastFood(
            foodName: "Bacon BBQ Burger",
            foodImage: "burger2",
            restaurantName: "Grill Master"
        ),
        PopularFastFood(
            foodName: "BBQ Chicken Pizza",
            foodImage: "pizza3",
            restaurantName: "Pizza House"
        ),
        PopularFastFood(
            foodName: "Chili Cheese Dog",
            foodImage: "hotdog2",
            restaurantName: "Dog House"
        ),
        PopularFastFood(
            foodName: "Club Sandwich",
            foodImage: "sandwich1",
            restaurantName: "Sandwich Shop"
        ),
        PopularFastFood(
            foodName: "Margherita Pizza",
            foodImage: "pizza1",
            restaurantName: "Pizza Paradise"
        ),
        PopularFastFood(
            foodName: "Mushroom Swiss Burger",
            foodImage: "burger3",
            restaurantName: "Burger Heaven"
        )
    ]

    // Get all popular fast foods
    func getAllPopularFastFoods() -> [PopularFastFood] {
        return popularFastFoods
    }

    // Get random popular fast foods
    func getRandomPopularFastFoods(count: Int = 5) -> [PopularFastFood] {
        return Array(popularFastFoods.shuffled().prefix(count))
    }

    // Get popular fast foods by restaurant
    func getPopularFastFoods(forRestaurant restaurantName: String) -> [PopularFastFood] {
        return popularFastFoods.filter { $0.restaurantName == restaurantName }
    }
}
