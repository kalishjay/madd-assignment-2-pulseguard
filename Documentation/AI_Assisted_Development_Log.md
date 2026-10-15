# AI-Assisted Development Log & Audit Trail
**Course:** SE4041 – Mobile Application Design and Development (MADD)  
**Academic Term:** Year 4 Semester 2, 2026  
**Assignment:** Assignment 02 – Native Swift & SwiftUI Development  
**Student ID:** IT22550330  
**Student Name:** Jayasinghe I.B.K.S  
**AI Assistant Employed:** Google DeepMind Advanced Agentic Assistant  

---

## 1. Overview & Policy Compliance
As mandated by the SE4041 Assignment 02 specification:
> *"If you use AI tools like GitHub Copilot or ChatGPT, document the interactions, including prompts and responses, and explain how they assisted your development process."*

This log provides full transparency on all interactions, architectural prompts, algorithmic syntheses, and manual reviews performed throughout the project lifecycle.

---

## 2. Prompt History & Technical Reflections

### Interaction 1: Assignment Rubric & Cross-Platform Feasibility
* **User Prompt:**  
  *"firstly me assignment eka hodt analyze krnna. and meka ios sambanda app ekak hadana thiyenne. but mn gawa thiyenne windows lap ekak. e nisa n dn krnna hadanne mage windows lap eken code karala. build eka mac lap ekakin krnna. e nisa ee widiht karanna awashya de oya ptan ganna. i think apit e code tika github ekt push karala mac eken open karagena build eka xcode ekka krnna puluwanne."*
* **AI Assistance & Solution:**  
  Analyzed the 25% assignment scope (Part A: 15% iOS, Part B: 10% VisionOS). Confirmed that cross-platform authoring on Windows followed by Git push and Xcode compilation on macOS is an industry-standard workflow. Recommended organizing clean `.xcodeproj`, `.swift` files, and asset catalogs.

### Interaction 2: Concept Formulation & Emerging Tech Selection
* **User Prompt:**  
  *"new concept and continue"*
* **AI Assistance & Solution:**  
  Conceived **PulseGuard AI** (iOS) and **PulseGuard Spatial** (VisionOS). Selected Apple **CoreML** (for on-device physiological recovery prediction) and **MapKit** (for wellness radar discovery) along with **SwiftData** for offline persistence.

### Interaction 3: Architectural Architecture & Swift Implementation
* **Design Formulation:**  
  Synthesized modern MVVM pattern using iOS 17 `@Observable` framework. Authored:
  1. `HealthRecord.swift` with SwiftData `@Model`.
  2. `MLRecoveryPredictor.swift` implementing autonomic heart rate variability & recovery heuristics.
  3. Custom UI modifiers (`GlassCardModifier.swift`, `PulsingAuraModifier`).
  4. Custom components (`AnimatedRingView.swift`, `BreathingExerciseView.swift`).
  5. Interactive viva tools (`InsightsView.swift` real-time ML parameter simulator).

### Interaction 4: VisionOS Spatial Architecture
* **Design Formulation:**  
  Created `PulseGuardSpatialApp.swift` implementing:
  1. `WindowGroup` with `.windowStyle(.plain)` and `.ornament()` toolbar.
  2. 3D Volumetric window (`.windowStyle(.volumetric)`).
  3. Immersive space (`ImmersiveSpace`) for spatial meditation.

---

## 3. Student Evaluation & Reflection on AI Assistance
The AI assistant accelerated boilerplate creation, mathematical modeling for the recovery algorithms, and project schema synthesis. All logic was reviewed to ensure compliance with Apple's Human Interface Guidelines (HIG), dark mode accessibility, and memory safety standards.
