# Todo App

A modern, feature-rich Todo application built with Flutter and Supabase, implementing clean architecture principles and state management using BLoC pattern.

## Features

- 🔐 User Authentication (Email/Password)
- ✨ Create, Read, Update, and Delete Todo items
- 🎨 Modern and responsive UI design
- 🌐 Real-time data synchronization with Supabase
- 📱 Cross-platform support (Android, iOS)

## Tech Stack

- **Framework**: Flutter
- **State Management**: Flutter BLoC
- **Backend**: Supabase
- **Routing**: Go Router
- **Authentication**: Supabase Auth + Google Sign-in
- **Styling**: Google Fonts
- **Environment Variables**: flutter_dotenv

## Getting Started

### Prerequisites

- Flutter SDK (^3.8.0)
- Dart SDK
- Supabase account

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/todo-app.git
   cd todo-app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Create a `.env` file in the root directory with your Supabase credentials:
   ```
   SUPABASE_URL=your_supabase_url
   SUPABASE_PUBLISHABLE_KEY=your_supabase_publishable_key
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/
│   ├── app_theme.dart
│   └── router.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── todo/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart
```

## Architecture

The project follows clean architecture principles with the following layers:
- **Presentation Layer**: UI components and BLoC state management
- **Domain Layer**: Business logic and entities
- **Data Layer**: Repositories and data sources


