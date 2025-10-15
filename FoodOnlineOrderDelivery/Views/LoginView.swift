//
//  LoginView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/14/25.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var rememberMe: Bool = false
    @EnvironmentObject private var coordinator: Coordinator
    var body: some View {
      //  NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        HeaderViews(titleText: "Login", bodyText: "Please sign in into your existing account", titleTextColor: .white, bodyTextColor: .white)
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

                            // Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Password")
                                    .font(.headline)
                                    .foregroundColor(.black)

                                HStack {
                                    if isPasswordVisible {
                                        TextField("Enter your password", text: $password)
                                            .textInputAutocapitalization(.never)
                                    } else {
                                        SecureField("Enter your password", text: $password)
                                            .textInputAutocapitalization(.never)
                                    }

                                    Button(action: {
                                        isPasswordVisible.toggle()
                                    }) {
                                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                )
                            }
                            
                            // Remember Me and Forgot Password
                            HStack {
                                Button(action: {
                                    rememberMe.toggle()
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                            .foregroundColor(rememberMe ? .blue : .gray)
                                        Text("Remember Me")
                                            .font(.subheadline)
                                            .foregroundColor(.black)
                                    }
                                }

                                Spacer()

                                Button(action: {
                                    //coordinator.coordinatorPagePush(page: .forgotPasswordPage)
                                   // coordinator.coordinatorPagePresent(page: .forgotPasswordPage)
                                    coordinator.coordinatorPagePush(page: .forgotPasswordPage)
                                }) {
                                    Text("Forgot Password?")
                                        .font(.subheadline)
                                        .foregroundColor(Color("ButtonColor"))
                                }
                            }

                            // Login Button
                            Button(action: {
                                // Handle login action
                            }) {
                                Text("Login")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 80)
                                    .background(Color("ButtonColor"))
                                    .cornerRadius(10)
                            }
                            .padding(.top, 10)

                            // Don't have account and Sign Up
                            HStack(spacing: 5) {
                                Text("Don't have an account?")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Button(action: {
                                    // Handle sign up action
                                }) {
                                    Text("Sign Up")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("ButtonColor"))
                                }
                            }
                            .padding(.top, 15)
                            
                            Text("Or")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)

                            // Social Login Buttons
                            HStack(spacing: 20) {
                                // Facebook Button
                                Button(action: {
                                    // Handle Facebook login
                                }) {
                                    Image(systemName: "f.circle.fill")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .foregroundColor(.blue)
                                }

                                // Twitter Button
                                Button(action: {
                                    // Handle Twitter login
                                }) {
                                    Image(systemName: "xmark")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(Circle().fill(Color.gray.opacity(0.2)))
                                }

                                // Apple Button
                                Button(action: {
                                    // Handle Apple login
                                }) {
                                    Image(systemName: "apple.logo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .background(Circle().fill(Color.gray.opacity(0.2)))
                                }
                            }
                            .padding(.top, 10)

                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 240)
                        
                        
                    }
                }
            }
            .ignoresSafeArea(edges: .all)
      //  }
    }
}

#Preview {
    LoginView()
}
