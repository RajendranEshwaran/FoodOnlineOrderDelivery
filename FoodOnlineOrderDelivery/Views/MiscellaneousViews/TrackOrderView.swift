//
//  TrackOrderView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/23/25.
//

import SwiftUI
import MapKit

struct TrackOrderView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    @State private var cartItemCount: Int = 3
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    let orderNumber: String
    let driverName: String
    let driverPhone: String
    let estimatedArrival: String

    // Sample delivery locations
    @State private var restaurantLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
    @State private var deliveryLocation = CLLocationCoordinate2D(latitude: 37.7849, longitude: -122.4094)
    @State private var driverLocation = CLLocationCoordinate2D(latitude: 37.7799, longitude: -122.4144)

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: "Track Order",
                cartItemCount: cartItemCount,
                isMenuEnable: false,
                isBackEnable: true,
                isUserInfo: false,
                isCartEnable: false,
                onCartTap: {
                    print("Cart tapped")
                }, onBackTap: {
                    coordinator.coordinatorPopToPage()
                }
            )

            ZStack(alignment: .bottom) {
                // Map View
                Map(coordinateRegion: $region, annotationItems: mapLocations) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: location.icon)
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(location.color)
                                .clipShape(Circle())
                                .shadow(radius: 4)

                            if location.showLabel {
                                Text(location.name)
                                    .font(.system(size: 10, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.black.opacity(0.7))
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .edgesIgnoringSafeArea(.horizontal)

                // Bottom Card with Order Details
                VStack(spacing: 0) {
                    // Handle bar
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 5)
                        .padding(.top, 12)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Order Status Header
                            HStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.orange.opacity(0.2))
                                        .frame(width: 50, height: 50)

                                    Image(systemName: "bicycle")
                                        .font(.system(size: 24))
                                        .foregroundColor(.orange)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Order on the way")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.black)

                                    Text("Arriving in \(estimatedArrival)")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)
                                }

                                Spacer()
                            }
                            .padding(.top, 16)

                            Divider()

                            // Driver Information
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Delivery Partner")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)

                                HStack(spacing: 12) {
                                    // Driver Avatar
                                    ZStack {
                                        Circle()
                                            .fill(Color.orange.opacity(0.2))
                                            .frame(width: 50, height: 50)

                                        Image(systemName: "person.fill")
                                            .font(.system(size: 24))
                                            .foregroundColor(.orange)
                                    }

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(driverName)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)

                                        HStack(spacing: 4) {
                                            Image(systemName: "star.fill")
                                                .font(.system(size: 12))
                                                .foregroundColor(.orange)

                                            Text("4.8")
                                                .font(.system(size: 13))
                                                .foregroundColor(.gray)

                                            Text("• 234 deliveries")
                                                .font(.system(size: 13))
                                                .foregroundColor(.gray)
                                        }
                                    }

                                    Spacer()

                                    // Call Button
                                    Button(action: {
                                        handleCallDriver()
                                    }) {
                                        Image(systemName: "phone.fill")
                                            .font(.system(size: 18))
                                            .foregroundColor(.white)
                                            .frame(width: 44, height: 44)
                                            .background(Color.orange)
                                            .clipShape(Circle())
                                    }
                                }
                            }

                            Divider()

                            // Order Details
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Order Details")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)

                                HStack {
                                    Text("Order Number")
                                        .font(.system(size: 14))
                                        .foregroundColor(.gray)

                                    Spacer()

                                    Text("#\(orderNumber)")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(.black)
                                }

                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "location.fill")
                                        .font(.system(size: 16))
                                        .foregroundColor(.orange)
                                        .frame(width: 20)

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Delivery Address")
                                            .font(.system(size: 13))
                                            .foregroundColor(.gray)

                                        Text("123 Main Street, Apt 4B, New York, NY 10001")
                                            .font(.system(size: 14))
                                            .foregroundColor(.black)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                            }

                            Divider()

                            // Delivery Progress
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Delivery Progress")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.black)

                                // Progress Steps
                                DeliveryProgressStep(
                                    icon: "checkmark.circle.fill",
                                    title: "Order Placed",
                                    subtitle: "Your order has been confirmed",
                                    isCompleted: true,
                                    isLast: false
                                )

                                DeliveryProgressStep(
                                    icon: "checkmark.circle.fill",
                                    title: "Preparing Food",
                                    subtitle: "Restaurant is preparing your order",
                                    isCompleted: true,
                                    isLast: false
                                )

                                DeliveryProgressStep(
                                    icon: "circle.fill",
                                    title: "Out for Delivery",
                                    subtitle: "Driver is on the way",
                                    isCompleted: false,
                                    isLast: false,
                                    isActive: true
                                )

                                DeliveryProgressStep(
                                    icon: "circle",
                                    title: "Delivered",
                                    subtitle: "Order will be delivered soon",
                                    isCompleted: false,
                                    isLast: true
                                )
                            }

                            Spacer(minLength: 20)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 500)
                .background(Color.white)
                .cornerRadius(24, corners: [.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
            }
        }
        .background(Color.white)
        .navigationBarHidden(true)
    }

    // Map locations for annotations
    var mapLocations: [MapLocation] {
        [
            MapLocation(
                id: "restaurant",
                name: "Restaurant",
                coordinate: restaurantLocation,
                icon: "fork.knife",
                color: .orange,
                showLabel: true
            ),
            MapLocation(
                id: "driver",
                name: "Driver",
                coordinate: driverLocation,
                icon: "bicycle",
                color: .green,
                showLabel: true
            ),
            MapLocation(
                id: "delivery",
                name: "You",
                coordinate: deliveryLocation,
                icon: "house.fill",
                color: .blue,
                showLabel: true
            )
        ]
    }

    // MARK: - Actions
    private func handleCallDriver() {
        print("Call driver: \(driverPhone)")
        // TODO: Implement phone call functionality
    }
}

// MARK: - Map Location Model
struct MapLocation: Identifiable {
    let id: String
    let name: String
    let coordinate: CLLocationCoordinate2D
    let icon: String
    let color: Color
    let showLabel: Bool
}



// MARK: - Corner Radius Extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


#Preview {
    TrackOrderView(
        orderNumber: "2584",
        driverName: "John Smith",
        driverPhone: "+1 234-567-8900",
        estimatedArrival: "15-20 mins"
    )
    .environmentObject(Coordinator())
}
