# PulseGuard Spatial — Innovative VisionOS Application
## Investor & Academic Pitch Presentation / Business Deck
**Course:** SE4041 – Mobile Application Design and Development (MADD)  
**Academic Term:** Year 4 Semester 2, 2026  
**Assignment:** Assignment 02 – Part B: VisionOS / tvOS Innovation (10% Marks)  
**Platform:** Apple Vision Pro (`VisionOS 1.0+`)  
**Student ID:** IT22550330  
**Student Name:** Jayasinghe I.B.K.S  

---

## 1. Value Proposition & Vision
In 2D mobile screens, users consume wellness data flatly, often feeling detached from their true physiological state. **PulseGuard Spatial** reimagines stress reduction and biometric analytics by harnessing **Apple Vision Pro's Spatial Computing** paradigm.

Instead of staring at numbers on a glass phone screen:
1. Your autonomic nervous system status floats as a **3D Volumetric Living Orb** alongside your active macOS virtual desktop.
2. When acute stress or cognitive fatigue spikes, one tap opens an **Immersive Spatial Sanctuary**—enveloping the user's room with 432 Hz Solfeggio spatial audio and volumetric ambient light pulses synchronized to the user's heart rhythm.

---

## 2. Competitive Analysis & Market Differentiation

| Feature / Metric | Conventional Apps (Headspace, Calm) | Apple Health / Fitness | PulseGuard Spatial (Our Prototype) |
|---|---|---|---|
| **Form Factor** | 2D Mobile / Tablet Screens | 2D Apple Watch / iPhone | Native 3D Spatial Computing (VisionOS) |
| **Multitasking** | Locks user into full-screen video | Passive background logging | Floating Volumetric Orb anchored in physical workspace |
| **Sensory Immersion** | Audio only | Haptic notifications | Spatial Audio + 360° Volumetric Light Fields |
| **Real-time ANS Feedback** | None | Raw HRV graphs | Live 3D Orb color shifting with vagus nerve tone |

---

## 3. Spatial Computing Architecture & Prototype Capabilities

### 3.1 Three Core Platform Modalities:
1. **Plain Spatial Window (`SpatialDashboardView`):**
   - Translucent floating 900x640 window using `.regularMaterial` and `.glassBackgroundEffect()`.
   - Uses native VisionOS `.ornament()` attached to the bottom scene bar for frictionless tool access.
   - Responds to Gaze and Pinch input gestures with dynamic `.hoverEffect(.highlight)`.
2. **Volumetric 3D Window (`VolumetricVitalsView`):**
   - A $0.5\text{m} \times 0.5\text{m} \times 0.5\text{m}$ spatial volume floating in the user's physical room.
   - Multi-axis rotating gyroscopic particle rings that adjust rotation speed and glow color dynamically based on autonomic recovery levels.
3. **Full Immersive Space (`ImmersiveRelaxationView`):**
   - Engages progressive and full immersion styles via `ImmersiveSpace(id: "RelaxationSanctuary")`.
   - Transports the user into a calming 3D cosmic sanctuary designed for 4-7-8 deep parasympathetic breathwork.

---

## 4. Business & Revenue Model

### 4.1 Monetization Pillars:
1. **B2C Freemium Model:**
   - *Free Tier:* Floating Spatial Dashboard & basic recovery scores.
   - *PulseGuard Pro (\$9.99/mo or \$79/yr):* Unlimited access to 3D Volumetric Orbs, curated binaural spatial soundscapes, and advanced CoreML predictive forecasting.
2. **B2B Enterprise Wellbeing Licensing:**
   - Targeted at high-stress corporate desks, trading floors, and creative studios adopting Apple Vision Pro.
   - Team burnout analytics and collective mindfulness sessions.

---

## 5. Go-To-Market (GTM) Strategy
* **Phase 1 (Q1 2027):** Launch on visionOS App Store targeting early tech adopters, executives, and biohackers.
* **Phase 2 (Q2 2027):** Strategic partnerships with corporate wellness programs, boutique yoga/meditation studios, and remote tech companies.
* **Phase 3 (Q3 2027):** Bi-directional spatial sync between iPhone (PulseGuard AI) and Apple Vision Pro (PulseGuard Spatial) using iCloud and SwiftData CloudKit.

---

## 6. Viva Demonstration Script (Guidance for Defense)
1. **Opening Hook:** *"Judges, while mobile apps tell you that you're stressed, PulseGuard Spatial transforms your actual physical environment into a sanctuary that heals your stress."*
2. **Feature Demo 1:** Demonstrate the translucent `SpatialDashboardView` floating seamlessly with natural gaze hover effects.
3. **Feature Demo 2:** Launch the 3D Volumetric Orb (`VolumetricVitalsView`) and show how it rotates in 3D spatial coordinates without blocking other work.
4. **Feature Demo 3:** Step into the `ImmersiveRelaxationView` and explain how spatial audio and breathing visualizers stimulate vagus nerve recovery.
