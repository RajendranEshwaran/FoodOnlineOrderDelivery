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
            image: "􀙭",
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
            name: "Hot Drink",
            image: "hotdrink1",
            foodItems: [
                FoodItem(
                    name: "Cappuccino",
                    description: "Rich espresso with steamed milk and foam",
                    price: 4.99,
                    image: "hotdrink1",
                    rating: 4.7,
                    reviewCount: 300,
                    restaurantName: "Coffee Corner",
                    deliveryTime: "10-15 min",
                    category: "Hot Drink"
                ),
                FoodItem(
                    name: "Hot Chocolate",
                    description: "Creamy hot chocolate topped with whipped cream",
                    price: 3.99,
                    image: "hotdrink2",
                    rating: 4.6,
                    reviewCount: 150,
                    restaurantName: "Cozy Café",
                    deliveryTime: "10-15 min",
                    category: "Hot Drink"
                ),
                FoodItem(
                    name: "Chai Latte",
                    description: "Spiced tea with steamed milk",
                    price: 4.49,
                    image: "hotdrink3",
                    rating: 4.5,
                    reviewCount: 120,
                    restaurantName: "Tea House",
                    deliveryTime: "10-15 min",
                    category: "Hot Drink"
                )
            ]
        ),
        FoodCategory(
            name: "Pizza",
            image: "pizza1",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "pizzas")
        ),
        FoodCategory(
            name: "Cold Drink",
            image: "colddrink5",
            foodItems: [
                FoodItem(
                    name: "Iced Coffee",
                    description: "Chilled coffee with ice and milk",
                    price: 4.49,
                    image: "colddrink1",
                    rating: 4.6,
                    reviewCount: 200,
                    restaurantName: "Ice Brew",
                    deliveryTime: "10-15 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Fruit Smoothie",
                    description: "Blend of fresh fruits and yogurt",
                    price: 5.99,
                    image: "colddrink2",
                    rating: 4.8,
                    reviewCount: 180,
                    restaurantName: "Smoothie Bar",
                    deliveryTime: "10-15 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Lemonade",
                    description: "Freshly squeezed lemon juice with a hint of sweetness",
                    price: 3.49,
                    image: "colddrink3",
                    rating: 4.4,
                    reviewCount: 130,
                    restaurantName: "Fresh Drinks",
                    deliveryTime: "5-10 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Bubble Tea",
                    description: "Tea with chewy tapioca pearls",
                    price: 5.49,
                    image: "colddrink4",
                    rating: 4.7,
                    reviewCount: 220,
                    restaurantName: "Boba Shop",
                    deliveryTime: "15-20 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Spinach Drink",
                    description: "Spinach with chewy tapioca pearls",
                    price: 5.49,
                    image: "colddrink5",
                    rating: 4.7,
                    reviewCount: 220,
                    restaurantName: "Boba Shop",
                    deliveryTime: "15-20 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Lemmanade",
                    description: "Lemon with chewy tapioca pearls",
                    price: 5.49,
                    image: "colddrink4",
                    rating: 4.7,
                    reviewCount: 220,
                    restaurantName: "Boba Shop",
                    deliveryTime: "15-20 min",
                    category: "Cold Drink"
                )
            ]
        ),
        FoodCategory(
            name: "Dessert",
            image: "dessat1",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "desserts")
        ),
        FoodCategory(
            name: "Meal",
            image: "meal5",
            foodItems: JsonReadDataManager.shared.loadSandwiches(jsonFileName: "meals")
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
