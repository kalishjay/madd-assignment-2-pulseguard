//
//  ImmersiveRelaxationView.swift
//  PulseGuardSpatial
//
//  Created for SE4041 MADD Assignment 2 - Part B (VisionOS).
//

import SwiftUI

/// Full Immersive Space for VisionOS transporting the user to a peaceful 3D spatial meditation environment.
struct ImmersiveRelaxationView: View {
    @State private var sphereExpansion: CGFloat = 0.8
    @State private var breathingPrompt = "Inhale serenity..."

    var body: some View {
        ZStack {
            // Ambient 3D Spatial Particles and Glowing Atmosphere
            ForEach(0..<12) { i in
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [.teal.opacity(0.4), .indigo.opacity(0.1), .clear],
                            center: .center,
                            startRadius: 20,
                            endRadius: 180
                        )
                    )
                    .frame(width: 300, height: 300)
                    .offset(
                        x: CGFloat(cos(Double(i) * .pi / 6) * 350),
                        y: CGFloat(sin(Double(i) * .pi / 6) * 220)
                    )
                    .scaleEffect(sphereExpansion)
            }

            // Central Spatial Mindfulness Focus
            VStack(spacing: 20) {
                Text(breathingPrompt)
                    .font(.system(size: 40, weight: .light, design: .serif))
                    .foregroundStyle(.white)
                    .shadow(radius: 12)

                Text("Apple Vision Pro Spatial Soundstage (432Hz Binaural Ambient)")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 4.5).repeatForever(autoreverses: true)) {
                sphereExpansion = 1.3
            }
        }
    }
}
