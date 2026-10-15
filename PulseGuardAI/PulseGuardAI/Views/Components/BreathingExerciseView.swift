//
//  BreathingExerciseView.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI

/// Guided 4-7-8 Parasympathetic Recovery Breathing modal with custom spring animations.
struct BreathingExerciseView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var breathingState: BreathingPhase = .inhale
    @State private var scaleCircle: CGFloat = 0.5
    @State private var timerCount: Int = 4
    @State private var isActive: Bool = true
    @State private var completedCycles: Int = 0

    enum BreathingPhase: String {
        case inhale = "Inhale deeply through nose..."
        case hold = "Hold breath gently..."
        case exhale = "Slowly exhale through mouth..."

        var duration: Double {
            switch self {
            case .inhale: return 4.0
            case .hold: return 7.0
            case .exhale: return 8.0
            }
        }

        var targetScale: CGFloat {
            switch self {
            case .inhale: return 1.0
            case .hold: return 1.0
            case .exhale: return 0.5
            }
        }
    }

    var body: some View {
        ZStack {
            // Ambient Gradient Background
            LinearGradient(
                colors: [Color.indigo.opacity(0.8), Color.black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 36) {
                // Header Bar with Drag Dismissal Indicator
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Parasympathetic Reset")
                            .font(.title2.bold())
                            .foregroundStyle(.white)
                        Text("4-7-8 Vagus Nerve Stimulation")
                            .font(.caption)
                            .foregroundStyle(.white.opacity(0.7))
                    }

                    Spacer()

                    Button {
                        isActive = false
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
                .padding(.horizontal)

                Spacer()

                // Animated Visual Breathing Circle
                ZStack {
                    // Outer Ripple Circles
                    ForEach(0..<3) { index in
                        Circle()
                            .stroke(Color.teal.opacity(0.2 - Double(index) * 0.05), lineWidth: 2)
                            .frame(width: 260 + CGFloat(index * 40), height: 260 + CGFloat(index * 40))
                            .scaleEffect(scaleCircle)
                    }

                    // Main Pulsing Core
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [Color.teal, Color.cyan.opacity(0.5), Color.clear],
                                center: .center,
                                startRadius: 10,
                                endRadius: 140
                            )
                        )
                        .frame(width: 220, height: 220)
                        .scaleEffect(scaleCircle)
                        .animation(.easeInOut(duration: breathingState.duration), value: scaleCircle)

                    // Timer Display inside circle
                    VStack(spacing: 6) {
                        Text("\(timerCount)")
                            .font(.system(size: 64, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)

                        Text("Seconds")
                            .font(.caption.bold())
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
                .gesture(
                    TapGesture()
                        .onEnded {
                            // Interactive gesture: Tap to restart cycle
                            startBreathingCycle()
                        }
                )

                Spacer()

                // Bottom Guidance and Cycle Counter
                VStack(spacing: 12) {
                    Text(breathingState.rawValue)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                        .animation(.easeInOut, value: breathingState)

                    Text("Completed Cycles: \(completedCycles)")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.6))
                }
                .padding(.bottom, 30)
            }
            .padding(.top, 24)
        }
        .onAppear {
            startBreathingCycle()
        }
    }

    private func startBreathingCycle() {
        guard isActive else { return }

        // Phase 1: Inhale (4s)
        breathingState = .inhale
        scaleCircle = BreathingPhase.inhale.targetScale
        runCountdown(from: 4) {
            guard isActive else { return }
            // Phase 2: Hold (7s)
            breathingState = .hold
            scaleCircle = BreathingPhase.hold.targetScale
            runCountdown(from: 7) {
                guard isActive else { return }
                // Phase 3: Exhale (8s)
                breathingState = .exhale
                scaleCircle = BreathingPhase.exhale.targetScale
                runCountdown(from: 8) {
                    guard isActive else { return }
                    completedCycles += 1
                    startBreathingCycle()
                }
            }
        }
    }

    private func runCountdown(from seconds: Int, completion: @escaping () -> Void) {
        timerCount = seconds
        var current = seconds
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if !isActive {
                timer.invalidate()
                return
            }
            current -= 1
            if current >= 1 {
                timerCount = current
            } else {
                timer.invalidate()
                completion()
            }
        }
    }
}
