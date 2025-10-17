//
//  HeaderViews.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/15/25.
//

import Foundation
import SwiftUI

struct HeaderViews: View {
    let titleText: String
    let bodyText: String
    let titleTextColor, bodyTextColor: Color
    var body: some View {
        VStack {
            Text(titleText)
                .font(.largeTitle)
                .foregroundStyle(titleTextColor)
                .fontWeight(.semibold)
                .padding(10)
            
            Text(bodyText)
                .font(.title3)
                .foregroundStyle(bodyTextColor)
                .fontWeight(.semibold)
        }
    }
}
