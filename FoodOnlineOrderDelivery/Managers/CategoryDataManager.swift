//
//  CategoryDataManager.swift
//  FoodOnlineOrderDelivery
//
//  Created by Rajendran Eshwaran on 10/22/25.
//

import Foundation

// MARK: - Mock Data
class CategoryDataManager {
    static let shared = CategoryDataManager()

    private init() {}

    // Sample categories with food items
    var categories: [FoodCategory] = [
        FoodCategory(
            name: "All",
            image: "􀙭",
            foodItems: []
        ),
        FoodCategory(
            name: "Hot Dog",
            image: "hotdog3",
            foodItems: [
                FoodItem(
                    name: "Classic Hot Dog",
                    description: "Juicy beef hot dog with mustard and ketchup",
                    price: 5.99,
                    image: "hotdog1",
                    rating: 4.5,
                    reviewCount: 120,
                    restaurantName: "Hot Dog Haven",
                    deliveryTime: "15-20 min",
                    category: "Hot Dog"
                ),
                FoodItem(
                    name: "Chili Cheese Dog",
                    description: "Hot dog topped with chili and melted cheese",
                    price: 7.99,
                    image: "hotdog2",
                    rating: 4.7,
                    reviewCount: 95,
                    restaurantName: "Dog House",
                    deliveryTime: "20-25 min",
                    category: "Hot Dog"
                ),
                FoodItem(
                    name: "Chicago Style Dog",
                    description: "All-beef hot dog with classic Chicago toppings",
                    price: 8.49,
                    image: "hotdog3",
                    rating: 4.8,
                    reviewCount: 150,
                    restaurantName: "Windy City Dogs",
                    deliveryTime: "25-30 min",
                    category: "Hot Dog"
                )
            ]
        ),
        FoodCategory(
            name: "Burger",
            image: "burger1",
            foodItems: [
                FoodItem(
                    name: "Classic Cheeseburger",
                    description: "Beef patty with cheese, lettuce, tomato, and special sauce",
                    price: 9.99,
                    image: "burger1",
                    rating: 4.6,
                    reviewCount: 200,
                    restaurantName: "Burger Palace",
                    deliveryTime: "20-25 min",
                    category: "burger1"
                ),
                FoodItem(
                    name: "Bacon BBQ Burger",
                    description: "Double patty with bacon, BBQ sauce, and onion rings",
                    price: 12.99,
                    image: "burger2",
                    rating: 4.8,
                    reviewCount: 180,
                    restaurantName: "Grill Master",
                    deliveryTime: "25-30 min",
                    category: "Burger"
                ),
                FoodItem(
                    name: "Mushroom Swiss Burger",
                    description: "Juicy burger with sautéed mushrooms and Swiss cheese",
                    price: 11.49,
                    image: "burger3",
                    rating: 4.7,
                    reviewCount: 140,
                    restaurantName: "Burger Heaven",
                    deliveryTime: "20-30 min",
                    category: "Burger"
                ),
                FoodItem(
                    name: "Veggie Burger",
                    description: "Plant-based patty with fresh vegetables",
                    price: 10.99,
                    image: "burger4",
                    rating: 4.4,
                    reviewCount: 85,
                    restaurantName: "Green Eats",
                    deliveryTime: "15-25 min",
                    category: "Burger"
                )
            ]
        ),
        FoodCategory(
            name: "Sandwich",
            image: "sandwich1",
            foodItems: JsonReadDataManager.shared.loadSandwiches()
        ),
        FoodCategory(
            name: "Hot Drink",
            image: "hotdrink1",
            foodItems: [
                FoodItem(
                    name: "Cappuccino",
                    description: "Rich espresso with steamed milk and foam",
                    price: 4.99,
                    image: "hotdrink1",
                    rating: 4.7,
                    reviewCount: 300,
                    restaurantName: "Coffee Corner",
                    deliveryTime: "10-15 min",
                    category: "Hot Drink"
                ),
                FoodItem(
                    name: "Hot Chocolate",
                    description: "Creamy hot chocolate topped with whipped cream",
                    price: 3.99,
                    image: "hotdrink2",
                    rating: 4.6,
                    reviewCount: 150,
                    restaurantName: "Cozy Café",
                    deliveryTime: "10-15 min",
                    category: "Hot Drink"
                ),
                FoodItem(
                    name: "Chai Latte",
                    description: "Spiced tea with steamed milk",
                    price: 4.49,
                    image: "hotdrink3",
                    rating: 4.5,
                    reviewCount: 120,
                    restaurantName: "Tea House",
                    deliveryTime: "10-15 min",
                    category: "Hot Drink"
                )
            ]
        ),
        FoodCategory(
            name: "Pizza",
            image: "pizza1",
            foodItems: [
                FoodItem(
                    name: "Margherita Pizza",
                    description: "Classic pizza with tomato sauce, mozzarella, and fresh basil",
                    price: 12.99,
                    image: "pizza1",
                    rating: 4.7,
                    reviewCount: 280,
                    restaurantName: "Pizza Paradise",
                    deliveryTime: "25-30 min",
                    category: "Pizza"
                ),
                FoodItem(
                    name: "Pepperoni Pizza",
                    description: "Traditional pizza loaded with pepperoni and mozzarella cheese",
                    price: 14.99,
                    image: "pizza2",
                    rating: 4.8,
                    reviewCount: 350,
                    restaurantName: "Tony's Pizzeria",
                    deliveryTime: "20-30 min",
                    category: "Pizza"
                ),
                FoodItem(
                    name: "BBQ Chicken Pizza",
                    description: "Grilled chicken with BBQ sauce, red onions, and cilantro",
                    price: 15.99,
                    image: "pizza3",
                    rating: 4.6,
                    reviewCount: 210,
                    restaurantName: "Pizza House",
                    deliveryTime: "30-35 min",
                    category: "Pizza"
                ),
                FoodItem(
                    name: "Vegetarian Supreme",
                    description: "Loaded with bell peppers, mushrooms, olives, and onions",
                    price: 13.99,
                    image: "pizza4",
                    rating: 4.5,
                    reviewCount: 175,
                    restaurantName: "Green Pizza",
                    deliveryTime: "25-30 min",
                    category: "Pizza"
                ),
                FoodItem(
                    name: "Hawaiian Pizza",
                    description: "Ham and pineapple with mozzarella cheese",
                    price: 14.49,
                    image: "pizza5",
                    rating: 4.4,
                    reviewCount: 190,
                    restaurantName: "Island Pizza",
                    deliveryTime: "20-25 min",
                    category: "Pizza"
                )
            ]
        ),
        FoodCategory(
            name: "Cold Drink",
            image: "colddrink5",
            foodItems: [
                FoodItem(
                    name: "Iced Coffee",
                    description: "Chilled coffee with ice and milk",
                    price: 4.49,
                    image: "colddrink1",
                    rating: 4.6,
                    reviewCount: 200,
                    restaurantName: "Ice Brew",
                    deliveryTime: "10-15 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Fruit Smoothie",
                    description: "Blend of fresh fruits and yogurt",
                    price: 5.99,
                    image: "colddrink2",
                    rating: 4.8,
                    reviewCount: 180,
                    restaurantName: "Smoothie Bar",
                    deliveryTime: "10-15 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Lemonade",
                    description: "Freshly squeezed lemon juice with a hint of sweetness",
                    price: 3.49,
                    image: "colddrink3",
                    rating: 4.4,
                    reviewCount: 130,
                    restaurantName: "Fresh Drinks",
                    deliveryTime: "5-10 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Bubble Tea",
                    description: "Tea with chewy tapioca pearls",
                    price: 5.49,
                    image: "colddrink4",
                    rating: 4.7,
                    reviewCount: 220,
                    restaurantName: "Boba Shop",
                    deliveryTime: "15-20 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Spinach Drink",
                    description: "Spinach with chewy tapioca pearls",
                    price: 5.49,
                    image: "colddrink5",
                    rating: 4.7,
                    reviewCount: 220,
                    restaurantName: "Boba Shop",
                    deliveryTime: "15-20 min",
                    category: "Cold Drink"
                ),
                FoodItem(
                    name: "Lemmanade",
                    description: "Lemon with chewy tapioca pearls",
                    price: 5.49,
                    image: "colddrink4",
                    rating: 4.7,
                    reviewCount: 220,
                    restaurantName: "Boba Shop",
                    deliveryTime: "15-20 min",
                    category: "Cold Drink"
                )
            ]
        ),
        FoodCategory(
            name: "Dessert",
            image: "dessat1",
            foodItems: [
                FoodItem(
                    name: "Chocolate Cake",
                    description: "Rich, moist chocolate cake with chocolate frosting",
                    price: 6.99,
                    image: "dessat1",
                    rating: 4.8,
                    reviewCount: 240,
                    restaurantName: "Sweet Treats",
                    deliveryTime: "15-20 min",
                    category: "Dessert"
                ),
                FoodItem(
                    name: "Cheesecake",
                    description: "Creamy New York-style cheesecake with graham cracker crust",
                    price: 7.49,
                    image: "dessat2",
                    rating: 4.9,
                    reviewCount: 310,
                    restaurantName: "Dessert Heaven",
                    deliveryTime: "15-20 min",
                    category: "Dessert"
                ),
                FoodItem(
                    name: "Tiramisu",
                    description: "Classic Italian dessert with coffee-soaked ladyfingers",
                    price: 8.49,
                    image: "dessat3",
                    rating: 4.7,
                    reviewCount: 185,
                    restaurantName: "Italian Sweets",
                    deliveryTime: "20-25 min",
                    category: "Dessert"
                ),
                FoodItem(
                    name: "Ice Cream Sundae",
                    description: "Vanilla ice cream with chocolate sauce, whipped cream, and cherry",
                    price: 5.99,
                    image: "dessat4",
                    rating: 4.6,
                    reviewCount: 270,
                    restaurantName: "Ice Cream Parlor",
                    deliveryTime: "10-15 min",
                    category: "Dessert"
                ),
                FoodItem(
                    name: "Brownie",
                    description: "Warm chocolate brownie with vanilla ice cream",
                    price: 6.49,
                    image: "dessat5",
                    rating: 4.8,
                    reviewCount: 195,
                    restaurantName: "Bakery Bliss",
                    deliveryTime: "15-20 min",
                    category: "Dessert"
                )
            ]
        ),
        FoodCategory(
            name: "Meal",
            image: "meal5",
            foodItems: [
                FoodItem(
                    name: "Grilled Chicken with Rice",
                    description: "Tender grilled chicken breast with seasoned rice and vegetables",
                    price: 14.99,
                    image: "meal1",
                    rating: 4.7,
                    reviewCount: 320,
                    restaurantName: "Healthy Eats",
                    deliveryTime: "30-35 min",
                    category: "Meal"
                ),
                FoodItem(
                    name: "Steak Dinner",
                    description: "8oz sirloin steak with mashed potatoes and asparagus",
                    price: 22.99,
                    image: "meal2",
                    rating: 4.9,
                    reviewCount: 280,
                    restaurantName: "Steakhouse Prime",
                    deliveryTime: "35-40 min",
                    category: "Meal"
                ),
                FoodItem(
                    name: "Salmon Fillet",
                    description: "Pan-seared salmon with quinoa and steamed broccoli",
                    price: 18.99,
                    image: "meal3",
                    rating: 4.8,
                    reviewCount: 245,
                    restaurantName: "Seafood Delight",
                    deliveryTime: "30-35 min",
                    category: "Meal"
                ),
                FoodItem(
                    name: "Pasta Carbonara",
                    description: "Creamy pasta with bacon, parmesan, and black pepper",
                    price: 13.99,
                    image: "meal4",
                    rating: 4.6,
                    reviewCount: 290,
                    restaurantName: "Italian Kitchen",
                    deliveryTime: "25-30 min",
                    category: "Meal"
                ),
                FoodItem(
                    name: "Chicken Curry with Naan",
                    description: "Spicy chicken curry served with warm naan bread",
                    price: 15.99,
                    image: "meal5",
                    rating: 4.7,
                    reviewCount: 265,
                    restaurantName: "Spice Palace",
                    deliveryTime: "30-35 min",
                    category: "Meal"
                ),
                FoodItem(
                    name: "Caesar Salad with Chicken",
                    description: "Fresh romaine lettuce with grilled chicken, croutons, and dressing",
                    price: 11.99,
                    image: "meal2",
                    rating: 4.5,
                    reviewCount: 180,
                    restaurantName: "Fresh Greens",
                    deliveryTime: "15-20 min",
                    category: "Meal"
                )
            ]
        )
    ]

    // Get all food items
    func getAllFoodItems() -> [FoodItem] {
        var allItems: [FoodItem] = []
        for category in categories where category.name != "All" {
            allItems.append(contentsOf: category.foodItems)
        }
        return allItems
    }

    // Get food items by category
    func getFoodItems(for categoryName: String) -> [FoodItem] {
        if categoryName == "All" {
            return getAllFoodItems()
        }
        return categories.first(where: { $0.name == categoryName })?.foodItems ?? []
    }

    // Get category names
    func getCategoryNames() -> [String] {
        return categories.map { $0.name }
    }
}
