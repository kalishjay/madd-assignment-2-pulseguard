//
//  SpatialDashboardView.swift
//  PulseGuardSpatial
//
//  Created for SE4041 MADD Assignment 2 - Part B (VisionOS).
//

import SwiftUI

/// VisionOS Spatial Dashboard featuring floating glassmorphism panels, ornaments, and gaze-hover effects.
struct SpatialDashboardView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace

    @State private var isImmersiveActive = false
    @State private var recoveryScore: Double = 88.0
    @State private var hrvLevel: Double = 78.0
    @State private var restingHR: Double = 54.0

    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                // Top Spatial Header
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("PulseGuard Spatial")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        Text("Spatial Biometric Intelligence & Nervous System Sanctuary")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()

                    HStack(spacing: 12) {
                        Button {
                            openWindow(id: "VolumetricVitals")
                        } label: {
                            Label("Open 3D Vitals Orb", systemImage: "cube.transparent")
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.teal)

                        Button {
                            Task {
                                if isImmersiveActive {
                                    await dismissImmersiveSpace()
                                    isImmersiveActive = false
                                } else {
                                    let result = await openImmersiveSpace(id: "RelaxationSanctuary")
                                    if case .opened = result {
                                        isImmersiveActive = true
                                    }
                                }
                            }
                        } label: {
                            Label(
                                isImmersiveActive ? "Exit Sanctuary" : "Enter Spatial Sanctuary",
                                systemImage: isImmersiveActive ? "xmark.circle" : "sparkles.tv"
                            )
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)

                // Main Spatial Cards Grid
                HStack(spacing: 24) {
                    // Left Hero Biometric Card
                    VStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .stroke(Color.primary.opacity(0.1), lineWidth: 16)
                                .frame(width: 180, height: 180)

                            Circle()
                                .trim(from: 0.0, to: recoveryScore / 100.0)
                                .stroke(
                                    LinearGradient(colors: [.teal, .green], startPoint: .topLeading, endPoint: .bottomTrailing),
                                    style: StrokeStyle(lineWidth: 16, lineCap: .round)
                                )
                                .rotationEffect(.degrees(-90))
                                .frame(width: 180, height: 180)

                            VStack(spacing: 4) {
                                Text("\(Int(recoveryScore))%")
                                    .font(.system(size: 42, weight: .heavy, design: .rounded))
                                Text("OPTIMAL")
                                    .font(.caption2.bold())
                                    .foregroundStyle(.teal)
                            }
                        }

                        Text("Parasympathetic Dominance")
                            .font(.headline)

                        Text("Resting vitals confirm high physiological readiness for high-demand cognitive workflows.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                    }
                    .padding(24)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .hoverEffect(.highlight)

                    // Right Telemetry & Spatial Sound Control
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Spatial Telemetry & Vagus Feedback")
                            .font(.headline)

                        VStack(spacing: 14) {
                            HStack {
                                Label("Heart Rate Variability", systemImage: "waveform.path.ecg")
                                    .font(.subheadline)
                                Spacer()
                                Text("\(Int(hrvLevel)) ms")
                                    .font(.title3.bold())
                                    .foregroundStyle(.purple)
                            }
                            .padding(14)
                            .background(Color.primary.opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius: 14))

                            HStack {
                                Label("Resting Heart Rate", systemImage: "heart.fill")
                                    .font(.subheadline)
                                Spacer()
                                Text("\(Int(restingHR)) BPM")
                                    .font(.title3.bold())
                                    .foregroundStyle(.red)
                            }
                            .padding(14)
                            .background(Color.primary.opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius: 14))

                            HStack {
                                Label("Spatial Audio Frequency", systemImage: "headphones")
                                    .font(.subheadline)
                                Spacer()
                                Text("432 Hz Solfeggio")
                                    .font(.subheadline.bold())
                                    .foregroundStyle(.teal)
                            }
                            .padding(14)
                            .background(Color.primary.opacity(0.05))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        Spacer()
                    }
                    .padding(24)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .hoverEffect(.highlight)
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            // Bottom Ornament Toolbar for VisionOS
            .ornament(attachmentAnchor: .scene(.bottom)) {
                HStack(spacing: 20) {
                    Button(action: { recoveryScore = min(98, recoveryScore + 2) }) {
                        Label("Re-scan Biometrics", systemImage: "arrow.clockwise")
                    }
                    Divider().frame(height: 24)
                    Button(action: {}) {
                        Label("Spatial Audio Active", systemImage: "speaker.wave.3.fill")
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .glassBackgroundEffect()
            }
        }
    }
}
