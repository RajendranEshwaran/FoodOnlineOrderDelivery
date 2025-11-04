//
//  CategoryDataManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import Foundation

// MARK: - Category Definition
struct CategoryDefinition {
    let name: String
    let image: String
    let jsonFileName: String?
    let staticItems: [FoodItem]

    init(name: String, image: String, jsonFileName: String? = nil, staticItems: [FoodItem] = []) {
        self.name = name
        self.image = image
        self.jsonFileName = jsonFileName
        self.staticItems = staticItems
    }
}

// MARK: - Mock Data
class CategoryDataManager {
    static let shared = CategoryDataManager()

    private init() {
        // Pre-load only the category metadata
        initializeCategories()
    }

    // Cache for loaded food items
    private var foodItemsCache: [String: [FoodItem]] = [:]
    private let cacheQueue = DispatchQueue(label: "com.fooddelivery.cache", attributes: .concurrent)

    // Category definitions (lightweight)
    private var categoryDefinitions: [CategoryDefinition] = []

    private func initializeCategories() {
        categoryDefinitions = [
            CategoryDefinition(name: "All", image: "hotfood"),
            CategoryDefinition(name: "Breads", image: "breads", jsonFileName: "fried-chicken"),
            CategoryDefinition(name: "Chicken", image: "chicken", jsonFileName: "fried-chicken"),
            CategoryDefinition(name: "Burger", image: "burger1", jsonFileName: "burgers"),
            CategoryDefinition(name: "Sandwich", image: "sandwich1", jsonFileName: "sandwiches"),
            CategoryDefinition(name: "BBQ's", image: "bbq", jsonFileName: "bbqs"),
            CategoryDefinition(name: "Pizza", image: "pizza1", jsonFileName: "pizzas"),
            CategoryDefinition(name: "Meal", image: "meal5", jsonFileName: "meals"),
            CategoryDefinition(name: "Drinks", image: "colddrink5", jsonFileName: "drinks"),
            CategoryDefinition(name: "Dessert", image: "dessat1", jsonFileName: "desserts"),
            CategoryDefinition(name: "IceCream", image: "icecream", jsonFileName: "ice-cream")
        ]
    }

    // Computed property for categories (lightweight)
    var categories: [FoodCategory] {
        return categoryDefinitions.map { definition in
            FoodCategory(name: definition.name, image: definition.image, foodItems: [])
        }
    }

    // Lazy load food items for a specific category
    private func loadFoodItemsForCategory(_ categoryName: String) -> [FoodItem] {
        // Check cache first
        if let cachedItems = cacheQueue.sync(execute: { foodItemsCache[categoryName] }) {
            return cachedItems
        }

        // Find category definition
        guard let definition = categoryDefinitions.first(where: { $0.name == categoryName }) else {
            return []
        }

        // Load items
        var items: [FoodItem] = []

        if !definition.staticItems.isEmpty {
            items = definition.staticItems
        } else if let jsonFileName = definition.jsonFileName {
            items = JsonReadDataManager.shared.loadSandwiches(jsonFileName: jsonFileName)
        }

        // Cache the items
        cacheQueue.async(flags: .barrier) { [weak self] in
            self?.foodItemsCache[categoryName] = items
        }

        return items
    }

    // Get all food items (lazy loaded with limit)
    func getAllFoodItems(limit: Int? = nil) -> [FoodItem] {
        var allItems: [FoodItem] = []
        for definition in categoryDefinitions where definition.name != "All" {
            let items = loadFoodItemsForCategory(definition.name)
            allItems.append(contentsOf: items)
        }

        if let limit = limit {
            return Array(allItems.prefix(limit))
        }
        return allItems
    }

    // Get food items by category (lazy loaded)
    func getFoodItems(for categoryName: String, limit: Int? = nil) -> [FoodItem] {
        if categoryName == "All" {
            return getAllFoodItems(limit: limit)
        }

        let items = loadFoodItemsForCategory(categoryName)

        if let limit = limit {
            return Array(items.prefix(limit))
        }
        return items
    }

    // Get category names
    func getCategoryNames() -> [String] {
        return categoryDefinitions.map { $0.name }
    }

    // Pre-load specific categories in background
    func preloadCategories(_ categoryNames: [String]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            for name in categoryNames {
                _ = self?.loadFoodItemsForCategory(name)
            }
        }
    }

    // Clear cache if needed
    func clearCache() {
        cacheQueue.async(flags: .barrier) { [weak self] in
            self?.foodItemsCache.removeAll()
        }
    }
}
