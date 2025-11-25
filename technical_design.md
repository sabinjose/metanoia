# Technical Design Document - Metanoia: Catholic Confession

## 1. Architecture
The application follows a **Feature-First, Layered Architecture** to ensure scalability, maintainability, and testability.

### 1.1 High-Level Structure
- **`lib/src/features`**: Contains feature-specific code (e.g., `confession`, `examination`, `onboarding`). Each feature is further divided into:
    - **`data`**: Repositories, data sources, and DTOs.
    - **`domain`**: Entities and business logic.
    - **`presentation`**: Widgets, screens, and state controllers (Riverpod).
- **`lib/src/core`**: Contains shared components and infrastructure (e.g., `database`, `router`, `theme`, `utils`).

### 1.2 State Management
- **Library**: `flutter_riverpod` with `riverpod_annotation` for code generation.
- **Pattern**:
    - **Providers**: Used for dependency injection (e.g., `databaseProvider`, `repositoryProvider`).
    - **Notifiers**: `AsyncNotifier` and `Notifier` are used to manage UI state and business logic.
    - **Immutability**: State classes are immutable (likely using `freezed` or standard Dart immutable classes).

### 1.3 Navigation
- **Library**: `go_router`.
- **Pattern**: Declarative routing with type-safe routes (if using `go_router_builder`, otherwise string-based paths).
- **Structure**: Centralized router configuration in `lib/src/core/router/app_router.dart`.

## 2. Tech Stack

| Category | Technology | Purpose |
| :--- | :--- | :--- |
| **Framework** | Flutter | Cross-platform UI development. |
| **Language** | Dart | Programming language. |
| **Database** | Drift (SQLite) | Local relational database. |
| **Encryption** | SQLCipher | Database encryption. |
| **Key Storage** | flutter_secure_storage | Secure storage for database encryption keys. |
| **Preferences** | shared_preferences | Simple key-value storage for non-sensitive settings. |
| **State Management** | Riverpod | Dependency injection and state management. |
| **Navigation** | GoRouter | Routing and navigation. |
| **Localization** | flutter_localizations | Internationalization support. |

## 3. Data Layer

### 3.1 Database Schema (Drift)
The database is defined in `lib/src/core/database/tables.dart` and managed by `AppDatabase`.

#### Static Content Tables
- **`Commandments`**: Ten Commandments and Precepts.
- **`ExaminationQuestions`**: Questions linked to commandments for examination.
- **`Faqs`**: Frequently asked questions.
- **`Quotes`**: Inspirational quotes.
- **`GuideItems`**: Content for the confession guide.
- **`Prayers`**: Prayers for confession.

#### User Data Tables (Encrypted)
- **`Confessions`**: Records of past confessions (Date, Status).
- **`ConfessionItems`**: Sins added during examination, linked to a confession.
- **`UserSettings`**: User preferences and settings.

### 3.2 Data Security
- **Encryption**: The SQLite database is encrypted using SQLCipher.
- **Key Management**: The encryption key is generated securely and stored in `FlutterSecureStorage`.
- **Access**: The database is only accessible via the `AppDatabase` class, which handles the decryption transparently.

### 3.3 Data Loading
- **Source**: Static content (questions, prayers, etc.) is stored in JSON files in the `assets` directory.
- **Sync**: On app start or update, the `DataLoader` reads the JSON files and synchronizes the database tables (`syncContent` method in `AppDatabase`).

## 4. Key Feature Implementation

### 4.1 Examination of Conscience
- **Logic**: A state machine manages the progress through the commandments.
- **Data Flow**:
    1.  User selects "Start Examination".
    2.  App creates a new `Confession` entry (or resumes an existing one).
    3.  Questions are fetched from `ExaminationQuestions` based on the current commandment.
    4.  User answers are saved as `ConfessionItems`.

### 4.2 Confession Flow
- **Logic**: A step-by-step wizard guiding the user through the sacrament.
- **Data Flow**:
    1.  App retrieves the active `Confession` and its `ConfessionItems`.
    2.  Items are displayed as a list for the user to read.
    3.  Upon completion, the `Confession` is marked as `isFinished = true`.

### 4.3 Localization
- **Implementation**: Uses standard `flutter_localizations`.
- **Content**: Database tables include a `languageCode` column to support multi-language content.
- **Selection**: User language preference is stored in `UserSettings` and applied via a `LanguageProvider`.

## 5. Future Considerations
- **Cloud Sync**: Currently, all data is local. Future updates could consider encrypted cloud sync.
- **Biometrics**: Integration with `local_auth` for biometric unlocking of the app.
