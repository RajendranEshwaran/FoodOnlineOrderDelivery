//
//  MyOrderView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/27/25.
//

import SwiftUI

struct MyOrderView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State private var selectedSegment = 0
    @State private var cartItemCount = 0

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: "My Orders",
                cartItemCount: cartItemCount,
                isMenuEnable: false,
                isBackEnable: true,
                isUserInfo: false,
                isCartEnable: false,
                onCartTap: {
                    coordinator.coordinatorPagePush(page: .cartPage)
                },
                onBackTap: {
                    coordinator.coordinatorPopToPage()
                }
            )

            // Segmented Control
            Picker("Order Type", selection: $selectedSegment) {
                Text("Ongoing").tag(0)
                Text("History").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 20)
            .padding(.vertical, 16)

            // Content based on selected segment
            if selectedSegment == 0 {
                OngoingOrdersView()
            } else {
                OrderHistoryView()
            }

            Spacer()
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Ongoing Orders View
struct OngoingOrdersView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Sample ongoing order card
                OrderCard(
                    orderNumber: "#12345",
                    restaurantName: "Pizza Palace",
                    orderDate: "Today, 2:30 PM",
                    status: "Preparing",
                    totalAmount: 25.99,
                    items: ["Margherita Pizza", "Garlic Bread"],
                    isOngoing: true
                )

                OrderCard(
                    orderNumber: "#12344",
                    restaurantName: "Burger Barn",
                    orderDate: "Today, 1:15 PM",
                    status: "On the way",
                    totalAmount: 18.50,
                    items: ["Classic Burger", "French Fries", "Cola"],
                    isOngoing: true
                )

                // Empty state if no orders
                if false {
                    EmptyOrdersView(
                        icon: "clock",
                        title: "No Ongoing Orders",
                        message: "You don't have any orders in progress"
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
    }
}

// MARK: - Order History View
struct OrderHistoryView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Sample completed order cards
                OrderCard(
                    orderNumber: "#12343",
                    restaurantName: "Sushi House",
                    orderDate: "Yesterday, 7:45 PM",
                    status: "Delivered",
                    totalAmount: 42.00,
                    items: ["California Roll", "Salmon Nigiri", "Miso Soup"],
                    isOngoing: false
                )

                OrderCard(
                    orderNumber: "#12342",
                    restaurantName: "Taco Town",
                    orderDate: "Oct 25, 6:20 PM",
                    status: "Delivered",
                    totalAmount: 15.75,
                    items: ["Beef Tacos x3", "Nachos"],
                    isOngoing: false
                )

                OrderCard(
                    orderNumber: "#12341",
                    restaurantName: "Pasta Paradise",
                    orderDate: "Oct 24, 8:10 PM",
                    status: "Delivered",
                    totalAmount: 28.50,
                    items: ["Carbonara", "Caesar Salad", "Tiramisu"],
                    isOngoing: false
                )

                // Empty state if no orders
                if false {
                    EmptyOrdersView(
                        icon: "doc.text",
                        title: "No Order History",
                        message: "Your completed orders will appear here"
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 8)
        }
    }
}


#Preview {
    MyOrderView()
        .environmentObject(Coordinator())
}
