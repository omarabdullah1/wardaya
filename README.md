# Wardaya - Flower & Gift Delivery App

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?style=for-the-badge&logo=dart)](https://dart.dev/)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-25D366?style=for-the-badge&logo=apple)](https://flutter.dev/)

Wardaya is a comprehensive mobile application for ordering and delivering flowers, gifts, and celebration items. Built with Flutter, it provides a seamless cross-platform experience for customers to browse, order, and track deliveries of floral arrangements, chocolates, balloons, jewelry, and other special occasion items.

## 🌟 Features

- **Product Catalog**: Extensive collection of flowers, gifts, and celebration items
- **User Authentication**: Secure login and registration with Google Sign-In and Apple Sign-In
- **Location Services**: Integrated Google Maps for delivery address selection and tracking
- **Payment Integration**: Multiple payment methods including credit cards and digital wallets
- **Order Tracking**: Real-time delivery status updates
- **Subscription Services**: Recurring delivery options for regular customers
- **Multilingual Support**: Arabic and English language support
- **Push Notifications**: Order updates and promotional notifications
- **Offline Support**: Core functionality available without internet connection

## 🛠️ Technology Stack

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider/Bloc pattern
- **Backend**: RESTful API integration
- **Database**: SQLite with Sqflite for local storage
- **Maps**: Google Maps Flutter plugin
- **Authentication**: Google Sign-In, Apple Sign-In
- **Payments**: Stripe/PayPal integration
- **Notifications**: Firebase Cloud Messaging
- **Localization**: Flutter Internationalization

## 📱 Screenshots

Add screenshots of your app here

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / Xcode for platform-specific development
- Google Maps API key
- Firebase project configuration

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/omarabdullah1/wardaya.git
   cd wardaya
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Environment Setup**
   - Copy `.env.example` to `.env`
   - Add your API keys and configuration

4. **Platform Setup**

   ```bash
   # For Android
   flutter build apk

   # For iOS
   flutter build ios
   ```

5. **Run the application**

   ```bash
   flutter run
   ```

## 🔧 Configuration

### API Key Security

To protect sensitive API keys, we use environment variables and key obfuscation. Follow these steps to set up the Google Maps API key:

1. Create a `.env` file in the project root (this file is gitignored)
2. Add your Google Maps API key to the `.env` file:

   ```env
   MAPS_API_KEY=your_actual_api_key_here
   ```

3. The app uses the `flutter_dotenv` package to securely access this key at runtime

### For Android

The app includes a placeholder API key in the checked-in `strings.xml` file. This key is replaced during the build process with the actual key from your environment.

### For iOS

For iOS, we use a method channel approach to securely pass the API key from Flutter to native code:

1. The `AppDelegate.swift` contains a placeholder API key
2. At runtime, the real API key is passed from Flutter to iOS native code using a method channel
3. This ensures the real API key is never stored in the source code

### CI/CD Pipeline

In your CI/CD pipeline, add a step to replace the placeholder API key with your actual key before building:

```yaml
# Example GitHub Actions step - Only needed for Android
- name: Replace API keys
  run: |
    sed -i 's/YOUR_MAPS_API_KEY_HERE/${{ secrets.GOOGLE_MAPS_API_KEY }}/g' android/app/src/main/res/values/strings.xml
```

For iOS, no modifications to native files are needed as our method channel implementation handles this securely.

## 📁 Project Structure

```
lib/
├── core/                 # Core utilities and services
├── features/            # Feature modules
├── assets/              # Static assets
├── localization/        # Internationalization files
└── main.dart           # Application entry point

android/                 # Android platform code
ios/                     # iOS platform code
assets/                  # Images, fonts, and other assets
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow the existing code style and architecture patterns
- Write comprehensive tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting PR

**Important**: Never commit API keys directly to the repository. Always use the environment variable approach described above.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Contact

- **Project Owner**: Omar Abdullah
- **Email**: [omar.abdullah9825@gmail.com]
- **GitHub**: [@omarabdullah1](https://github.com/omarabdullah1)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Maps Platform for location services
- Firebase for backend services
- All contributors and supporters

---

Built with ❤️ using Flutter
