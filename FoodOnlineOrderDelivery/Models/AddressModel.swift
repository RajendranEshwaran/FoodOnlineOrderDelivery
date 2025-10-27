//
//  AddressModel.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/27/25.
//
import Foundation
import SwiftUI
import MapKit

// MARK: - Address Model
struct Address: Identifiable {
    let id: String
    var label: String // Home, Office, Work, etc.
    var streetAddress: String
    var city: String
    var state: String
    var zipCode: String
    var latitude: Double
    var longitude: Double
    var isDefault: Bool

    init(id: String = UUID().uuidString,
         label: String,
         streetAddress: String,
         city: String,
         state: String,
         zipCode: String,
         latitude: Double = 40.7128,
         longitude: Double = -74.0060,
         isDefault: Bool = false) {
        self.id = id
        self.label = label
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.latitude = latitude
        self.longitude = longitude
        self.isDefault = isDefault
    }

    var fullAddress: String {
        return "\(streetAddress), \(city), \(state) \(zipCode)"
    }

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
