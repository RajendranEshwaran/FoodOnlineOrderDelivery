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
    let deliveryTime: String
    let isOpen: Bool

    init(id: String = UUID().uuidString,
         name: String,
         image: String,
         rating: Double = 4.5,
         deliveryTime: String = "20-30 min",
         isOpen: Bool = true) {
        self.id = id
        self.name = name
        self.image = image
        self.rating = rating
        self.deliveryTime = deliveryTime
        self.isOpen = isOpen
    }
}
