//
//  UtilityManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 11/7/25.
//

import Foundation

class UtilityManager {
    
    static let shared = UtilityManager()
    
    private init () {
        
    }
    
    // Computed property for time-based greeting
    var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12:
            return "Good Morning"
        case 12..<17:
            return "Good Afternoon"
        default:
            return "Good Evening"
        }
    }
}
