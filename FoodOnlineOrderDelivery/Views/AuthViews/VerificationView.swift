//
//  VerificationView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/15/25.
//

import SwiftUI
import Combine

struct VerificationView: View {
    @State private var code1: String = ""
    @State private var code2: String = ""
    @State private var code3: String = ""
    @State private var code4: String = ""
    @FocusState private var focusedField: Int?

    @State private var timeRemaining = 60
    @State private var isTimerRunning = false
    @State private var showResendButton = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showCodeAlert = false

    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var authManager: AuthManager

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        //NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    ZStack(alignment: .top) {
                        Rectangle()
                            .fill(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                        HeaderViews(titleText: "Verification", bodyText: "We have send a code to your email", titleTextColor: .white, bodyTextColor: .white)
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

                        Text("Pls enter your code")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            .padding(.top, 230)
                            .frame(alignment: .leading)
                        
                        VStack(spacing: 20) {
                            // 4-Digit Code Fields
                            HStack(spacing: 15) {
                                CodeTextField(text: $code1, focusedField: $focusedField, index: 0)
                                CodeTextField(text: $code2, focusedField: $focusedField, index: 1)
                                CodeTextField(text: $code3, focusedField: $focusedField, index: 2)
                                CodeTextField(text: $code4, focusedField: $focusedField, index: 3)
                            }
                            .padding(.vertical, 20)

                            // Error message
                            if let errorMessage = authManager.errorMessage {
                                Text(errorMessage)
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .multilineTextAlignment(.center)
                            }

                            // Resend Option
                            HStack {
                                Spacer()
                                if isTimerRunning {
                                    Text("Resend code in \(timeRemaining)s")
                                                        .font(.headline)
                                } else {
                                    Button(action: {
                                        handleResendCode()
                                    }) {
                                        Text("Resend")
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color("ButtonColor"))
                                    }
                                    .disabled(authManager.isLoading)
                                }
                            }

                            // Verify Button
                            Button(action: {
                                handleVerification()
                            }) {
                                if authManager.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 80)
                                } else {
                                    Text("Verify")
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

                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 240)
                    }
                }
            }
            .ignoresSafeArea(.all)
            .overlay(
                // Custom Code Alert Overlay
                Group {
                    if showCodeAlert {
                        ZStack {
                            // Semi-transparent background
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                                .onTapGesture {
                                    withAnimation {
                                        showCodeAlert = false
                                    }
                                }

                            // Alert Card
                            VStack(spacing: 20) {
                                // Header Icon
                                ZStack {
                                    Circle()
                                        .fill(Color.orange.opacity(0.2))
                                        .frame(width: 80, height: 80)

                                    Image(systemName: "envelope.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.orange)
                                }

                                // Title
                                Text("Verification Code")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.black)

                                // Message
                                Text("Your verification code is:")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)

                                // Code Display
                                HStack(spacing: 12) {
                                    ForEach(Array(authManager.generatedCode), id: \.self) { digit in
                                        Text(String(digit))
                                            .font(.system(size: 32, weight: .bold))
                                            .foregroundColor(.orange)
                                            .frame(width: 60, height: 70)
                                            .background(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Color.orange.opacity(0.1))
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.orange, lineWidth: 2)
                                            )
                                    }
                                }
                                .padding(.vertical, 10)

                                // Copy Code Button
                                Button(action: {
                                    UIPasteboard.general.string = authManager.generatedCode
                                    // Show feedback
                                    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
                                    impactFeedback.impactOccurred()
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "doc.on.doc")
                                            .font(.system(size: 14))
                                        Text("Copy Code")
                                            .font(.system(size: 15, weight: .medium))
                                    }
                                    .foregroundColor(.orange)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.orange, lineWidth: 1.5)
                                    )
                                }

                                // Info Text
                                Text("Please enter this code in the fields below")
                                    .font(.system(size: 13))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 20)

                                // Got It Button
                                Button(action: {
                                    withAnimation(.spring()) {
                                        showCodeAlert = false
                                        // Auto-focus first field
                                        focusedField = 0
                                    }
                                }) {
                                    Text("Got It!")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                        .background(Color.orange)
                                        .cornerRadius(12)
                                }
                                .padding(.top, 10)
                            }
                            .padding(30)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                            )
                            .padding(.horizontal, 30)
                            .transition(.scale.combined(with: .opacity))
                        }
                        .zIndex(100)
                    }
                }
            )
        //}
        .onAppear(perform:{
            startTimer()
            // Generate and show code when view appears
            Task {
                await generateAndShowCode()
            }
        })
        .onReceive(timer) { _ in
            if isTimerRunning {
                            if timeRemaining > 0 {
                                timeRemaining -= 1
                            } else {
                                isTimerRunning = false
                                showResendButton = true // Show resend button when timer finishes
                            }
                        }
        }
    }
    
    private func startTimer() {
            timeRemaining = 60 // Reset timer
            isTimerRunning = true
            showResendButton = false // Hide resend button while timer is running
        }

    private func generateAndShowCode() async {
        // Send verification code (this generates the code internally)
        let success = await authManager.sendVerificationCode(to: authManager.currentUser?.email ?? "user@example.com")

        if success {
            await MainActor.run {
                // Show the code alert after a brief delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.spring()) {
                        showCodeAlert = true
                    }
                }
            }
        }
    }

    private func handleVerification() {
        Task {
            do {
                let success = try await authManager.verifyCode(code1, code2, code3, code4)
                if success {
                    await MainActor.run {
                        // Check if user is new (from signup) or existing (from login)
                        if authManager.isNewUser {
                            // New user: Show onboarding first as a new root page
                            coordinator.setRootPage(page: .onboardingPage)
                        } else {
                            // Existing user: Go directly to home
                            coordinator.coordinatorRootToPop()
                            coordinator.coordinatorFullCoverPresent(fullcover: .homePage)
                        }
                    }
                }
            } catch {
                // Error is already handled in AuthManager
                print("Verification failed: \(error.localizedDescription)")
            }
        }
    }

    private func handleResendCode() {
        Task {
            let success = await authManager.resendVerificationCode()
            if success {
                await MainActor.run {
                    startTimer()
                    // Show the new code alert
                    withAnimation(.spring()) {
                        showCodeAlert = true
                    }
                    // Clear previous input
                    code1 = ""
                    code2 = ""
                    code3 = ""
                    code4 = ""
                }
            }
        }
    }
}

// Custom TextField for Code Entry
struct CodeTextField: View {
    @Binding var text: String
    @FocusState.Binding var focusedField: Int?
    let index: Int

    var body: some View {
        TextField("", text: $text)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.title)
            .fontWeight(.bold)
            .frame(width: 60, height: 60)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 2)
            )
            .focused($focusedField, equals: index)
            .onChange(of: text) { oldValue, newValue in
                if newValue.count > 1 {
                    text = String(newValue.prefix(1))
                }
                if newValue.count == 1 {
                    if index < 3 {
                        focusedField = index + 1
                    }
                }
            }
    }
}

#Preview {
    VerificationView()
}
