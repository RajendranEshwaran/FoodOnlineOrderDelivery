//
//  TopPanel.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import SwiftUI

struct TopPanel: View {
    var userName: String = "User"
    var cartItemCount: Int = 0
    var isMenuEnable: Bool = true
    var isBackEnable: Bool = false
    var isUserInfo: Bool = true
    var onMenuTap: (() -> Void)?
    var onCartTap: (() -> Void)?
    var onBackTap: (() -> Void)?
    var body: some View {
        HStack(spacing: 16) {
            // Hamburger Menu Button (Left)
            if isMenuEnable {
                Button(action: {
                    onMenuTap?()
                }) {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                }.background(Color.gray)
                    .clipShape(.circle).opacity(0.3)
            }
            
            if isBackEnable {
                // Back Button (Left)
               Button(action: {
                   onBackTap?()
               }) {
                   Image(systemName: "chevron.left")
                       .font(.title3)
                       .foregroundColor(.black)
                       .frame(width: 40, height: 40)
               }
            }
            //Spacer()

            // Deliver To Label (Center)
            if isUserInfo {
                VStack(spacing: 4) {
                    Text("Deliver to")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                            .foregroundColor(Color("ButtonColor"))
                        
                        Text(userName)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                }
            } else {
                Text(userName)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            Spacer()

            // Cart Button with Badge (Right)
            Button(action: {
                onCartTap?()
            }) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "cart.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.black)
                        .clipShape(.circle)
                    // Badge
                    if cartItemCount > 0 {
                        ZStack {
                            Circle()
                                .fill(Color.red)
                                .frame(width: 20, height: 20)

                            Text("\(cartItemCount)")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        .offset(x: 8, y: -8)
                    }
                }
            }
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    VStack {
        TopPanel(userName: "John Doe", cartItemCount: 3, onMenuTap: {
            print("Menu tapped")
        }, onCartTap: {
            print("Cart tapped")
        }, onBackTap: {
            print("Back tapped")
        })
        Spacer()
    }
}
