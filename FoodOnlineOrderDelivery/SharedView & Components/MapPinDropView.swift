//
//  MapPinDropView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/27/25.
//

import SwiftUI
import MapKit

// MARK: - Map Pin Drop View
struct MapPinDropView: View {
    @Binding var region: MKCoordinateRegion
    @Binding var latitude: Double
    @Binding var longitude: Double

    var body: some View {
        ZStack {
            // Use the new iOS 17+ Map API with region binding
            Map(position: .constant(.region(region)))
                .mapStyle(.standard)
                .gesture(
                    DragGesture()
                        .onEnded { _ in
                            updateCoordinates()
                        }
                )

            // Pin in the center
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(.red)
                .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)

            // Crosshair for precise positioning
            VStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 1, height: 20)
                Spacer()
            }
            .frame(height: 250)

            HStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 20, height: 1)
                Spacer()
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 20, height: 1)
            }
        }
    }

    private func updateCoordinates() {
        latitude = region.center.latitude
        longitude = region.center.longitude
    }
}
