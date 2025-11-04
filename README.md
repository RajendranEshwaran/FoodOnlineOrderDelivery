# 🍔 FOOD(FastOnlineOrderDelivery)

A modern, feature-rich iOS food delivery application built with SwiftUI, offering seamless user experience for browsing, ordering, and tracking food delivery from your favorite restaurants.

<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%2015.0+-blue.svg" alt="Platform">
  <img src="https://img.shields.io/badge/Language-Swift%205.9-orange.svg" alt="Language">
  <img src="https://img.shields.io/badge/Framework-SwiftUI|Combine-green.svg" alt="Framework">
  <img src="https://img.shields.io/badge/Architecture-MVVM-red.svg" alt="Architecture">
  <img src="https://img.shields.io/badge/NavigationPattern-Coordinator-purple.svg" alt="NavigationPattern">
  <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License">
</p>


## Demo AppVideo

 ![Simulator Screen Recording - iPhone 16e - 2025-10-28 at 15 35 53](https://github.com/user-attachments/assets/3de1278e-0f96-4993-acd7-1a058adc17c6)

## 📸 Screenshots

<p>
<img width="250" height="541" alt="Splash Page_02" src="https://github.com/user-attachments/assets/e95a3d3f-49ce-43aa-b56d-52b7dfe48304" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-11-04 at 15 39 28" src="https://github.com/user-attachments/assets/64163bf3-cdcd-4699-8c03-d43c7e76c22e" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-10-28 at 16 01 55" src="https://github.com/user-attachments/assets/db4db8f9-3ec4-44a1-9883-f2563db6a4aa" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-10-28 at 16 02 05" src="https://github.com/user-attachments/assets/db93af02-82b2-4c49-b567-9ced8e4aac7a" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-10-28 at 16 03 31" src="https://github.com/user-attachments/assets/26148506-b42a-4fb9-a231-1c7338b57f6a" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-10-28 at 16 03 44" src="https://github.com/user-attachments/assets/8dbdfb60-f8e9-494e-8ddd-a19adad034a8" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-11-04 at 15 39 35" src="https://github.com/user-attachments/assets/8c0dd5c9-cbec-4625-bf33-bda19149795e" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-10-28 at 16 04 17" src="https://github.com/user-attachments/assets/6b181560-0a61-4c26-b67b-9cee76a04494" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-10-28 at 16 04 08" src="https://github.com/user-attachments/assets/3345a1ea-262b-4b25-9fd9-37d8861ad621" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-10-28 at 16 03 59" src="https://github.com/user-attachments/assets/0dd8be2a-20b6-4bd1-bbe6-a3daba322541" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-10-28 at 16 03 47" src="https://github.com/user-attachments/assets/d86bf6e6-680f-42a8-b919-85e60adc4fc0" />
<img width="250" height="541" alt="Simulator Screenshot - iPhone 16e - 2025-11-04 at 15 35 19" src="https://github.com/user-attachments/assets/8f624ed6-b4d0-4518-b3a7-bc36830c170d" />
</p>

## 📱 Features

### Authentication & User Management
- ✅ User Registration with validation
- ✅ Login with email/password
- ✅ Phone/Email verification with OTP
- ✅ Forgot password functionality
- ✅ Smart onboarding flow for new users
- ✅ Remember me functionality

### Food Discovery & Ordering
- 🍕 Browse food by categories (Pizza, Burger, Sushi, Tacos, etc.)
- 🔍 Advanced search functionality with recent searches
- ⭐ Restaurant listings with ratings and reviews
- 📋 Detailed food item view with descriptions and customization
- 🛒 Shopping cart with item management
- ❤️ Favorites list for quick access to preferred items

### Order Management
- 📦 Real-time order tracking with status updates
- 📍 Live delivery tracking with map integration
- 📝 Order history with reorder functionality
- 🚫 Cancel ongoing orders
- 📊 View ongoing and completed orders separately

### Payment & Checkout
- 💳 Multiple payment methods support
- 💰 Add and manage payment cards
- 🎫 Order confirmation with estimated delivery time
- 📞 Contact delivery driver directly

### Profile & Settings
- 👤 Personal information management with edit functionality
- 📍 Multiple delivery addresses with map pin-drop
- 🏠 Label addresses (Home, Office, Work, etc.)
- 📍 Set default delivery address
- 🗺️ Interactive map for precise location selection with lat/lon display

### Additional Features
- 🎨 Modern, intuitive UI with smooth animations
- 🌙 Consistent design language throughout the app
- 📱 Responsive layouts for different screen sizes
- 🎯 Category-based navigation
- 🍽️ Popular fast food recommendations
- 🏪 Suggested restaurants
- 🍔 Hamburger menu for quick navigation

## 🏗️ Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern with **Coordinator** pattern for navigation:

```
FoodOnlineOrderDelivery/
├── App/
│   └── FoodOnlineOrderDeliveryApp.swift
├── Coordinators/
│   ├── Coordinator.swift
│   └── CoordinatorView.swift
├── Views/
│   ├── AuthViews/
│   │   ├── LoginView.swift
│   │   ├── SignupView.swift
│   │   ├── VerificationView.swift
│   │   └── ForgotPasswordView.swift
│   ├── BussinessViews/
│   │   ├── HomeView.swift
│   │   ├── SearchView.swift
│   │   ├── FoodCategoryView.swift
│   │   ├── FoodDetailView.swift
│   │   ├── RestaurantView.swift
│   │   └── CartDetailView.swift
│   ├── MenuViews/
│   │   ├── HamburgerMenuView.swift
│   │   ├── MyOrderView.swift
│   │   └── FavouriteView.swift
│   ├── ProfileViews/
│   │   ├── PersonalInfoView.swift
│   │   └── AddressView.swift
│   ├── PaymentViews/
│   │   ├── PaymentView.swift
│   │   ├── AddCardView.swift
│   │   └── ConfirmationView.swift
│   ├── MiscellaneousViews/
│   │   └── TrackOrderView.swift
│   └── SplashView/
│       └── OnboardingView.swift
├── Models/
│   ├── CategoryModel.swift
│   ├── RestaurantModel.swift
│   ├── PopularFastFoodModel.swift
│   └── CartItemModel.swift
├── Managers/
│   ├── AuthManager.swift
│   ├── MenuManager.swift
│   ├── CategoryDataManager.swift
│   ├── PopularFastFoodManager.swift
│   └── SuggestedRestaurantsManager.swift
└── SharedView & Components/
    ├── TopPanel.swift
    ├── HeaderViews.swift
    ├── FoodCard.swift
    ├── FoodItemCard.swift
    ├── RestaurantCard.swift
    ├── RestaurantListCard.swift
    ├── PopularFastFoodCard.swift
    ├── OrderCard.swift
    ├── FavouriteFoodCard.swift
    ├── CategoryItem.swift
    ├── RecentSearchesView.swift
    ├── CartView.swift
    └── DeliveryProgressStep.swift
```

## 🛠️ Tech Stack

- **Language:** Swift 5.9
- **Framework:** SwiftUI
- **Minimum iOS Version:** iOS 15.0+
- **Architecture:** MVVM + Coordinator
- **Navigation:** Custom Coordinator Pattern
- **State Management:** Combine, @Published, @State, @EnvironmentObject
- **Maps:** MapKit for location and delivery tracking
- **Async/Await:** For asynchronous operations

## 📋 Requirements

- Xcode 15.0+
- iOS 15.0+
- macOS 13.0+ (for development)

## 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/FoodOnlineOrderDelivery.git
   cd FoodOnlineOrderDelivery
   ```

2. **Open the project in Xcode**
   ```bash
   open FoodOnlineOrderDelivery.xcodeproj
   ```

3. **Build and Run**
   - Select your target device or simulator
   - Press `Cmd + R` or click the Run button
   - The app will build and launch

## 🎯 Getting Started

### First Launch
1. The app will show onboarding screens
2. After onboarding, you'll be directed to the login screen

### Test Credentials (Mock Data)
- **Email:** Any valid email format
- **Password:** Minimum 6 characters
- **Verification Code:** 1234

### Exploring Features
1. **Browse Food:** Explore categories on the home screen
2. **Search:** Use the search functionality to find specific items
3. **Add to Cart:** Tap the + button on food items
4. **Favorites:** Tap the heart icon to save favorites
5. **Profile:** Access via hamburger menu for settings and orders

## 🗺️ Navigation Flow

```
App Launch
    ├─→ Onboarding (First time)
    │       └─→ Login/Signup
    │              ├─→ Login → Verification (optional) → Home
    │              └─→ Signup → Verification → Onboarding → Home
    └─→ Home (Returning users)
            ├─→ Food Categories → Food Detail → Cart
            ├─→ Search → Results → Food Detail
            ├─→ Restaurants → Menu → Food Detail
            ├─→ Cart → Payment → Confirmation → Track Order
            └─→ Menu
                   ├─→ My Orders (Ongoing/History)
                   ├─→ Favourites
                   ├─→ Personal Info (Edit Profile)
                   ├─→ Addresses (Add/Edit/Delete)
                   └─→ Payment Methods
```

## 💡 Key Components

### Coordinator Pattern
The app uses a custom coordinator for navigation management:
- `Coordinator.swift` - Manages navigation state and routes
- `CoordinatorView.swift` - Renders views based on navigation state
- Supports push, pop, present, and root navigation

### AuthManager
Handles all authentication-related operations:
- Login/Signup/Logout
- Verification code handling
- User session management
- New user vs existing user tracking

### Data Managers
- **CategoryDataManager:** Manages food categories and items
- **PopularFastFoodManager:** Handles popular food recommendations
- **SuggestedRestaurantsManager:** Manages restaurant suggestions
- **MenuManager:** Handles menu items and navigation

### Reusable Components
- **TopPanel:** Universal top navigation bar
- **FoodCard:** Display food items in grid
- **OrderCard:** Show order details with actions
- **RestaurantCard:** Display restaurant information
- **HeaderViews:** Reusable header component

## 🎨 Design Patterns

1. **MVVM Architecture:** Separation of concerns with Models, Views, and ViewModels
2. **Coordinator Pattern:** Centralized navigation management
3. **Dependency Injection:** Using @EnvironmentObject for shared state
4. **Observer Pattern:** Combine framework for reactive programming
5. **Repository Pattern:** Data managers for data access layer
6. **Singleton Pattern:** Shared managers (AuthManager, CategoryDataManager)

## 🔧 Configuration

### Colors
Define custom colors in Assets.xcassets:
- `ButtonColor` - Primary button color (Orange)
- Additional theme colors as needed

### Assets
Place images in Assets.xcassets:
- Food images (pizza1, burger1, sushi1, etc.)
- Onboarding images (Onboarding_01 to Onboarding_05)
- Restaurant logos
- Category icons

## 📝 TODO / Future Enhancements

- [ ] Backend API integration
- [X] JSON data file store & read  :white_check_mark:
- [ ] Real-time order tracking with WebSocket
- [ ] Push notifications for order updates
- [ ] Social media authentication (Facebook, Google, Apple)
- [ ] Payment gateway integration (Stripe, PayPal)
- [ ] User reviews and ratings system
- [ ] Promo codes and discounts
- [X] Multi-language support :white_check_mark:
- [ ] Dark mode support
- [ ] Accessibility improvements
- [ ] Unit and UI tests
- [ ] Analytics integration
- [ ] Crash reporting

## 🐛 Known Issues

1. ~~Navigation stack issue with onboarding~~ - Fixed ✅
2. ~~Map coordinate onChange error~~ - Fixed ✅
3. ~~Missing .login1 enum case~~ - Fixed ✅
4. ~~Cancel order button without action~~ - Fixed ✅

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Coding Standards
- Follow Swift API Design Guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Write clean, readable code

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Rajendran Eshwaran**

- GitHub: [@RajendranEshwaran](https://github.com/yourusername)
- Email: Rajendraneshwaran2010@gmail.com

## 🙏 Acknowledgments

- SwiftUI community for inspiration and resources
- Apple Developer Documentation
- Design inspiration from popular food delivery apps

## 📞 Support

For support, email Rajendraneshwaran2010@gmail.com or create an issue in the repository.

---

<p align="center">Made with ❤️ using SwiftUI</p>
<p align="center">⭐ Star this repository if you find it helpful!</p>
