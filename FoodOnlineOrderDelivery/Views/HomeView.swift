//
//  HomeView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/16/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
        Text("Home")
        Button(action: {
            //dismiss()
            coordinator.coordinatorDissmissFullCover()
        }) {
            Text("test")
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    HomeView()
}
