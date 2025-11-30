# Technical Design Document - Metanoia: Catholic Confession

## 1. Architecture
The application follows a **Feature-First, Layered Architecture** to ensure scalability, maintainability, and testability.

### 1.1 Project Structure

```
lib/src/
├── core/                          # Shared infrastructure & components
│   ├── database/
│   │   ├── app_database.dart     # Main database class (Drift)
│   │   ├── app_database.g.dart   # Generated database code
│   │   ├── tables.dart           # Database schema definitions
│   │   ├── data_loader.dart      # JSON data synchronization
│   │   └── database_provider.dart # Riverpod provider
│   ├── router/
│   │   ├── app_router.dart       # GoRouter configuration
│   │   └── scaffold_with_navbar.dart # Bottom navigation bar layout
│   ├── theme/
│   │   ├── app_theme.dart        # Light & dark theme definitions
│   │   ├── theme_provider.dart   # Theme toggle state (Riverpod)
│   │   └── app_showcase.dart     # Tutorial showcase widget
│   ├── localization/
│   │   ├── language_provider.dart        # App UI language
│   │   ├── content_language_provider.dart # Content language selection
│   │   └── l10n/                 # Generated localization files
│   ├── services/
│   │   └── reminder_service.dart # Notification scheduling
│   ├── tutorial/
│   │   └── tutorial_controller.dart # First-run tutorial management
│   └── utils/
│
└── features/                       # Feature-specific code
    ├── home/                       # Dashboard & quick actions
    │   ├── data/repositories/
    │   ├── domain/models/
    │   └── presentation/
    │
    ├── examination/                # Examination of conscience flow
    │   ├── data/
    │   │   ├── examination_repository.dart
    │   │   └── user_custom_sins_repository.dart
    │   └── presentation/
    │       ├── examination_screen.dart
    │       ├── examination_controller.dart
    │       ├── custom_sins_screen.dart
    │       └── widgets/
    │
    ├── confession/                 # Confession step-by-step guide
    │   ├── data/
    │   └── presentation/
    │
    ├── guide/                      # Educational resources
    │   └── presentation/
    │
    ├── settings/                   # User preferences
    │   └── presentation/
    │
    └── onboarding/                 # First-run setup
        └── presentation/
```

### 1.2 State Management
- **Library**: `flutter_riverpod` v2.4.9 with `riverpod_annotation` for code generation
- **Pattern**:
    - **Providers**: Dependency injection (databaseProvider, repositoryProvider)
    - **Notifiers**: `AsyncNotifier` and `Notifier` for UI state and business logic
    - **Immutability**: State classes are immutable

### Key Providers

| Provider | Type | Purpose |
|----------|------|---------|
| `themeModeControllerProvider` | Notifier | Theme toggle (Light/Dark/System) |
| `languageControllerProvider` | Notifier | App UI language (Locale) |
| `contentLanguageControllerProvider` | Notifier | Examination/prayer content language |
| `examinationControllerProvider` | AsyncNotifier | Selected sins during examination |
| `reminderSettingsProvider` | Notifier | Reminder frequency, day, time |
| `keepHistorySettingsProvider` | Notifier | Confession history retention |
| `tutorialControllerProvider` | Notifier | Tutorial display flags |

### 1.3 Navigation
- **Library**: `go_router` v14.0.2
- **Pattern**: Declarative routing with StatefulShellRoute for bottom navigation
- **Configuration**: `lib/src/core/router/app_router.dart`

**Route Structure**:
```
/ (Home - Branch 0)
├── /examine (Branch 1)
│   └── /examine/custom-sins
├── /confess (Branch 2)
│   └── /confess/history
├── /guide (Branch 3)
│   ├── /guide/faq
│   └── /guide/prayers
├── /settings
│   └── /settings/about
└── /onboarding
```

## 2. Tech Stack

| Category | Technology | Version | Purpose |
|----------|------------|---------|---------|
| **Framework** | Flutter | Latest | Cross-platform UI development |
| **Language** | Dart | Latest | Programming language |
| **Database** | Drift | 2.14.1 | Local relational database (ORM) |
| **Encryption** | SQLCipher | - | Database encryption |
| **Key Storage** | flutter_secure_storage | 9.0.0 | Secure storage for encryption keys |
| **Preferences** | shared_preferences | 2.2.2 | Simple key-value storage |
| **State Management** | flutter_riverpod | 2.4.9 | Dependency injection and state |
| **Navigation** | go_router | 14.0.2 | Routing and navigation |
| **Localization** | flutter_localizations | - | Internationalization support |
| **Typography** | google_fonts | 6.1.0 | Custom fonts (Lato, Merriweather) |
| **Animations** | flutter_animate | 4.5.0 | Animation framework |
| **Tutorials** | showcaseview | 5.0.1 | Tutorial overlays |
| **Intl** | intl | 0.19.0 | Internationalization utilities |

## 3. Data Layer

### 3.1 Database Schema (Drift)
Defined in `lib/src/core/database/tables.dart`, managed by `AppDatabase`.

#### Static Content Tables

| Table | Purpose | Key Fields |
|-------|---------|-----------|
| `Commandments` | Ten Commandments & Precepts | id, commandmentNo, content, languageCode, code (unique), customTitle |
| `ExaminationQuestions` | Questions for each commandment | id, commandmentId (FK), question, languageCode |
| `Faqs` | Frequently asked questions | id, heading, title, content, languageCode |
| `Quotes` | Inspirational quotes | id, author, quote, languageCode |
| `GuideItems` | Confession guide content | id, section, title, icon, content, displayOrder, languageCode |
| `Prayers` | Prayer texts | id, title, content, displayOrder, languageCode |

