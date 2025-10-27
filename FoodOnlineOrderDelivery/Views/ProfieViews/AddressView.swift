//
//  AddressView.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/27/25.
//

import SwiftUI
import MapKit

struct AddressView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @State private var addresses: [Address] = []
    @State private var showAddAddressSheet = false
    @State private var editingAddress: Address?
    @State private var showDeleteAlert = false
    @State private var addressToDelete: Address?

    var body: some View {
        VStack(spacing: 0) {
            // Top Panel
            TopPanel(
                userName: "My Addresses",
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

            if addresses.isEmpty {
                // Empty State
                EmptyAddressView(onAddTapped: {
                    showAddAddressSheet = true
                })
            } else {
                ScrollView {
                    VStack(spacing: 16) {
                        // Add New Address Button
                        Button(action: {
                            editingAddress = nil
                            showAddAddressSheet = true
                        }) {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 20))

                                Text("Add New Address")
                                    .font(.system(size: 16, weight: .semibold))

                                Spacer()
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(Color.orange)
                            .cornerRadius(12)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)

                        // Address List
                        ForEach(addresses) { address in
                            AddressCard(
                                address: address,
                                onEdit: {
                                    editingAddress = address
                                    showAddAddressSheet = true
                                },
                                onDelete: {
                                    addressToDelete = address
                                    showDeleteAlert = true
                                },
                                onSetDefault: {
                                    setDefaultAddress(address)
                                }
                            )
                        }

                        Spacer(minLength: 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            loadAddresses()
        }
        .sheet(isPresented: $showAddAddressSheet) {
            AddEditAddressSheet(
                address: editingAddress,
                onSave: { newAddress in
                    saveAddress(newAddress)
                }
            )
        }
        .alert("Delete Address", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let address = addressToDelete {
                    deleteAddress(address)
                }
            }
        } message: {
            Text("Are you sure you want to delete this address?")
        }
    }

    private func loadAddresses() {
        // Sample data - replace with actual data from backend or local storage
        addresses = [
            Address(
                label: "Home",
                streetAddress: "123 Main Street, Apt 4B",
                city: "New York",
                state: "NY",
                zipCode: "10001",
                latitude: 40.7128,
                longitude: -74.0060,
                isDefault: true
            ),
            Address(
                label: "Office",
                streetAddress: "456 Business Plaza, Suite 200",
                city: "New York",
                state: "NY",
                zipCode: "10002",
                latitude: 40.7589,
                longitude: -73.9851
            ),
            Address(
                label: "Work",
                streetAddress: "789 Corporate Drive",
                city: "Brooklyn",
                state: "NY",
                zipCode: "11201",
                latitude: 40.6782,
                longitude: -73.9442
            )
        ]
    }

    private func saveAddress(_ address: Address) {
        if let index = addresses.firstIndex(where: { $0.id == address.id }) {
            // Update existing address
            addresses[index] = address
        } else {
            // Add new address
            addresses.append(address)
        }
        print("Saved address: \(address.label)")
        // TODO: Save to backend/local storage
    }

    private func deleteAddress(_ address: Address) {
        addresses.removeAll { $0.id == address.id }
        print("Deleted address: \(address.label)")
        // TODO: Update backend/local storage
    }

    private func setDefaultAddress(_ address: Address) {
        // Remove default from all addresses
        for index in addresses.indices {
            addresses[index].isDefault = false
        }
        // Set new default
        if let index = addresses.firstIndex(where: { $0.id == address.id }) {
            addresses[index].isDefault = true
        }
        print("Set default address: \(address.label)")
        // TODO: Update backend/local storage
    }
}



// MARK: - Empty Address View
struct EmptyAddressView: View {
    var onAddTapped: (() -> Void)?

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "location.slash")
                .font(.system(size: 70))
                .foregroundColor(.gray.opacity(0.5))
                .padding(.top, 100)

            Text("No Addresses Saved")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.black)

            Text("Add your delivery addresses to\nmake ordering faster")
                .font(.system(size: 15))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Button(action: {
                onAddTapped?()
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 18))

                    Text("Add New Address")
                        .font(.system(size: 16, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                .padding(.vertical, 16)
                .background(Color.orange)
                .cornerRadius(12)
            }
            .padding(.top, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Add/Edit Address Sheet
struct AddEditAddressSheet: View {
    @Environment(\.dismiss) var dismiss
    let address: Address?
    var onSave: ((Address) -> Void)?

    @State private var label: String
    @State private var streetAddress: String
    @State private var city: String
    @State private var state: String
    @State private var zipCode: String
    @State private var latitude: Double
    @State private var longitude: Double
    @State private var isDefault: Bool
    @State private var region: MKCoordinateRegion

    init(address: Address?, onSave: ((Address) -> Void)?) {
        self.address = address
        self.onSave = onSave

        // Initialize state from address or with empty values
        _label = State(initialValue: address?.label ?? "")
        _streetAddress = State(initialValue: address?.streetAddress ?? "")
        _city = State(initialValue: address?.city ?? "")
        _state = State(initialValue: address?.state ?? "")
        _zipCode = State(initialValue: address?.zipCode ?? "")
        _latitude = State(initialValue: address?.latitude ?? 40.7128)
        _longitude = State(initialValue: address?.longitude ?? -74.0060)
        _isDefault = State(initialValue: address?.isDefault ?? false)

        let initialCoordinate = CLLocationCoordinate2D(
            latitude: address?.latitude ?? 40.7128,
            longitude: address?.longitude ?? -74.0060
        )
        _region = State(initialValue: MKCoordinateRegion(
            center: initialCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Address Label")) {
                    TextField("e.g., Home, Office, Work", text: $label)
                }

                Section(header: Text("Address Details")) {
                    TextField("Street Address", text: $streetAddress)

                    TextField("City", text: $city)

                    TextField("State", text: $state)

                    TextField("ZIP Code", text: $zipCode)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Location Pin Drop")) {
                    // Map with pin drop
                    MapPinDropView(
                        region: $region,
                        latitude: $latitude,
                        longitude: $longitude
                    )
                    .frame(height: 250)
                    .cornerRadius(12)

                    // Coordinate Display
                    VStack(spacing: 8) {
                        HStack {
                            Text("Latitude:")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "%.6f", latitude))
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                        }

                        HStack {
                            Text("Longitude:")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "%.6f", longitude))
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.vertical, 4)

                    Text("Tap on the map to drop a pin")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }

                Section {
                    Toggle("Set as default address", isOn: $isDefault)
                }
            }
            .navigationTitle(address == nil ? "Add Address" : "Edit Address")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveAddress()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }

    private var isFormValid: Bool {
        !label.isEmpty && !streetAddress.isEmpty && !city.isEmpty && !state.isEmpty && !zipCode.isEmpty
    }

    private func saveAddress() {
        let newAddress = Address(
            id: address?.id ?? UUID().uuidString,
            label: label,
            streetAddress: streetAddress,
            city: city,
            state: state,
            zipCode: zipCode,
            latitude: latitude,
            longitude: longitude,
            isDefault: isDefault
        )

        onSave?(newAddress)
        dismiss()
    }
}


#Preview {
    AddressView()
        .environmentObject(Coordinator())
}
