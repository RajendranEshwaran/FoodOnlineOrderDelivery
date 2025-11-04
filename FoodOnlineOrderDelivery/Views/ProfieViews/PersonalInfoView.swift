//
//  PersonalInfoView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/27/25.
//

import SwiftUI

struct PersonalInfoView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var authManager: AuthManager
    @State private var isEditMode = false
    @State private var profileImage = ""
    @State private var fullName = ""
    @State private var statusMessage = "Active User"
    @State private var email = ""
    @State private var phoneNumber = "+1 234 567 8900"

    // Temporary state for editing
    @State private var editFullName = ""
    @State private var editStatusMessage = ""
    @State private var editEmail = ""
    @State private var editPhoneNumber = ""

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: "Personal Info",
                cartItemCount: 0,
                isMenuEnable: false,
                isBackEnable: true,
                isUserInfo: false,
                isCartEnable: false,
                onCartTap: {
                    coordinator.coordinatorPagePush(page: .cartPage)
                },
                onBackTap: {
                    coordinator.coordinatorPopToPage()
                }
            )

            ScrollView {
                VStack(spacing: 24) {
                    // Profile Section
                    VStack(spacing: 16) {
                        // Profile Image
                        ZStack(alignment: .bottomTrailing) {
                            ZStack {
                                Circle()
                                    .fill(Color.orange.opacity(0.2))
                                    .frame(width: 120, height: 120)

                                if profileImage.isEmpty {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.orange)
                                } else {
                                    Image(profileImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                        .clipShape(Circle())
                                }
                            }

                            // Edit Photo Button
                            if isEditMode {
                                Button(action: {
                                    print("Change profile photo")
                                    // TODO: Implement image picker
                                }) {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .frame(width: 36, height: 36)
                                        .background(Color.orange)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                }
                                .offset(x: -5, y: -5)
                            }
                        }
                        .padding(.top, 20)

                        // Full Name
                        if isEditMode {
                            TextField("Full Name", text: $editFullName)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.horizontal, 40)
                        } else {
                            Text(fullName)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.black)
                        }

                        // Status Message
                        if isEditMode {
                            TextField("Status Message", text: $editStatusMessage)
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .textFieldStyle(PlainTextFieldStyle())
                                .padding(.horizontal, 40)
                        } else {
                            HStack(spacing: 6) {
                                Circle()
                                    .fill(Color.green)
                                    .frame(width: 8, height: 8)

                                Text(statusMessage)
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.bottom, 20)

                    // Information Fields
                    VStack(spacing: 16) {
                        // Full Name Field
                        InfoFieldView(
                            icon: "person.fill",
                            label: "Full Name",
                            value: isEditMode ? $editFullName : $fullName,
                            isEditMode: isEditMode
                        )

                        // Email Field
                        InfoFieldView(
                            icon: "envelope.fill",
                            label: "Email",
                            value: isEditMode ? $editEmail : $email,
                            isEditMode: isEditMode,
                            keyboardType: .emailAddress
                        )

                        // Phone Number Field
                        InfoFieldView(
                            icon: "phone.fill",
                            label: "Phone Number",
                            value: isEditMode ? $editPhoneNumber : $phoneNumber,
                            isEditMode: isEditMode,
                            keyboardType: .phonePad
                        )
                    }
                    .padding(.horizontal, 20)

                    // Edit/Save Button
                    Button(action: {
                        if isEditMode {
                            saveChanges()
                        } else {
                            enterEditMode()
                        }
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: isEditMode ? "checkmark.circle.fill" : "pencil")
                                .font(.system(size: 16))

                            Text(isEditMode ? "Save Changes" : "Edit Profile")
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.orange)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                    // Cancel Button (only in edit mode)
                    if isEditMode {
                        Button(action: {
                            cancelEdit()
                        }) {
                            Text("Cancel")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.gray)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer(minLength: 40)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            fullName = authManager.currentUser?.name ?? fullName
            email = authManager.currentUser?.email ?? email
            phoneNumber = authManager.currentUser?.phoneNumber ?? phoneNumber
            profileImage = authManager.currentUser?.profileImageURL ?? profileImage
        }
    }

    private func enterEditMode() {
        editFullName = fullName
        editStatusMessage = statusMessage
        editEmail = email
        editPhoneNumber = phoneNumber
        withAnimation {
            isEditMode = true
        }
    }

    private func saveChanges() {
        fullName = editFullName
        statusMessage = editStatusMessage
        email = editEmail
        phoneNumber = editPhoneNumber

        withAnimation {
            isEditMode = false
        }

        print("Saved changes - Name: \(fullName), Email: \(email), Phone: \(phoneNumber)")
        // TODO: Save to backend/local storage
    }

    private func cancelEdit() {
        withAnimation {
            isEditMode = false
        }
        // Reset edit fields
        editFullName = fullName
        editStatusMessage = statusMessage
        editEmail = email
        editPhoneNumber = phoneNumber
    }
}

// MARK: - Info Field View Component
struct InfoFieldView: View {
    let icon: String
    let label: String
    @Binding var value: String
    let isEditMode: Bool
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Label
            Text(label)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray)

            // Value/TextField
            HStack(spacing: 12) {
                // Icon
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(.orange)
                    .frame(width: 24)

                if isEditMode {
                    TextField(label, text: $value)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .keyboardType(keyboardType)
                        .autocapitalization(keyboardType == .emailAddress ? .none : .words)
                } else {
                    Text(value)
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isEditMode ? Color.orange.opacity(0.05) : Color.gray.opacity(0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isEditMode ? Color.orange.opacity(0.3) : Color.clear, lineWidth: 1)
            )
        }
    }
}

#Preview {
    PersonalInfoView()
        .environmentObject(Coordinator())
}
