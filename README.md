# LightSpot Monorepo

A full-stack application for discovering and sharing amazing locations, built with Flutter (mobile + web) and Node.js (backend API).

## 🏗️ Project Structure

```
lightspot-frontend/
├── apps/
│   ├── mobile/              # Flutter application (mobile + web)
│   │   ├── lib/            # Shared Dart source code
│   │   ├── android/        # Android configuration
│   │   ├── ios/            # iOS configuration
│   │   ├── web/            # Web configuration (auto-generated)
│   │   └── pubspec.yaml    # Flutter dependencies
│   └── backend/            # Node.js backend API
│       ├── src/            # Express.js source code
│       ├── config/         # Configuration files
│       └── package.json    # Node.js dependencies
├── packages/
│   └── shared-types/       # Common types (if needed)
├── assets/                 # Shared assets (images, icons)
└── docs/                   # Documentation
```

## 🚀 Getting Started

### Prerequisites

- **Flutter**: 3.32.7 or higher
- **Node.js**: 18.0.0 or higher
- **npm**: 9.0.0 or higher

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd lightspot-frontend
   ```

2. **Install dependencies**
   ```bash
   # Install root dependencies
   npm install
   
   # Install web app dependencies
   cd apps/web && npm install
   
   # Get Flutter dependencies
   cd ../mobile && flutter pub get
   ```

### Development

#### Mobile App (Flutter)
```bash
# From root directory
npm run dev:mobile

# Or directly
cd apps/mobile
flutter run
```

#### Web App (Flutter Web)
```bash
# From root directory
npm run dev:web

# Or directly
cd apps/mobile
flutter run -d chrome
```

### Building

#### Mobile App
```bash
# Build APK
npm run build:mobile

# Or directly
cd apps/mobile
flutter build apk
```

#### Web App
```bash
# Build for production
npm run build:web

# Or directly
cd apps/mobile
flutter build web
```

## 📱 Mobile App (Flutter)

The Flutter mobile app provides:
- Interactive maps with Google Maps
- Location clustering
- User authentication
- Community features
- Offline capabilities

## 🌐 Web App (Flutter Web)

The Flutter Web application offers:
- Same codebase as mobile app
- Consistent UI/UX across platforms
- Responsive web interface
- Shared business logic with mobile
- Optimized web performance

## 🔧 Backend API (Node.js)

The Node.js backend provides:
- RESTful API endpoints
- User authentication & authorization
- Location/Spot management
- Data validation & sanitization
- Rate limiting & security
- MongoDB integration ready

## 🔧 Shared Packages

### @lightspot/shared-types
Common TypeScript interfaces and types (if needed):
- User management
- Location/Spot data
- API response structures
- Pagination helpers

## 🧪 Testing

```bash
# Test mobile app
npm run test:mobile

# Test backend API
npm run test:backend
```

## 🧹 Cleaning

```bash
# Clean all projects
npm run clean

# Clean specific project
npm run clean:mobile
npm run clean:backend
```

## 📚 Documentation

- [Mobile App Guide](docs/mobile.md)
- [Web App Guide](docs/web.md)
- [API Documentation](docs/api.md)
- [Deployment Guide](docs/deployment.md)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
