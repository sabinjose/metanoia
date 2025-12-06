# Metanoia: Catholic Confession App
> **Tagline:** *Turn Back to Grace*

## App Vision

A comprehensive digital companion designed to assist Catholics in preparing for and participating in the Sacrament of Reconciliation (Confession). The app provides a guided examination of conscience, educational resources, and a step-by-step walkthrough of the confession process, all within a secure and private environment.

---

## Core Features

### 1. Spiritual Guide & Resources
- Guide explaining Church's teaching on confession
- Excerpts from the Catechism of the Catholic Church and liturgical books
- Comprehensive FAQ on confession
- Prayers for confession (Act of Contrition, etc.)

### 2. Examination of Conscience
- Guided examination based on the Ten Commandments
- Precepts of the Catholic Church
- Yes/No style questions to prompt reflection
- Custom sins/notes capability for additional items
- Progress tracking through commandments

### 3. Confession Mode
- Step-by-step guide through the sacrament
- Sin list display from examination
- Quick access to prayers
- Confession history tracking

---

## Design System

### Color Palette

#### Light Theme
| Role | Color | Hex | Purpose |
|------|-------|-----|---------|
| Primary | Deep Royal Purple | `#7558A3` | Main brand color, spiritual/reverent |
| Secondary | Rich Warm Gold | `#D4A545` | Warm, peaceful accents |
| Accent | Deep Purple | `#2D0055` | Emphasis elements |
| Tertiary | Muted Rose-Gold | `#B76E79` | Special accents |
| Surface | Warm Off-White | `#FCFBF9` | Content surfaces |
| Background | Subtle Warm Grey | `#F8F6F3` | App background |
| Card | Pure White | `#FFFFFF` | Card backgrounds |

#### Dark Theme
| Role | Color | Hex | Purpose |
|------|-------|-----|---------|
| Primary | Softer Light Purple | `#9D7FCC` | Main brand color |
| Secondary | Balanced Warm Gold | `#F3CB5C` | Warm accents |
| Accent | Lighter Purple | `#5B3A7C` | Emphasis elements |
| Tertiary | Soft Lavender | `#B794D6` | Special accents |
| Surface | Deep Purple-Tinted | `#1C1626` | Content surfaces |
| Background | Deep Purple-Black | `#121019` | App background |
| Card | Purple-Tinted Dark | `#272134` | Card backgrounds |

### Typography

| Style | Font | Weight | Letter Spacing |
|-------|------|--------|----------------|
| Display | Lato | Bold | -0.5 |
| Title Large | Lato | Bold | 0 |
| Title Medium | Lato | Bold | 0.15 |
| Body Large | Lato | Regular | 0.5 (line-height: 1.5) |
| Body Medium | Lato | Regular | 0.25 (line-height: 1.6) |
| Quotes | Merriweather | Italic | - |

### Component Styling

| Component | Border Radius | Elevation | Notes |
|-----------|---------------|-----------|-------|
| Cards | 16dp | 0 | 1px outline border |
| Buttons | 12dp | 2pt | 32px horizontal padding |
| Navigation Bar | - | - | Material 3 style |
| AppBar | - | 0 | Transparent, centered title |

---

## Technology Stack

| Category | Technology |
|----------|------------|
| Framework | Flutter |
| Language | Dart |
| State Management | Riverpod (with code generation) |
| Navigation | GoRouter v14 |
| Database | Drift (SQLite with SQLCipher encryption) |
| Key Storage | flutter_secure_storage |
| Typography | Google Fonts (Lato, Merriweather) |
| Animations | flutter_animate |
| Tutorials | showcaseview |

---

## Localization

### Supported Languages
- English (en)
- Malayalam (ml)

### Implementation
- UI strings via `flutter_localizations`
- Content stored in database with `languageCode` column
- Separate language selection for UI and content

---

## Security & Privacy

- **Local-Only Storage**: All data stored on device
- **Encryption**: Database encrypted with SQLCipher
- **Secure Key Storage**: Encryption keys in FlutterSecureStorage
- **No Cloud Sync**: Privacy-focused design

---

## Design Principles

1. **Privacy First** - All data stored locally and encrypted
2. **Simplicity** - Clean, distraction-free interface for prayerful reflection
3. **Accessibility** - Dynamic text sizes, clear contrast
4. **Personalization** - User-centric, contemplative experience
5. **Dark Mode Support** - Full theme switching without hardcoded colors

