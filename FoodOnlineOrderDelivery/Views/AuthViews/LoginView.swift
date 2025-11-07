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
    @State private var emailError: String?
    @State private var passwordError: String?
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var authManager: AuthManager
    @ObservedObject private var localizationManager = LocalizationManager.shared

    var body: some View {
      //  NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        HeaderViews(titleText: "login".localized(), bodyText: "login_subtitle".localized(), titleTextColor: .white, bodyTextColor: .white)
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
                            VStack(alignment: .leading, spacing: 8) {
                                Text("email".localized())
                                    .font(.headline)
                                    .foregroundColor(.black)

                                TextField("email_placeholder".localized(), text: $email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .textInputAutocapitalization(.never)
                                    .keyboardType(.emailAddress)
                                    .onChange(of: email) { _, _ in
                                        emailError = nil
                                    }

                                if let emailError = emailError {
                                    Text(emailError)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }

                            // Password Field
                            VStack(alignment: .leading, spacing: 8) {
                                Text("password".localized())
                                    .font(.headline)
                                    .foregroundColor(.black)

                                HStack {
                                    if isPasswordVisible {
                                        TextField("password_placeholder".localized(), text: $password)
                                            .textInputAutocapitalization(.never)
                                    } else {
                                        SecureField("password_placeholder".localized(), text: $password)
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
                                .onChange(of: password) { _, _ in
                                    passwordError = nil
                                }

                                if let passwordError = passwordError {
                                    Text(passwordError)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                }
                            }
                            
                            // Remember Me and Forgot Password
                            HStack {
                                Button(action: {
                                    rememberMe.toggle()
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                            .foregroundColor(rememberMe ? .blue : .gray)
                                        Text("remember_me".localized())
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
                                    Text("forgot_password".localized())
                                        .font(.subheadline)
                                        .foregroundColor(Color("ButtonColor"))
                                }
                            }

                            // Error message from AuthManager
                            if let errorMessage = authManager.errorMessage {
                                Text(errorMessage)
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                            }

                            // Login Button
                            Button(action: {
                                handleLogin()
                            }) {
                                if authManager.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 80)
                                } else {
                                    Text("login".localized())
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 80)
                                }
                            }
                            .background(Color("ButtonColor"))
                            .cornerRadius(10)
                            .disabled(authManager.isLoading)
                            .padding(.top, 10)

                            // Don't have account and Sign Up
                            HStack(spacing: 5) {
                                Text("dont_have_account".localized())
                                    .font(.subheadline)
                                    .foregroundColor(.gray)

                                Button(action: {
                                    coordinator.coordinatorPagePush(page: .signupPage)
                                }) {
                                    Text("signup".localized())
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color("ButtonColor"))
                                }
                            }
                            .padding(.top, 15)

                            Text("or".localized())
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
            .alert("login_status".localized(), isPresented: $showAlert) {
                Button("ok".localized(), role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
      //  }
    }

    // MARK: - Validation Methods

    private func validateEmail() -> Bool {
        emailError = nil

        // Check if email is empty
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            emailError = "email_required".localized()
            return false
        }

        // Check for consecutive dots (invalid in email addresses)
        if email.contains("..") {
            emailError = "invalid_email".localized()
            return false
        }

        // Email format validation
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        if !emailPredicate.evaluate(with: email) {
            emailError = "invalid_email".localized()
            return false
        }

        return true
    }

    private func validatePassword() -> Bool {
        passwordError = nil

        // Check if password is empty
        if password.isEmpty {
            passwordError = "password_required".localized()
            return false
        }

        // Password length validation
        if password.count < 6 {
            passwordError = "password_min_length".localized()
            return false
        }

        return true
    }

    private func handleLogin() {
        // Validate inputs
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()

        guard isEmailValid && isPasswordValid else {
            return
        }

        // Perform login
        Task {
            let success = await authManager.login(email: email, password: password)

            if success {
                await MainActor.run {
                    // Change root page to home and clear navigation stack
                    coordinator.setRootPage(page: .homePage)
                }
            } else {
                await MainActor.run {
                    alertMessage = authManager.errorMessage ?? "login_failed".localized()
                    showAlert = true
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
