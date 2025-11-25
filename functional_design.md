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
    1.  **Welcome Screen**: Brief introduction.
    2.  **Language Selection**: Choose the preferred language for UI and content (e.g., English, Malayalam).
    3.  **Security Setup**: Option to set up a PIN or biometric authentication for privacy.
    4.  **Feature Overview**: Quick walkthrough of key features.

### 3.2 Home / Dashboard
- **Purpose**: Central hub for accessing all app features.
- **Components**:
    - **Quick Actions**: "Start Examination", "Go to Confession".
    - **Daily Quote**: Inspirational Catholic quote.
    - **Navigation**: Access to Guide, Prayers, Settings, and History.

### 3.3 Examination of Conscience
- **Purpose**: Help users identify their sins based on Catholic teachings.
- **Functionality**:
    - **Guided Flow**: Step-by-step examination based on the Ten Commandments and Precepts of the Church.
    - **Questionnaire**: Yes/No questions for each commandment to prompt reflection.
    - **Custom Items**: Ability to add custom sins or notes.
    - **Progress Tracking**: Visual indicator of progress through the commandments.
    - **Outcome**: Generates a list of sins to be confessed.

### 3.4 Confession Mode
- **Purpose**: Assist the user during the actual sacrament.
- **Functionality**:
    - **Step-by-Step Guide**: Walkthrough of the ritual (Greeting, Confession of Sins, Act of Contrition, Absolution, Penance).
    - **Sin List**: Display the list of sins identified during the examination.
    - **Prayers**: Quick access to the Act of Contrition and other necessary prayers.
    - **Text Size Control**: Adjustable text size for readability in dim confessionals.

### 3.5 Spiritual Guide & Resources
- **Purpose**: Educate users about the sacrament.
- **Content**:
    - **FAQs**: Common questions about confession (What is it? How often? etc.).
    - **Teachings**: Explanations from the Catechism and Church Fathers.
    - **Prayers**: Collection of prayers relevant to repentance and thanksgiving.

### 3.6 History & Progress
- **Purpose**: Track spiritual journey (privately).
- **Functionality**:
    - **Confession Log**: List of past confessions (date, time).
    - **Status**: Mark confessions as "Completed".
    - **Privacy**: All history is stored locally and encrypted.

### 3.7 Settings
- **Purpose**: Customize the app experience.
- **Options**:
    - **Language**: Change app language.
    - **Theme**: Light/Dark mode toggle.
    - **Security**: Change PIN, enable/disable biometrics.
    - **Data Management**: Clear all data, reset app.
    - **Notifications**: Reminders for regular confession.

## 4. User Experience (UX) Principles
- **Privacy First**: Emphasize that data is stored locally and encrypted.
- **Simplicity**: Clean, distraction-free interface suitable for prayerful reflection.
- **Accessibility**: Support for dynamic text sizes and clear contrast.
- **Personalization**: "User should feel personal" (as per design goals).

## 5. Content Strategy
- **Source**: Content is derived from the Catechism of the Catholic Church, liturgical books, and approved Catholic resources.
- **Localization**: Support for multiple languages (initially English and Malayalam) with the ability to expand.
- **Updates**: Content is versioned and can be updated via app updates.
