# LightSpot Frontend (Flutter)

Mobile client for **LightSpot** — _brief one-liner about what it does (e.g., “a location‑aware lighting assistant …”)_.  
Android is the primary target. Secrets (e.g., Google Maps API key) are injected via Gradle placeholders and **not** committed.

---

## ⚙️ Tech Stack

- **Flutter** (Dart)
- **Android** target (Gradle Kotlin DSL)
- Google Maps (or your API of choice)
- Backend: _(link to repo / API docs if applicable)_

---

## 🚀 Quick Start (Android Studio)

1. **Clone**
   ```bash
   git clone git@github.com:shamis6ali/lightspot-frontend.git
   cd lightspot-frontend
   ```
2. **Open Android Studio**
   - “Open an existing project” → select repo root.
   - Let it install any missing Android SDK components.
3. **Install Flutter/Dart plugins**
4. **Add your API key**
   - Contact Shamis
5. **Sync & Run**
   - Click “Sync Project with Gradle Files”.
   - Plug in a device or start an emulator.
   - Press the play button

## CLI Run (Optional)
```bash
flutter pub get
flutter doctor
flutter run
```

## Project Structure
```bash
lightspot-frontend/
├─ lib/                     # Flutter source
├─ android/
│  ├─ app/
│  │  └─ build.gradle.kts   # module build file (Kotlin DSL)
│  ├─ local.properties      # contains MAPS_API_KEY (not committed)
│  └─ src/main/AndroidManifest.xml
├─ pubspec.yaml
└─ README.md
```

## Useful Commands
| Action                  | Command                       |
| ----------------------- | ----------------------------- |
| Get dependencies        | `flutter pub get`             |
| Analyze code            | `flutter analyze`             |
| Run tests               | `flutter test`                |
| Build release (Android) | `flutter build apk --release` |

## Contributing
1. Branch: git checkout -b feature/your-thing
2. Commit: Use conventional messages (feat:, fix:, etc.)
3. Push and PR: git push origin feature/your-thing
4. Request Review (let Shamis or Ammar know)

## Credits
Shamis Ali
Ammar Elzeftawy
