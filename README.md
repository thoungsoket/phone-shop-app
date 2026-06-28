# phone_shop_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Phone Shop App

A frontend-only Flutter mobile app for a phone shop.  
This project uses mock data only and is built for classroom demo.

## Features
* Light & Dark Theme
* User Authentication (Login & Sign Up)
* Onboarding Screens
* Home Dashboard
* Product Categories
* Product Search
* Product Details
* Phone Comparison
* Favorites
* Shopping Cart
* Checkout
* Promotions & Coupons
* Interactive Store Map
* Nearby Stores
* Phone Reservation
* Repair Appointment Booking
* Repair Tracker
* Customer Support Chat
* Reviews & Ratings
* Photos & Videos Gallery
* User Profile
* Settings
* Persistent Local Storage (SharedPreferences)
* State Management (Provider)


## Tech Stack
- Flutter 3.x
- Dart 3.x
- Material 3
- Provider
- go_router
- shared_preferences
- flutter_map
- Mock JSON data

## Folder Structure
```txt
phone-shop-app/
│
├── lib/
│   │
│   ├── main.dart
│   │
│   ├── features/
│   │   ├── auth/
│   │   ├── onboarding/
│   │   ├── home/
│   │   ├── category/
│   │   ├── detail/
│   │   ├── search/
│   │   ├── compare/
│   │   ├── favorites/
│   │   ├── cart/
│   │   ├── checkout/
│   │   ├── promotions/
│   │   ├── nearby/
│   │   ├── map/
│   │   ├── booking/
│   │   ├── repair_tracker/
│   │   ├── chat/
│   │   ├── reviews/
│   │   ├── gallery/
│   │   ├── profile/
│   │   ├── settings/
│   │   ├── common/
│   │   └── data/
│   │        └── product_data.dart
│   │
│   ├── providers/
│   │   ├── CartProvider
│   │   ├── FavoritesProvider
│   │   └── PhoneHubStore
│   │
│   └── assets/
│       ├── images/
│       ├── icons/
│       └── fonts/
│
├── pubspec.yaml
└── README.md
