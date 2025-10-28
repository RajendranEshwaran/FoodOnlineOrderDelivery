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
            }.ignoresSafeArea(.all)
        //}
        .onAppear(perform:{
            startTimer()
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

    private func handleVerification() {
        Task {
            do {
                let success = try await authManager.verifyCode(code1, code2, code3, code4)
                if success {
                    await MainActor.run {
                        // Check if user is new (from signup) or existing (from login)
                        if authManager.isNewUser {
                            // New user: Show onboarding first
                            coordinator.coordinatorRootToPop()
                            coordinator.coordinatorPagePush(page: .onboardingPage)
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
                    alertMessage = "Verification code sent successfully"
                    showAlert = true
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
