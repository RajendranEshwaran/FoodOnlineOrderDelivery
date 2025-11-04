//
//  SignupView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/17/25.
//

import SwiftUI

struct SignupView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var retypePassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isRetypePasswordVisible: Bool = false
    @State private var nameError: String?
    @State private var emailError: String?
    @State private var phoneNumberError: String?
    @State private var passwordError: String?
    @State private var retypePasswordError: String?

    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var authManager: AuthManager

    var body: some View {
            ZStack {
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                        HeaderViews(titleText: "Sign Up", bodyText: "Please sign up to get started", titleTextColor: .white, bodyTextColor: .white)
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

                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 20) {
                                // Name Field
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Name")
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    TextField("Enter your name", text: $name)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .textInputAutocapitalization(.words)
                                        .onChange(of: name) { _, _ in
                                            nameError = nil
                                        }

                                    if let nameError = nameError {
                                        Text(nameError)
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
                                }

                                // Email Field
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Email")
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    TextField("Enter your email", text: $email)
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

                                // Phone Number Field
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Phone Number")
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    TextField("Enter your phone number", text: $phoneNumber)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.phonePad)
                                        .onChange(of: phoneNumber) { _, _ in
                                            phoneNumberError = nil
                                        }

                                    if let phoneNumberError = phoneNumberError {
                                        Text(phoneNumberError)
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
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
                                    .onChange(of: password) { _, _ in
                                        passwordError = nil
                                    }

                                    if let passwordError = passwordError {
                                        Text(passwordError)
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
                                }

                                // Re-type Password Field
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Re-type Password")
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    HStack {
                                        if isRetypePasswordVisible {
                                            TextField("Re-enter your password", text: $retypePassword)
                                                .textInputAutocapitalization(.never)
                                        } else {
                                            SecureField("Re-enter your password", text: $retypePassword)
                                                .textInputAutocapitalization(.never)
                                        }

                                        Button(action: {
                                            isRetypePasswordVisible.toggle()
                                        }) {
                                            Image(systemName: isRetypePasswordVisible ? "eye.slash.fill" : "eye.fill")
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                    )
                                    .onChange(of: retypePassword) { _, _ in
                                        retypePasswordError = nil
                                    }

                                    if let retypePasswordError = retypePasswordError {
                                        Text(retypePasswordError)
                                            .font(.caption)
                                            .foregroundColor(.red)
                                    }
                                }

                                // Error message from AuthManager
                                if let errorMessage = authManager.errorMessage {
                                    Text(errorMessage)
                                        .font(.caption)
                                        .foregroundColor(.red)
                                        .multilineTextAlignment(.center)
                                }

                                // Sign Up Button
                                Button(action: {
                                    handleSignUp()
                                }) {
                                    if authManager.isLoading {
                                        ProgressView()
                                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 80)
                                    } else {
                                        Text("Sign Up")
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

                                // Already have account and Sign In
                                HStack(spacing: 5) {
                                    Text("Already have an account?")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)

                                    Button(action: {
                                        coordinator.coordinatorPopToPage()
                                    }) {
                                        Text("Sign In")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("ButtonColor"))
                                    }
                                }
                                .padding(.top, 15)
                                .padding(.bottom, 30)
                            }
                            .padding(.horizontal, 30)
                            .padding(.top, 240)
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .all)
    }

    // MARK: - Validation Methods

    private func validateName() -> Bool {
        nameError = nil

        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            nameError = "Name is required"
            return false
        }

        if name.count < 2 {
            nameError = "Name must be at least 2 characters"
            return false
        }

        return true
    }

    private func validateEmail() -> Bool {
        emailError = nil

        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            emailError = "Email is required"
            return false
        }

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

        if !emailPredicate.evaluate(with: email) {
            emailError = "Please enter a valid email address"
            return false
        }

        return true
    }

    private func validatePhoneNumber() -> Bool {
        phoneNumberError = nil

        if phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty {
            phoneNumberError = "Phone number is required"
            return false
        }

        // Remove all non-digit characters for validation
        let digitsOnly = phoneNumber.filter { $0.isNumber }

        if digitsOnly.count < 10 {
            phoneNumberError = "Phone number must be at least 10 digits"
            return false
        }

        if digitsOnly.count > 15 {
            phoneNumberError = "Phone number is too long"
            return false
        }

        return true
    }

    private func validatePassword() -> Bool {
        passwordError = nil

        if password.isEmpty {
            passwordError = "Password is required"
            return false
        }

        if password.count < 6 {
            passwordError = "Password must be at least 6 characters"
            return false
        }

        return true
    }

    private func validateRetypePassword() -> Bool {
        retypePasswordError = nil

        if retypePassword.isEmpty {
            retypePasswordError = "Please re-enter your password"
            return false
        }

        if password != retypePassword {
            retypePasswordError = "Passwords do not match"
            return false
        }

        return true
    }

    private func handleSignUp() {
        // Validate all inputs
        let isNameValid = validateName()
        let isEmailValid = validateEmail()
        let isPhoneValid = validatePhoneNumber()
        let isPasswordValid = validatePassword()
        let isRetypePasswordValid = validateRetypePassword()

        guard isNameValid && isEmailValid && isPhoneValid && isPasswordValid && isRetypePasswordValid else {
            return
        }

        // Perform sign up
        Task {
            let success = await authManager.signup(email: email, name: name, phoneNumber: phoneNumber, password: password)

            if success {
                await MainActor.run {
                    // Navigate to verification page
                    coordinator.coordinatorPagePush(page: .verificationPage)
                }
            }
            // Error message is already set in AuthManager
        }
    }
}

#Preview {
    SignupView()
}
