# Vital Foods 🍔

A comprehensive food delivery application built with Flutter, implementing Clean Architecture principles and Firebase backend integration. This app provides a seamless experience for customers to browse restaurants, place orders, track deliveries, and manage their favorite items, while also offering a dedicated dashboard for restaurant owners/chefs to manage their menu and orders.

The application features a complete authentication system, real-time order tracking, cart management, favorites functionality, and a robust review system. Built with scalability and maintainability in mind, the project demonstrates proficiency in mobile app development, state management, backend integration, and UI/UX design.

This project showcases advanced Flutter development skills including dependency injection, multi-language localization, responsive design patterns, and secure data storage practices.

## 🚀 Technologies Used

### Core Framework
- **Flutter** - Cross-platform mobile development framework
- **Dart** - Programming language (SDK ^3.9.2)

### Backend & Database
- **Firebase Authentication** - User authentication and authorization
- **Cloud Firestore** - NoSQL database for real-time data synchronization
- **Firebase Storage** - Image and file storage

### State Management
- **Provider** - State management solution for Flutter

### Dependency Injection
- **GetIt** - Service locator and dependency injection

### Local Storage
- **SharedPreferences** - Local data persistence for non-sensitive information
- **Flutter Secure Storage** - Encrypted storage for sensitive data (tokens, credentials)

### UI & Design
- **Material Design** - Material Design components
- **Custom Fonts** - Poppins and Montserrat font families
- **SVG Support** - Flutter SVG for scalable vector graphics
- **Cached Network Images** - Optimized image loading and caching

### Development Tools
- **Flutter Lints** - Code quality and linting rules
- **Build Runner** - Code generation utilities
- **JSON Serialization** - Automated JSON serialization/deserialization

### Localization
- **Flutter Localizations** - Multi-language support (English, Arabic, French)
- **Intl** - Internationalization and localization utilities

## 📁 Project Structure

The project follows **Clean Architecture** principles, organizing code into three main layers with clear separation of concerns:

```
lib/
├── core/                           # Shared utilities and configurations
│   ├── assets/                     # Images, icons, and fonts
│   │   ├── fonts/                  # Custom font files (Poppins, Montserrat)
│   │   ├── icons/                  # SVG icon assets
│   │   └── images/                 # Image assets
│   ├── constants/                  # Centralized constants
│   │   ├── app_assets.dart         # Asset path constants
│   │   ├── app_colors.dart         # Color palette definitions
│   │   ├── app_dimensions.dart     # Spacing and dimension constants
│   │   └── app_text_styles.dart    # Typography definitions
│   ├── data/                       # Static application data
│   ├── di/                         # Dependency injection setup
│   │   ├── injection_container.dart # DI container implementation
│   │   └── injection_setup.dart    # Dependency registration
│   ├── errors/                     # Error handling
│   │   └── failures.dart           # Failure classes for error handling
│   ├── extensions/                 # Utility extensions
│   │   └── size_extensions.dart    # Responsive sizing helpers
│   ├── firebase/                   # Firebase configuration
│   │   └── firebase_config.dart    # Firebase initialization
│   ├── services/                   # Core services
│   │   ├── database_init_service.dart
│   │   ├── database_cleanup_service.dart
│   │   └── locale_service.dart
│   ├── storage/                    # Storage services
│   │   ├── shared_preferences_service.dart
│   │   └── secure_storage_service.dart
│   ├── theme/                      # App theme configuration
│   │   └── app_theme.dart
│   └── utils/                      # Utility functions
│       ├── app_routes.dart         # Route definitions and navigation
│       └── validators.dart         # Form validation utilities
│
├── domain/                         # Business logic layer (no dependencies)
│   ├── entities/                   # Core business objects
│   │   ├── auth_result.dart
│   │   ├── cart.dart
│   │   ├── cart_item.dart
│   │   ├── favorite_item.dart
│   │   ├── order.dart
│   │   ├── review.dart
│   │   ├── settings.dart
│   │   └── user.dart
│   ├── repositories/               # Repository interfaces (contracts)
│   │   ├── auth_repository.dart
│   │   ├── cart_repository.dart
│   │   ├── favorite_repository.dart
│   │   ├── order_repository.dart
│   │   ├── review_repository.dart
│   │   └── settings_repository.dart
│   └── usecases/                   # Business use cases
│       ├── auth/                   # Authentication use cases
│       ├── cart/                   # Cart management use cases
│       ├── favorite/               # Favorites use cases
│       ├── order/                  # Order management use cases
│       ├── review/                 # Review use cases
│       └── settings/               # Settings use cases
│
├── data/                           # Data layer (depends on domain)
│   ├── datasources/                # Data sources (API/Firebase)
│   │   ├── auth_remote_datasource.dart
│   │   ├── cart_remote_datasource.dart
│   │   ├── favorite_remote_datasource.dart
│   │   ├── order_remote_datasource.dart
│   │   ├── review_remote_datasource.dart
│   │   └── settings_remote_datasource.dart
│   ├── models/                     # Data models (extend entities)
│   │   ├── cart_item_model.dart
│   │   ├── cart_model.dart
│   │   ├── favorite_item_model.dart
│   │   ├── order_model.dart
│   │   ├── review_model.dart
│   │   ├── settings_model.dart
│   │   └── user_model.dart
│   └── repositories/               # Repository implementations
│       ├── auth_repository_impl.dart
│       ├── cart_repository_impl.dart
│       ├── favorite_repository_impl.dart
│       ├── order_repository_impl.dart
│       ├── review_repository_impl.dart
│       └── settings_repository_impl.dart
│
├── presentation/                   # UI layer (depends on domain)
│   ├── providers/                  # State management providers
│   │   ├── auth_provider.dart
│   │   ├── cart_provider.dart
│   │   ├── favorite_provider.dart
│   │   ├── locale_provider.dart
│   │   ├── order_provider.dart
│   │   ├── review_provider.dart
│   │   └── settings_provider.dart
│   ├── screens/                    # UI screens (50+ screens)
│   │   ├── address/                # Address management
│   │   ├── auth/                   # Authentication screens
│   │   ├── cart/                   # Shopping cart
│   │   ├── dashboard/              # Seller dashboard
│   │   ├── favorites/              # Favorites screen
│   │   ├── food/                   # Food browsing
│   │   ├── home/                   # Home screen
│   │   ├── orders/                 # Order management
│   │   ├── payment/                # Payment processing
│   │   ├── profile/                # User profile
│   │   ├── review/                 # Review system
│   │   ├── search/                 # Search functionality
│   │   ├── settings/               # App settings
│   │   ├── tracking/               # Order tracking
│   │   └── ...                     # Additional feature screens
│   └── widgets/                    # Reusable UI components
│       ├── custom_network_image.dart
│       ├── custom_text_field.dart
│       └── seller_bottom_nav.dart
│
├── features/                       # Feature-specific modules
│   ├── address/
│   ├── cart/
│   ├── favorites/
│   └── orders/
│
├── l10n/                           # Localization files
│   ├── app_ar.arb                  # Arabic translations
│   ├── app_en.arb                  # English translations
│   ├── app_fr.arb                  # French translations
│   └── app_localizations.dart      # Generated localization code
│
├── firebase_options.dart           # Firebase configuration (generated)
└── main.dart                       # Application entry point
```

