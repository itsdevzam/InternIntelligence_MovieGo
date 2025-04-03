# MovieGo - A Flutter Movie Browsing App

MovieGo is a Flutter application that allows users to browse and explore movies by categories, view details, and access movie information using The Movie Database (TMDb) API.

## 📌 Features

- 🎬 Browse movies by categories (Action, Comedy, Horror, etc.)
- 🔍 Search for movies
- ⭐ View movie details, including ratings and overviews
- 🖼️ Display movie posters and backdrops
- 🔗 Integrated with TMDb API for real-time movie data

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed:

- Flutter SDK ([Install Flutter](https://flutter.dev/docs/get-started/install))
- Dart SDK
- Android Studio / VS Code (Recommended)
- TMDb API Key (Get from [TMDb](https://www.themoviedb.org/))

### 📥 Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/YOUR_GITHUB_USERNAME/InternIntelligence_MovieGo.git
   cd InternIntelligence_MovieGo
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Add API Key**
    - Navigate to `lib/utils/api.dart`
    - Replace `YOUR_API_KEY_HERE` with your TMDb API Key.

   ```dart
   class API {
     static const String apiKey = "YOUR_API_KEY_HERE";
   }
   ```

4. **Run the App**
   ```bash
   flutter run
   ```

## 🛠️ Tech Stack

- **Flutter** - UI framework
- **Dart** - Programming language
- **TMDb API** - Movie database

## 📸 Screenshots

| Home Screen |
|------------|
| ![Home](screenshots/home.png) | 

## 🤝 Contribution

1. Fork the repository
2. Create a new branch (`git checkout -b feature-name`)
3. Commit your changes (`git commit -m 'Add feature'`)
4. Push to the branch (`git push origin feature-name`)
5. Open a Pull Request

## 📜 License

This project is open-source and available under the **MIT License**.

---

### 🔥 Follow & Share

If you find this useful, please ⭐ the repo and share your feedback!

Happy coding! 🚀

