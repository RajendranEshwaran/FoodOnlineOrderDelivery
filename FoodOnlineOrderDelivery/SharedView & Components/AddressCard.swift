//
//  AddressCard.swift
//  FoodOnlineOrderDelivery
//
//  Created by RajayGoms on 10/27/25.
//

import SwiftUI

// MARK: - Address Card Component
struct AddressCard: View {
    let address: Address
    var onEdit: (() -> Void)?
    var onDelete: (() -> Void)?
    var onSetDefault: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                // Label with icon
                HStack(spacing: 8) {
                    Image(systemName: addressIcon)
                        .font(.system(size: 16))
                        .foregroundColor(.orange)

                    Text(address.label)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                }

                Spacer()

                // Default Badge
                if address.isDefault {
                    Text("Default")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(Color.green)
                        .cornerRadius(8)
                }
            }

            Divider()

            // Address Details
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 6) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)

                    Text(address.streetAddress)
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.8))
                }

                HStack(spacing: 6) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)

                    Text("\(address.city), \(address.state) \(address.zipCode)")
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.8))
                }
            }

            Divider()

            // Action Buttons
            HStack(spacing: 12) {
                // Set Default Button
                if !address.isDefault {
                    Button(action: {
                        onSetDefault?()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 14))

                            Text("Set Default")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .foregroundColor(.green)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                    }
                }

                Spacer()

                // Edit Button
                Button(action: {
                    onEdit?()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "pencil")
                            .font(.system(size: 14))

                        Text("Edit")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.orange)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.orange.opacity(0.1))
                    .cornerRadius(8)
                }

                // Delete Button
                Button(action: {
                    onDelete?()
                }) {
                    HStack(spacing: 6) {
                        Image(systemName: "trash")
                            .font(.system(size: 14))

                        Text("Delete")
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.red)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }

    private var addressIcon: String {
        switch address.label.lowercased() {
        case "home":
            return "house.fill"
        case "office", "work":
            return "building.2.fill"
        default:
            return "mappin.circle.fill"
        }
    }
}
