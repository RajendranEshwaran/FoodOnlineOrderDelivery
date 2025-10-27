//
//  MenuManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/23/25.
//

import SwiftUI


// MARK: - Menu Item Type Enum
enum MenuItemType: String, CaseIterable {
    case cart = "Cart"
    case orderHistory = "Order History"
    case favourites = "Favourites"
    case paymentMethod = "Payment Method"
    case notifications = "Notifications"
    case personalInfo = "Personal Info"
    case addresses = "Addresses"
    case reviews = "Reviews"
    case faq = "FAQ"
    case settings = "Settings"

    var icon: String {
        switch self {
        case .cart: return "cart.fill"
        case .orderHistory: return "clock.fill"
        case .favourites: return "heart.fill"
        case .paymentMethod: return "creditcard.fill"
        case .notifications: return "bell.fill"
        case .personalInfo: return "person.fill"
        case .addresses: return "location.fill"
        case .reviews: return "star.fill"
        case .faq: return "questionmark.circle.fill"
        case .settings: return "gear"
        }
    }
}

// MARK: - Menu Item Model
struct MenuItem: Identifiable {
    let id = UUID()
    let type: MenuItemType

    var icon: String {
        type.icon
    }

    var title: String {
        type.rawValue
    }
}

// MARK: - Menu Section Component
struct MenuSection: View {
    let title: String
    let items: [MenuItem]
    let onItemTap: (MenuItemType) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section Title
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
                .padding(.top, 8)

            // Menu Items
            VStack(spacing: 4) {
                ForEach(items) { item in
                    MenuItemRow(item: item, onTap: {
                        onItemTap(item.type)
                    })
                }
            }
        }
    }
}

// MARK: - Menu Item Row
struct MenuItemRow: View {
    let item: MenuItem
    let onTap: () -> Void
    @State private var isPressed = false

    var body: some View {
        Button(action: {
            onTap()
        }) {
            HStack(spacing: 16) {
                Image(systemName: item.icon)
                    .font(.system(size: 18))
                    .foregroundColor(.orange)
                    .frame(width: 24)

                Text(item.title)
                    .font(.system(size: 16))
                    .foregroundColor(.black)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray.opacity(0.5))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 14)
            .background(isPressed ? Color.gray.opacity(0.1) : Color.clear)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    isPressed = true
                }
                .onEnded { _ in
                    isPressed = false
                }
        )
    }
}