#### User Data Tables (Encrypted)

| Table | Purpose | Key Fields |
|-------|---------|-----------|
| `Confessions` | Confession session records | id, date, isFinished, finishedAt |
| `ConfessionItems` | Individual sins in a confession | id, confessionId (FK), content, note, isCustom, questionId (nullable FK) |
| `UserSettings` | App preferences | id, key (unique), value |
| `UserCustomSins` | Custom sins added by user | id, sinText, note, commandmentCode (nullable), originalQuestionId (nullable FK), createdAt, updatedAt |

### 3.2 Data Security
- **Encryption**: SQLite database encrypted using SQLCipher
- **Key Management**: Encryption key generated securely, stored in `FlutterSecureStorage`
- **Access**: Database only accessible via `AppDatabase` class, handles decryption transparently

### 3.3 Data Loading
- **Source**: Static content in JSON files under `assets/data/`
- **Sync**: `DataLoader` reads JSON and syncs to database on app start/update
- **Multi-language**: Separate JSON files per language (e.g., `questions_en.json`, `questions_ml.json`)

**Asset Structure**:
```
assets/data/
├── commandments/commandments_{lang}.json
├── questions/questions_{lang}.json
├── faqs/faqs_{lang}.json
├── quotes/quotes_{lang}.json
├── prayers/prayers_{lang}.json
└── guide/guide_{lang}.json
```

## 4. Key Feature Implementation

### 4.1 Examination of Conscience
- **Controller**: `ExaminationController` (AsyncNotifier)
- **Data Flow**:
    1. User selects "Start Examination"
    2. App creates new `Confession` entry or resumes existing draft
    3. Questions fetched from `ExaminationQuestions` by commandment
    4. User selections saved as `ConfessionItems`
    5. Draft auto-saved, restorable with snackbar notification
- **Custom Sins**: Users can add personal sins via `UserCustomSinsRepository`

### 4.2 Custom Sins Management
- **Repository**: `UserCustomSinsRepository`
- **Features**:
    - CRUD operations for custom sins
    - Optional linking to specific commandments
    - Note field for additional context
    - Dialog-based add/edit interface

### 4.3 Confession Flow
- **Logic**: Step-by-step wizard guiding through the sacrament
- **Data Flow**:
    1. Retrieve active `Confession` and `ConfessionItems`
    2. Display items as numbered list
    3. Upon completion, mark `Confession` as `isFinished = true` with timestamp

### 4.4 Localization
- **Implementation**: Standard `flutter_localizations`
- **UI Strings**: Generated via ARB files in `lib/src/core/localization/l10n/`
- **Content**: Database tables include `languageCode` column
- **Selection**:
    - `LanguageController`: App UI language
    - `ContentLanguageController`: Examination/prayer content language

### 4.5 Theme Management
- **Controller**: `ThemeModeController`
- **Modes**: Light, Dark, System
- **Implementation**: Material 3 ColorScheme in `AppTheme` class
- **Persistence**: SharedPreferences

## 5. Theme System

### 5.1 Color Palette

#### Light Theme
| Role | Hex | Description |
|------|-----|-------------|
| Primary | `#7558A3` | Deep Royal Purple |
| Secondary | `#D4A545` | Rich Warm Gold |
| Accent | `#2D0055` | Deep Purple |
| Tertiary | `#B76E79` | Muted Rose-Gold |
| Surface | `#FCFBF9` | Warm Off-White |
| Background | `#F8F6F3` | Subtle Warm Grey |

#### Dark Theme
| Role | Hex | Description |
|------|-----|-------------|
| Primary | `#9D7FCC` | Softer Light Purple |
| Secondary | `#F3CB5C` | Balanced Warm Gold |
| Accent | `#5B3A7C` | Lighter Purple |
| Tertiary | `#B794D6` | Soft Lavender |
| Surface | `#1C1626` | Deep Purple-Tinted |
| Background | `#121019` | Deep Purple-Black |

### 5.2 Typography
- **Primary Font**: Google Fonts "Lato"
- **Quotes Font**: Google Fonts "Merriweather" (italic)
- **Letter Spacing**: Display -0.5, Title 0-0.15, Body 0.25-0.5
- **Line Height**: Body 1.5-1.6

### 5.3 Component Styling
| Component | Border Radius | Elevation |
|-----------|---------------|-----------|
| Cards | 16dp | 0 (1px border) |
| Buttons | 12dp | 2pt |
| AppBar | - | 0 (transparent) |

## 6. Storage Architecture

| Storage Type | Technology | Data |
|--------------|------------|------|
| Encrypted DB | Drift + SQLCipher | Confessions, sins, user content |
| Secure Keys | FlutterSecureStorage | Database encryption key |
| Preferences | SharedPreferences | Theme, language, tutorial flags, reminders |
| Assets | JSON files | Static content (questions, prayers, etc.) |

## 7. Repositories

| Repository | Location | Purpose |
|------------|----------|---------|
| `ExaminationRepository` | `features/examination/data/` | Questions, commandments, confession items |
| `UserCustomSinsRepository` | `features/examination/data/` | Custom sin CRUD operations |
| `ConfessionRepository` | `features/confession/data/` | Confessions, history |
| `QuoteRepository` | `features/home/data/` | Daily quotes |

## 8. Future Considerations
- **Cloud Sync**: Encrypted cloud sync for data backup
- **Biometrics**: Integration with `local_auth` for biometric app unlock
- **Additional Languages**: Expand beyond English and Malayalam
- **Widgets**: Home screen widgets for quick access
