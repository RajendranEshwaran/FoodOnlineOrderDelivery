//
//  CategoryItem.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import SwiftUI

struct CategoryItem: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    let icon: String
    var body: some View {
            
            Button(action: action) {
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 44, height: 44)
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                        Image(icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 28, height: 28)
                    }

                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(isSelected ? .white : .black)

                }.padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(isSelected ? Color("ButtonColor") : Color(UIColor.systemGray6))
                    .cornerRadius(30)
            }
        
    }
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

#Preview {
    HStack {
        CategoryItem(title: "All", isSelected: true, action: {}, icon: "􀙭")
        CategoryItem(title: "Hot Dog", isSelected: false, action: {}, icon: "􀙭")
    }
}
