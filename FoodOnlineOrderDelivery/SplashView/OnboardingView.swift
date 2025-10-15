//
//  OnboardingView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/14/25.
//

import SwiftUI

struct OnboardingPage {
    let image: String
    let messageText: String
    let buttonText: String
}

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var showLoginView = false
    @EnvironmentObject private var coordinator: Coordinator
    let pages: [OnboardingPage] = [
        OnboardingPage(image: "cart.fill", messageText: "Browse delicious food from your favorite restaurants", buttonText: "Next"),
        OnboardingPage(image: "bag.fill", messageText: "Order your meals with just a few taps", buttonText: "Next"),
        OnboardingPage(image: "bag.fill", messageText: "Order your meals from choose cheff", buttonText: "Next"),
        OnboardingPage(image: "checkmark.circle.fill", messageText: "Free delivery offers", buttonText: "Next"),
        OnboardingPage(image: "checkmark.circle.fill", messageText: "Get fast delivery right to your door", buttonText: "Get Started")
    ]

    var body: some View {
        //NavigationStack {
            VStack {
                TabView(selection: $currentPage) {
                ForEach(0..<pages.count, id: \.self) { index in
                    VStack(spacing: 30) {
                        ZStack {
                            Rectangle()
                                .fill(.gray).opacity(0.3)
                                .frame(width: 250, height: 300, alignment: .center)
                            Image(systemName: pages[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                                .foregroundColor(.blue)
                        }
                        Text(pages[index].messageText)
                            .font(.title2).fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)

                        Button(action: {
                            if currentPage < pages.count - 1 {
                                withAnimation {
                                    currentPage += 1
                                }
                            } else {
                                showLoginView = true
                               // coordinator.coordinatorFullCoverPresent(fullcover: .loginPage)
                               // coordinator.coordinatorPagePresent(page: .login1)
                                coordinator.coordinatorPagePush(page: .login1)
                            }
                        }) {
                            Text(pages[index].buttonText)
                                .font(.title2).fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                                .background(Color("ButtonColor"))
                                .cornerRadius(10)
                        }

                        if currentPage < pages.count - 1 {
                            Button(action: {
                                // Handle skip action
                                withAnimation {
                                    currentPage = pages.count - 1
                                }
                            }) {
                                Text("Skip")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }

       // }
    }
}

#Preview {
    OnboardingView()
}
