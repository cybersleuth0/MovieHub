
# 🎬 MovieHub - Flutter-Powered Movie Database App

**A beautiful, cross-platform movie information app built with Clean Architecture & BLoC**

[![Flutter](https://img.shields.io/badge/Flutter-3.8+-blue?logo=flutter)](https://flutter.dev)
[![BLoC](https://img.shields.io/badge/State%20Management-BLoC-5AC1F1)](https://bloclibrary.dev)
[![Platforms](https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-9cf)](https://flutter.dev/multi-platform)

---

## 🎯 Project Highlights

✅ **Clean Architecture** with clear separation of concerns  
✅ **BLoC State Management** for robust, scalable business logic  
✅ **Modern UI** using Google Fonts and custom theming  
✅ **API Integration** with The Movie Database (TMDb)  
✅ **Production Ready** error/loading handling and responsive layouts  

---

## 📱 Feature Showcase

| Feature                 | Implementation Details                                             |
|-------------------------|-------------------------------------------------------------------|
| **Trending Movies Grid**| REST API fetch with infinite scroll/pagination                    |
| **Movie Details Page**  | Rich details (overview, poster, meta, budget, revenue, etc.)      |
| **Search Bar**          | UI present (logic can be extended for real search)                |
| **Error Handling**      | BLoC-based error state and retry UI                               |
| **Attractive Splash**   | Animated splash screen with gradients and branding                |

---



### Key Architectural Decisions:
1. **BLoC Pattern** for business logic (`flutter_bloc`)
2. **Separation of Concerns**: UI, state management, models, constants, and API helpers are separated
3. **Central Routing**: All navigation handled via constants and a single route map
4. **Error Handling**: Managed via BLoC state


---

## 🛠️ Tech Stack & Packages

| Package             | Usage                                      | Version    |
|---------------------|--------------------------------------------|------------|
| `flutter_bloc`      | State management (BLoC architecture)       | ^9.1.1     |
| `http`              | REST API requests to fetch movie data      | ^1.4.0     |
| `google_fonts`      | Modern font styling for UI                 | ^6.2.1     |
| `cupertino_icons`   | iOS-style icons                            | ^1.0.8     |

---

## 🚀 Getting Started

### Prerequisites
- Flutter 3.8+
- Dart 3.8+
- TMDb API key (already included by default for testing)

### Quick Start
```bash
# 1. Clone repository
git clone https://github.com/cybersleuth0/MovieHub.git

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

---

## 📂 Project Structure

```
lib/
├── AppConstant/        # App-wide constants (routes, API URLs)
│   ├── constant.dart
│   └── urls.dart
├── Bloc/
│   ├── MovieDetailsBloc/ # BLoC for movie details
│   └── MovieLoadBloc/    # BLoC for trending movies list
├── UIPages/            # UI screens (Splash, Home, Details)
│   ├── homepage.dart
│   ├── movieDetails.dart
│   └── splashScreen.dart
├── data/
│   └── remote/
│       └── helper/      # API helper(s)
├── model/              # Data models for movies and details
│   └── model.dart
├── main.dart           # App entry point, BLoC/routing setup
pubspec.yaml            # Project metadata & dependencies
Assets/
└── Images/             # App images, logos, and screenshots
```

---

## 📈 Future Roadmap

- [ ] Implement real search API for movies
- [ ] Add favorites & user collections
- [ ] Add theme switcher (dark/light)
- [ ] Localization and accessibility improvements
- [ ] Expand test coverage (unit/widget tests)
- [ ] Push notifications for trending movies

---
