# Functional Design Document - Metanoia: Catholic Confession
> **Tagline:** *Turn Back to Grace*

## 1. Overview
The Confession App is a comprehensive digital companion designed to assist Catholics in preparing for and participating in the Sacrament of Reconciliation (Confession). It provides a guided examination of conscience, educational resources, and a step-by-step walkthrough of the confession process, all within a secure and private environment.

## 2. Target Audience
- **Primary Users**: Catholics seeking to make a good confession, ranging from frequent penitents to those returning to the sacrament after a long period.
- **Secondary Users**: Individuals interested in learning about the Catholic faith and the sacrament of confession.

## 3. Core Features

### 3.1 Onboarding
- **Purpose**: Introduce the user to the app's value proposition and set up essential preferences.
- **Flow**:
    1. **Welcome Screen**: Brief introduction with app overview
    2. **Language Selection**: Choose preferred language (English, Malayalam, or System default)
    3. **Security Setup**: Option to set up biometric authentication for privacy
    4. **Feature Overview**: Quick walkthrough of key features with tutorial
    5. **Completion Tracking**: Onboarding status persisted via SharedPreferences

### 3.2 Home / Dashboard
- **Purpose**: Central hub for accessing all app features.
- **Components**:
    - **Daily Quote Card**: Random inspirational quote with Merriweather italic font
    - **Quick Actions Grid** (2x2 layout):
        - Examine Conscience (primary container)
        - Confess (secondary/gold container)
        - Prayers (tertiary container)
        - Guide (surface container)
    - **Info Cards**:
        - Last Confession date display
        - Next Reminder schedule
    - **Animations**: fadeIn, scale, slideY with staggered delays using flutter_animate
    - **Tutorial Integration**: ShowCaseView with step-by-step guides for first-time users

### 3.3 Examination of Conscience
- **Purpose**: Help users identify their sins based on Catholic teachings.
- **Functionality**:
    - **Search/Filter**: Find specific commandments or questions
    - **Progress Tracking**: Visual counter showing selected items
    - **Commandments List**: Expandable/collapsible sections by commandment
    - **Question Selection**: Yes/No style questions for reflection
    - **Draft Restore**: Automatic restoration from previous session with snackbar notification
    - **Custom Sins**: Add personal sin notes linked to specific commandments
    - **Actions**: Save draft, proceed to confession

### 3.4 Custom Sins Management
- **Purpose**: Allow users to add personal sins not covered by standard questions.
- **Functionality**:
    - **CRUD Operations**: Add, edit, delete custom sins
    - **Commandment Linking**: Optional association with specific commandments
    - **Note Field**: Additional context for each custom sin
    - **Database Persistence**: Stored in UserCustomSins table
    - **Dialog Interface**: Clean modal dialog for add/edit operations

### 3.5 Confession Mode
- **Purpose**: Assist the user during the actual sacrament.
- **Functionality**:
    - **Empty State**: Prompt to start examination if no active session
    - **Sin List Display**: Card-based layout with numbered items
    - **Step-by-Step Guide**: Prayer prompts and ritual walkthrough (Greeting, Confession, Act of Contrition, Absolution, Penance)
    - **Prayers**: Quick access to Act of Contrition and necessary prayers
    - **Completion**: Mark confession as finished with timestamp
    - **History Access**: Navigate to past confessions

### 3.6 Confession History
- **Purpose**: Track spiritual journey privately.
- **Functionality**:
    - **Paginated List**: Chronological list of past confessions
    - **Date & Status**: Display confession date and completion status
    - **Detail View**: Open and view individual confession details
    - **Optional Clearing**: Clear history based on user settings (KeepHistorySettings)
    - **Privacy**: All history stored locally and encrypted

### 3.7 Spiritual Guide & Resources
- **Purpose**: Educate users about the sacrament.
- **Content**:
    - **Guide Screen**: Main educational content hub
    - **FAQ Section**: Common questions with expandable answers
    - **Prayers Screen**: Collection of prayers (Act of Contrition, etc.)
    - **Teachings**: Catechism excerpts and Church guidance
    - **Search Functionality**: Find specific content
    - **Expandable Cards**: Clean, distraction-free content display

### 3.8 Settings
- **Purpose**: Customize the app experience.
- **Options**:
    - **Theme Toggle**: Light/Dark/System mode with ThemeModeController
    - **Language Selection**:
        - App UI language (Locale)
        - Content language (separate selection for examination/prayers)
    - **Reminder Settings**:
        - Frequency configuration
        - Day of week selection
        - Time setting
        - Advance notification days
    - **Data Management**:
        - Clear confession history
        - Keep history toggle
        - Reset app option
    - **About Screen**: App version, attributions, information

## 4. Navigation Structure

```
/ (Home - Branch 0)
├── /examine (Examination - Branch 1)
│   └── examine/custom-sins (Modal)
├── /confess (Confession - Branch 2)
│   └── confess/history (Modal)
├── /guide (Guide - Branch 3)
│   ├── guide/faq (Modal)
│   └── guide/prayers (Modal)
├── /settings (Modal)
│   └── settings/about
└── /onboarding (Conditional redirect for first-time users)
```

**Navigation Pattern**:
- StatefulShellRoute for bottom nav persistence
- Branch-specific navigator keys
- NoTransitionPage for bottom nav items (instant switch)
- Modal pages fade in with context.push()

## 5. User Experience (UX) Principles
- **Privacy First**: All data stored locally and encrypted with SQLCipher
- **Simplicity**: Clean, distraction-free interface suitable for prayerful reflection
- **Accessibility**: Support for dynamic text sizes and clear contrast
- **Personalization**: User-centric, contemplative experience
- **Dark Mode**: Full theme support without hardcoded colors
- **Animations**: Subtle, respectful animations that enhance without distracting

## 6. Animation & Transition Patterns

### flutter_animate Usage
```dart
.animate().fadeIn()                    // Fade in effect
.animate().slideY(begin: 0.2, end: 0)  // Slide from bottom
.animate().scale(begin: 0.95)          // Scale from smaller
.animate().fadeIn(delay: 200.ms)       // Staggered delays
```

### Page Transitions
- **Android**: FadeUpwardsPageTransitionsBuilder
- **iOS/macOS**: CupertinoPageTransitionsBuilder

## 7. Content Strategy
- **Source**: Content derived from Catechism of the Catholic Church, liturgical books, and approved Catholic resources
- **Localization**:
    - English (en) and Malayalam (ml) supported
    - UI strings via flutter_localizations
    - Content stored in database with languageCode column
- **Asset Structure**:
    ```
    assets/data/
    ├── commandments/commandments_{lang}.json
    ├── questions/questions_{lang}.json
    ├── faqs/faqs_{lang}.json
    ├── quotes/quotes_{lang}.json
    ├── prayers/prayers_{lang}.json
    └── guide/guide_{lang}.json
    ```
- **Data Sync**: DataLoader syncs JSON assets to database on app start/update

## 8. Tutorial System
- **ShowCaseView Integration**: First-run tutorial with step-by-step guides
- **AppShowcase Widget**:
    - Custom tooltip with gradient header
    - Progress indicators (dots)
    - Navigation buttons (Previous/Continue)
    - Dynamic blur and overlay (70-80% opacity)
    - Responsive constraints (85% max width)
- **Tutorial Controller**: Manages first-run tutorial flags via SharedPreferences
