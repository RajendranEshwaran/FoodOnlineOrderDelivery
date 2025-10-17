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

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(isSelected ? .white : .black)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(isSelected ? Color("ButtonColor") : Color(UIColor.systemGray6))
                .cornerRadius(20)
        }
    }
}

struct Category: Identifiable {
    let id = UUID()
    let name: String
}

#Preview {
    HStack {
        CategoryItem(title: "All", isSelected: true, action: {})
        CategoryItem(title: "Hot Dog", isSelected: false, action: {})
    }
}
