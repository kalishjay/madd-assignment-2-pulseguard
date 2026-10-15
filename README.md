# PulseGuard AI Suite — SE4041 MADD Assignment 02

**Course:** SE4041 – Mobile Application Design and Development  
**Academic Year:** 4th Year, Semester 2 (2026)  
**Student ID:** IT22550330  
**Student Name:** Jayasinghe I.B.K.S  
**Total Grade Allocation:** 25% (Part A: 15% | Part B: 10%)  

---

## 📌 Project Overview

This repository contains the complete source code, Xcode projects, test suites, and documentation for **Assignment 02**:

1. **Part A (15%): `PulseGuardAI` (iOS Application)**
   - Native iOS 17+ Swift & SwiftUI Application.
   - **Architecture:** Clean MVVM with `@Observable` and `NavigationStack`.
   - **Emerging Technologies:**
     - **CoreML:** On-device physiological recovery prediction and strain calculation.
     - **MapKit:** Interactive Wellness Radar locating serene parks and recovery clinics.
   - **Data Persistence:** SwiftData (`HealthRecord`) with automatic 7-day history seeding.
   - **Advanced UI/UX:** Custom `AnimatedRingView`, custom `.glassCard()` modifier, 4-7-8 vagus breathing modal, gestures, dark mode, and dynamic type support.
   - **Quality Assurance:** Comprehensive Unit Tests and UI Automation Tests.

2. **Part B (10%): `PulseGuardSpatial` (VisionOS Prototype)**
   - Apple Vision Pro Spatial Computing Application (`visionOS 1.0+`).
   - Features a floating translucent glass dashboard with native `.ornament()` controls.
   - Features an interactive **3D Volumetric Recovery Orb** in physical room coordinates.
   - Features a **Full Immersive Sanctuary** for 432 Hz spatial audio and breathwork.

3. **Documentation:**
   - [Part A iOS Technical Report](Documentation/PartA_iOS_Technical_Report.md)
   - [Part B VisionOS Pitch Deck & Business Strategy](Documentation/PartB_VisionOS_Pitch_Deck.md)
   - [AI-Assisted Development Log](Documentation/AI_Assisted_Development_Log.md)

---

## 🚀 How to Run on Mac with Xcode

### Step 1: Clone Repository
On your Mac, open **Terminal** and clone this repository:
```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
cd "madd assignment 2"
```

### Step 2: Open and Run Part A (iOS App)
1. Double click `PulseGuardAI/PulseGuardAI.xcodeproj` (or open it via Xcode: `File > Open > PulseGuardAI/PulseGuardAI.xcodeproj`).
   *(Alternative: You can also open `PulseGuardAI/Package.swift` directly in Xcode).*
2. In the Xcode scheme selector at the top, choose an **iOS Simulator** (e.g., **iPhone 15 Pro** or **iPhone 16 Pro** with iOS 17+).
3. Press **`Cmd + R`** (or click the **Play** button) to build and run the app.
4. To run tests: Press **`Cmd + U`** in Xcode to run the Unit & UI test suites.

### Step 3: Open and Run Part B (VisionOS App)
1. Double click `PulseGuardSpatial/PulseGuardSpatial.xcodeproj`.
2. Select the **Apple Vision Pro Simulator** (`visionOS 1.0+`).
3. Press **`Cmd + R`** to experience the spatial windows, 3D volumetric orb, and immersive sanctuary.

---

## 📂 Repository Directory Layout

```text
├── PulseGuardAI/                          # Part A: iOS App Project
│   ├── PulseGuardAI.xcodeproj/             # Xcode Project Configuration
│   ├── Package.swift                      # Swift Package Manifest
│   ├── PulseGuardAI/
│   │   ├── App/                           # Entry point & SwiftData container
│   │   ├── Models/                        # HealthRecord, VitalsMetric, WellnessLocation
│   │   ├── ViewModels/                    # Dashboard, Insights, Map ViewModels
│   │   ├── Views/                         # Screens & Custom Components
│   │   ├── Services/                      # CoreML Predictor & SwiftData Manager
│   │   └── Resources/                     # Assets.xcassets & Info.plist
│   ├── PulseGuardAITests/                 # Unit Tests
│   └── PulseGuardAIUITests/               # UI Automation Tests
│
├── PulseGuardSpatial/                     # Part B: VisionOS Prototype Project
│   ├── PulseGuardSpatial.xcodeproj/       # Xcode Project Configuration
│   ├── Package.swift                      # Swift Package Manifest
│   └── PulseGuardSpatial/
│       ├── App/                           # VisionOS Multi-window Entry point
│       ├── Views/                         # Spatial Dashboard, Volumetric, Immersive Views
│       └── Resources/                     # Assets & Info.plist
│
├── Documentation/                         # Technical Reports & Deliverables
│   ├── PartA_iOS_Technical_Report.md
│   ├── PartB_VisionOS_Pitch_Deck.md
│   └── AI_Assisted_Development_Log.md
│
├── .gitignore                             # Configured for Swift/Xcode/macOS
└── README.md                              # Main Project Readme & Instructions
```
