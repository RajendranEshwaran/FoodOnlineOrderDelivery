//
//  CategoryDataManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import Foundation

// MARK: - Mock Data
class CategoryDataManager {
    static let shared = CategoryDataManager()

    private init() {}

    // Sample categories with food items
    var categories: [FoodCategory] = [
        FoodCategory(
            name: "All",
            image: "hotfood",
            foodItems: []
        ),
        FoodCategory(
            name: "Hot Dog",
            image: "hotdog3",
            foodItems: [
                FoodItem(
                    name: "Classic Hot Dog",
                    description: "Juicy beef hot dog with mustard and ketchup",
                    price: 5.99,
                    image: "hotdog1",
                    rating: 4.5,
                    reviewCount: 120,
                    restaurantName: "Hot Dog Haven",
                    deliveryTime: "15-20 min",
                    category: "Hot Dog"
                ),
                FoodItem(
                    name: "Chili Cheese Dog",
                    description: "Hot dog topped with chili and melted cheese",
                    price: 7.99,
                    image: "hotdog2",
                    rating: 4.7,
                    reviewCount: 95,
                    restaurantName: "Dog House",
                    deliveryTime: "20-25 min",
                    category: "Hot Dog"
                ),
                FoodItem(
                    name: "Chicago Style Dog",
                    description: "All-beef hot dog with classic Chicago toppings",
                    price: 8.49,
                    image: "hotdog3",
                    rating: 4.8,
                    reviewCount: 150,
                    restaurantName: "Windy City Dogs",
                    deliveryTime: "25-30 min",
                    category: "Hot Dog"
                )
            ]
        ),
        FoodCategory(
            name: "Breads",
            image: "breads",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "fried-chicken")
        ),
        FoodCategory(
            name: "Chicken",
            image: "chicken",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "fried-chicken")
        ),
        FoodCategory(
            name: "Burger",
            image: "burger1",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "burgers")
        ),
        FoodCategory(
            name: "Sandwich",
            image: "sandwich1",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "sandwiches")
        ),
        FoodCategory(
            name: "BBQ's",
            image: "bbq",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "bbqs")
        ),
        FoodCategory(
            name: "Pizza",
            image: "pizza1",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "pizzas")
        ),
        FoodCategory(
            name: "Meal",
            image: "meal5",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "meals")
        ),
        FoodCategory(
            name: "Drinks",
            image: "colddrink5",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "drinks")
        ),
        FoodCategory(
            name: "Dessert",
            image: "dessat1",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "desserts")
        ),
        FoodCategory(
            name: "IceCream",
            image: "icecream",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "ice-cream")
        )
    ]

    // Get all food items
    func getAllFoodItems() -> [FoodItem] {
        var allItems: [FoodItem] = []
        for category in categories where category.name != "All" {
            allItems.append(contentsOf: category.foodItems)
        }
        return allItems
    }

    // Get food items by category
    func getFoodItems(for categoryName: String) -> [FoodItem] {
        if categoryName == "All" {
            return getAllFoodItems()
        }
        return categories.first(where: { $0.name == categoryName })?.foodItems ?? []
    }

    // Get category names
    func getCategoryNames() -> [String] {
        return categories.map { $0.name }
    }
}