## 🏗️ Architecture Overview

This project implements **Clean Architecture** with the following key principles:

1. **Domain Layer** (`lib/domain/`)
   - Contains business logic and entities
   - Independent of frameworks and external libraries
   - Defines repository interfaces and use cases

2. **Data Layer** (`lib/data/`)
   - Implements repository interfaces from domain layer
   - Handles data sources (Firebase, local storage)
   - Contains data models that extend domain entities

3. **Presentation Layer** (`lib/presentation/`)
   - UI components, screens, and widgets
   - State management using Provider
   - Depends only on domain layer

4. **Core Layer** (`lib/core/`)
   - Shared utilities, constants, and configurations
   - Dependency injection setup
   - Error handling and extensions

## ✨ Key Features

- 🔐 **Authentication System** - Email/password authentication with Firebase
- 🛒 **Shopping Cart** - Real-time cart synchronization with Firestore
- ❤️ **Favorites** - Save and manage favorite food items
- 📦 **Order Management** - Complete order lifecycle management
- ⭐ **Review System** - Rate and review restaurants and dishes
- 📍 **Address Management** - Multiple delivery addresses
- 💳 **Payment Integration** - Payment processing flow
- 📱 **Order Tracking** - Real-time order status tracking
- 👨‍🍳 **Seller Dashboard** - Complete dashboard for restaurant owners
- 🌍 **Multi-language Support** - English, Arabic, and French localization
- 🎨 **Responsive Design** - Adaptive UI for different screen sizes
- 🔒 **Secure Storage** - Encrypted storage for sensitive data

## 📱 Screens

The application includes **50+ screens** covering:
- Authentication (Login, Signup, Forgot Password, Verification)
- Home & Navigation
- Food Browsing & Search
- Cart & Checkout
- Orders & Tracking
- Profile & Settings
- Seller Dashboard
- Reviews & Ratings
- Payment Processing
- And more...

## 🔧 Setup & Installation

1. **Prerequisites**
   - Flutter SDK (3.9.2 or higher)
   - Dart SDK (3.9.2 or higher)
   - Firebase project configured
   - Android Studio / VS Code with Flutter extensions

2. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd "Vital Foods"
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Configure Firebase**
   - Add `google-services.json` to `android/app/`
   - Configure Firebase in `lib/core/firebase/firebase_config.dart`

5. **Run the application**
   ```bash
   flutter run
   ```

## 📝 Code Quality

- ✅ Zero linting errors (`flutter analyze` passes)
- ✅ Clean Architecture principles followed
- ✅ Comprehensive error handling
- ✅ Input validation on all forms
- ✅ Secure data storage practices
- ✅ Responsive design implementation
- ✅ Centralized styling and constants

## 📄 License

This project is developed for educational purposes as part of a 5th-semester portfolio.

---

**Developer**: [Muhammad Humza Majeed]  
**Semester**: 5th Semester  
**Course**: Mobile Application Development  
**Year**: 2025

