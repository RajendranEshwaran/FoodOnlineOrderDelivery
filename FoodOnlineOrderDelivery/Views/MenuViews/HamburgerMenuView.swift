//
//  HamburgerMenuView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/23/25.
//

import SwiftUI



struct HamburgerMenuView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject private var coordinator: Coordinator

    // User Info
    let profileImage: String
    let userName: String
    let userStatus: String

    var onLogout: (() -> Void)?

    var body: some View {
        ZStack {
            // Background
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented = false
                }
            
                // Menu Content
                HStack(spacing: 0) {
                    VStack(spacing: 0) {
                        // Profile Section
                        VStack(spacing: 16) {
                            // Profile Image
                            ZStack {
                                Circle()
                                    .fill(Color.orange.opacity(0.2))
                                    .frame(width: 80, height: 80)
                                
                                if profileImage.isEmpty {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.orange)
                                } else {
                                    Image(profileImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 80)
                                        .clipShape(Circle())
                                }
                            }
                            
                            // User Name
                            Text(userName)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.black)
                            
                            // User Status
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)
                                
                                Text(userStatus)
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                            }
                            
                            // Logout Button
                            Button(action: {
                                handleLogout()
                            }) {
                                HStack(spacing: 8) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .font(.system(size: 16))
                                    
                                    Text("Logout")
                                        .font(.system(size: 15, weight: .medium))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.red)
                                .cornerRadius(10)
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 60)
                        .padding(.bottom, 30)
                        
                        // Menu Sections
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 24) {
                                // Menu Section 1
                                MenuSection(
                                    title: "General",
                                    items: [
                                        MenuItem(type: .cart),
                                        MenuItem(type: .orderHistory),
                                        MenuItem(type: .favourites),
                                        MenuItem(type: .paymentMethod),
                                        MenuItem(type: .notifications)
                                    ],
                                    onItemTap: { type in
                                        handleMenuTap(item: type)
                                    }
                                )
                                
                                Divider()
                                    .padding(.horizontal, 20)
                                
                                // Menu Section 2
                                MenuSection(
                                    title: "Account",
                                    items: [
                                        MenuItem(type: .personalInfo),
                                        MenuItem(type: .addresses)
                                    ],
                                    onItemTap: { type in
                                        handleMenuTap(item: type)
                                    }
                                )
                                
                                Divider()
                                    .padding(.horizontal, 20)
                                
                                // Menu Section 3
                                MenuSection(
                                    title: "Support & Settings",
                                    items: [
                                        MenuItem(type: .reviews),
                                        MenuItem(type: .faq),
                                        MenuItem(type: .settings)
                                    ],
                                    onItemTap: { type in
                                        handleMenuTap(item: type)
                                    }
                                )
                                
                                Spacer(minLength: 40)
                            }
                        }
                    }
                    .frame(width: 280)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 5, y: 0)
                    
                    Spacer()
                }
        }
        .transition(.move(edge: .leading))
        .animation(.easeInOut(duration: 0.3), value: UUID())
    }

    // MARK: - Actions
    private func handleLogout() {
        print("Logout tapped")
        isPresented = false
        onLogout?()
        // TODO: Implement logout functionality
        coordinator.setRootPage(page: .login1)
    }

    private func handleMenuTap(item: MenuItemType) {
        print("\(item.rawValue) tapped")
        isPresented = false

        switch item {
        case .cart:
            coordinator.coordinatorPagePush(page: .cartPage)
        case .orderHistory:
            coordinator.coordinatorPagePush(page: .ordersPage)
        case .favourites:
            // TODO: Navigate to favourites page
            break
        case .paymentMethod:
            coordinator.coordinatorPagePush(page: .paymentPage(totalAmount: 0))
        case .notifications:
            // TODO: Navigate to notifications page
            break
        case .personalInfo:
            // TODO: Navigate to personal info page
            break
        case .addresses:
            // TODO: Navigate to addresses page
            break
        case .reviews:
            // TODO: Navigate to reviews page
            break
        case .faq:
            // TODO: Navigate to FAQ page
            break
        case .settings:
            // TODO: Navigate to settings page
            break
        }
    }
}

#Preview {
    HamburgerMenuView(
        isPresented: .constant(true),
        profileImage: "",
        userName: "John Doe",
        userStatus: "Active"
    )
    .environmentObject(Coordinator())
}
