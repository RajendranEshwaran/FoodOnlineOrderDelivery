//
//  Coordinator.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/14/25.
//

import Foundation
import SwiftUI
import Combine

enum AppPages: Hashable {
    case onboardingPage
    case login1
    case signupPage
    case forgotPasswordPage
    case verificationPage
    case locationAccessPage
    case homePage
    case searchPage
    case foodCategoryPage(categoryName: String)
    case defaultView
}

enum AppSheets: String, Identifiable {
    case testSheet
    var id: String { return self.rawValue }
}

enum AppFullCovers: String, Identifiable {
    case testFullCover
    case loginPage
    case homePage
    var id: String { return self.rawValue }
}


class Coordinator: ObservableObject {
    @Published var currentPages: AppPages? = .onboardingPage
    @Published var currentSheets: AppSheets?
    @Published var currentFullCover: AppFullCovers?
    @Published var navigationPath = NavigationPath()
    @Published var rootPage: AppPages = .login1
    
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

    func setRootPage(page: AppPages) {
        rootPage = page
        navigationPath.removeLast(navigationPath.count)
    }
    
    
    @ViewBuilder
        func currentAppView(view: AppPages) -> some View {
            switch view {
            case .login1: LoginView()
            case .onboardingPage: OnboardingView()
            case .signupPage : SignupView()
            case .forgotPasswordPage: ForgotPasswordView()
            case .verificationPage: VerificationView()
            case .locationAccessPage: EmptyView()
            case .homePage: HomeView()
            case .searchPage: SearchView()
            case .foodCategoryPage(let categoryName): FoodCategoryView(selectedKeyword: categoryName)
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
            case .homePage: HomeView()
            }
        }
}
