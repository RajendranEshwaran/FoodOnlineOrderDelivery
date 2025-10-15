//
//  Coordinator.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/14/25.
//

import Foundation
import SwiftUI
import Combine

enum AppPages: String, Hashable {
    case onboardingPage
    case signupPage
    case forgotPasswordPage
    case verificationPage
    case locationAccessPage
    case defaultView
}

enum AppSheets: String, Identifiable {
    case testSheet
    var id: String { return self.rawValue }
}

enum AppFullCovers: String, Identifiable {
    case testFullCover
    case loginPage
    var id: String { return self.rawValue }
}


class Coordinator: ObservableObject {
    @Published var currentPages: AppPages? = .onboardingPage
    @Published var currentSheets: AppSheets?
    @Published var currentFullCover: AppFullCovers?
    @Published var navigationPath = NavigationPath()
    
    func coordinatorPagePush(page: AppPages) {
        navigationPath.append(page)
    }
    
    func coordinatorPagePresent(page: AppPages) {
        navigationPath.append(page)
    }
    
    func coordinatorSheetPresnt(sheet: AppSheets) {
        navigationPath.append(sheet)
    }
    
    func coordinatorFullCoverPresent(fullcover: AppFullCovers) {
        self.currentFullCover = fullcover
    }
    
    func coordinatorDissmissPage() {
        self.currentPages = nil
    }
    
    func coordinatorDissmissSheet() {
        self.currentSheets = nil
    }
    
    func coordinatorDissmissFullCover() {
        self.currentFullCover = nil
    }
    
    func coordinatorPopToPage() {
        navigationPath.removeLast()
    }
    
    func coordinatorRootToPop() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    
    @ViewBuilder
        func currentAppView(view: AppPages) -> some View {
            switch view {
            case .onboardingPage: OnboardingView()
            case .signupPage : EmptyView()
            case .forgotPasswordPage: EmptyView()
            case .verificationPage: EmptyView()
            case .locationAccessPage: EmptyView()
            case .defaultView: EmptyView()
            }
        }
        
        @ViewBuilder
        func currentAppSheetView(sheet: AppSheets) -> some View {
            switch sheet {
            case .testSheet: EmptyView()
            }
        }
        
        @ViewBuilder
        func currentAppFullCoverView(fullcover: AppFullCovers) -> some View {
            switch fullcover {
            case .testFullCover: EmptyView()
            case .loginPage: LoginView()
            }
        }
}
