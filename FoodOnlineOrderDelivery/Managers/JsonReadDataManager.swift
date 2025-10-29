//
//  JsonReadDataManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Claude on 10/29/25.
//

import Foundation

// MARK: - Sandwich JSON Model
struct FoodItemJSON: Codable {
    let id: String
    let image: String
    let name: String // Restaurant name
    let description: String // Sandwich name/description
    let price: Double
    let rating: Double
    let reviewCount: Int
    let country: String
    let deliveryTime: String
    let category: String
}

// MARK: - JSON Data Manager
class JsonReadDataManager {

    // MARK: - Singleton
    static let shared = JsonReadDataManager()

    private init() {}

    // MARK: - Load Sandwiches
    func loadSandwiches() -> [FoodItem] {
        guard let url = Bundle.main.url(forResource: "sandwiches", withExtension: "json") else {
            print("Error: sandwiches.json file not found")
            return []
        }

        do {
            let data = try Data(contentsOf: url)
            let foodItemJSON = try JSONDecoder().decode([FoodItemJSON].self, from: data)

            // Convert SandwichJSON to FoodItem
            let foodItems = foodItemJSON.map { fooditem in
                FoodItem(
                    id: fooditem.id,
                    name: fooditem.description, // Sandwich name is in description field
                    description: fooditem.description,
                    price: fooditem.price,
                    image: fooditem.image,
                    rating: fooditem.rating,
                    reviewCount: fooditem.reviewCount,
                    restaurantName: fooditem.name, // Restaurant name is in name field
                    deliveryTime: fooditem.deliveryTime,
                    category: fooditem.category,
                    size: "Regular",
                    country: fooditem.country
                )
            }

            print("Successfully loaded \(foodItems.count) sandwiches")
            return foodItems

        } catch {
            print("Error loading sandwiches: \(error.localizedDescription)")
            return []
        }
    }

    // MARK: - Generic JSON Loader
    func loadJSON<T: Codable>(fileName: String, type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Error: \(fileName).json file not found")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            print("Error decoding \(fileName).json: \(error.localizedDescription)")
            return nil
        }
    }
}
