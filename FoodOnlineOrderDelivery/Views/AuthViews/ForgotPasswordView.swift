//
//  ForgotPasswordView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/15/25.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var rememberMe: Bool = false
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
       // NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        HeaderViews(titleText: "Forgot Password", bodyText: "Please sign in into your existing account", titleTextColor: .white, bodyTextColor: .white)
                            .padding(.top, 80)
                    }
                }
                
                VStack(spacing: 0) {
                    Spacer()
                    ZStack(alignment: .top) {
                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                            .fill(.white)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.top, 200)

                        VStack(spacing: 20) {
                            // Email Field
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Email")
                                    .font(.headline)
                                    .foregroundColor(.black)

                                TextField("Enter your email", text: $email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                            }
                            // Login Button
                            Button(action: {
                                // Handle login action
                                coordinator.coordinatorPagePush(page: .verificationPage)
                            }) {
                                Text("Send Code")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 80)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(10)
                            }

                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 240)
                    }
                }
            }
            .ignoresSafeArea(edges: .all)
        //}
    }
}

#Preview {
    ForgotPasswordView()
}
