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
                HStack {
                    Image(icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray))
                        .shadow(radius: 2)
                    
                    Text(title)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(isSelected ? .white : .black)
                        
                }.padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .background(isSelected ? Color("ButtonColor") : Color(UIColor.white))
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
