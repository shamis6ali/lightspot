# 🚀 LightSpot Monorepo Setup Guide

## ✨ What We've Built

A clean, scalable monorepo with:
- **Flutter app** that runs on mobile AND web (same codebase!)
- **Node.js backend API** for your server needs
- **Shared packages** for common functionality

## 🏗️ New Project Structure

```
lightspot-frontend/
├── apps/
│   ├── mobile/              # 🎯 Flutter app (mobile + web)
│   │   ├── lib/            # Shared Dart code
│   │   ├── android/        # Android config
│   │   ├── ios/            # iOS config
│   │   ├── web/            # Web config (auto-generated)
│   │   └── pubspec.yaml    # Flutter dependencies
│   └── backend/            # 🖥️ Node.js backend API
│       ├── src/            # Express.js server
│       ├── config/         # Database & config
│       └── package.json    # Node.js dependencies
├── packages/
│   └── shared-types/       # Common types (optional)
├── assets/                 # Shared assets
└── docs/                   # Documentation
```

## 🎯 Key Benefits

1. **Single Flutter Codebase**: Same app runs on mobile, web, and desktop
2. **Consistent UI/UX**: Identical look and behavior across platforms
3. **Shared Business Logic**: All your BLoC, models, and services work everywhere
4. **Easier Maintenance**: One codebase instead of separate mobile/web apps
5. **Better Performance**: Flutter Web compiles to optimized JavaScript

## 🚀 How to Use

### Development Commands

```bash
# From root directory
npm run dev:mobile      # Run Flutter on mobile device
npm run dev:web         # Run Flutter on web (Chrome)
npm run dev:backend     # Run Node.js backend API

# Or directly
cd apps/mobile
flutter run             # Mobile
flutter run -d chrome   # Web
flutter run -d macos    # Desktop

cd apps/backend
npm run dev             # Backend API
```

### Building

```bash
npm run build:mobile    # Build Flutter APK
npm run build:web       # Build Flutter web app
npm run build:backend   # Build Node.js backend
```

### Testing

```bash
npm run test:mobile     # Test Flutter app
npm run test:backend    # Test backend API
```

## 🌐 Flutter Web Features

- **Same Code**: Your existing Flutter app works on web
- **Responsive Design**: Automatically adapts to different screen sizes
- **Web Optimization**: Compiles to efficient JavaScript
- **Browser Support**: Works on all modern browsers
- **PWA Ready**: Can be installed as a Progressive Web App

## 🔧 Backend API Endpoints

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration
- `POST /api/auth/refresh` - Refresh JWT token

### Spots/Locations
- `GET /api/spots` - Get all spots (with pagination)
- `GET /api/spots/:id` - Get specific spot
- `POST /api/spots` - Create new spot
- `PUT /api/spots/:id` - Update spot
- `DELETE /api/spots/:id` - Delete spot

### Users
- `GET /api/users/profile` - Get user profile
- `PUT /api/users/profile` - Update user profile
- `GET /api/users/spots` - Get user's spots
- `DELETE /api/users/account` - Delete user account

## 📱 Flutter Web Setup

Flutter Web is already enabled! Your app can now run on:

1. **Mobile**: `flutter run` (Android/iOS)
2. **Web**: `flutter run -d chrome` (Chrome browser)
3. **Desktop**: `flutter run -d macos` (macOS app)

## 🎨 Customization

### Adding Web-Specific Features

```dart
// In your Flutter code
import 'package:flutter/foundation.dart' show kIsWeb;

if (kIsWeb) {
  // Web-specific code
} else {
  // Mobile-specific code
}
```

### Web Configuration

```yaml
# apps/mobile/pubspec.yaml
flutter:
  uses-material-design: true
  assets:
    - assets/pins/location-pin.png
    - assets/pins/2.0x/location-pin.png
    - assets/pins/3.0x/location-pin.png
```

## 🔄 Next Steps

1. **Test Flutter Web**: `npm run dev:web`
2. **Start Backend**: `npm run dev:backend`
3. **Customize Web UI**: Add web-specific responsive design
4. **Deploy**: Build and deploy both Flutter web and backend

## 🎉 You're All Set!

Your Flutter app now runs on:
- ✅ Android
- ✅ iOS  
- ✅ Web (Chrome, Safari, Firefox)
- ✅ Desktop (macOS, Windows, Linux)

And you have a solid Node.js backend ready for your API needs!

---

**Pro Tip**: Use `flutter run -d chrome --web-port 8080` to run web on a specific port, or `flutter run -d chrome --web-hostname 0.0.0.0` to make it accessible from other devices on your network.
