//
//  PopularFastFoodModel.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import Foundation
import SwiftUI

// MARK: - Popular Fast Food Model
struct PopularFastFood: Identifiable, Codable {
    let id: String
    let foodName: String
    let foodImage: String // Image name or URL
    let restaurantName: String

    init(id: String = UUID().uuidString,
         foodName: String,
         foodImage: String,
         restaurantName: String) {
        self.id = id
        self.foodName = foodName
        self.foodImage = foodImage
        self.restaurantName = restaurantName
    }
}
