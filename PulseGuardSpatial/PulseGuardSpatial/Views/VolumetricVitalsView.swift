//
//  VolumetricVitalsView.swift
//  PulseGuardSpatial
//
//  Created for SE4041 MADD Assignment 2 - Part B (VisionOS).
//

import SwiftUI

/// Volumetric 3D window displaying a dynamic physiological orb in 3D space.
struct VolumetricVitalsView: View {
    @State private var rotationAngle: Double = 0.0
    @State private var pulseScale: CGFloat = 1.0

    var body: some View {
        ZStack {
            // 3D Visual Volumetric Core
            ForEach(0..<4) { index in
                Circle()
                    .stroke(
                        LinearGradient(
                            colors: [.teal, .cyan, .indigo, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 4
                    )
                    .frame(width: 200 + CGFloat(index * 25), height: 200 + CGFloat(index * 25))
                    .rotation3DEffect(
                        .degrees(rotationAngle + Double(index * 45)),
                        axis: (x: 1.0, y: Double(index) * 0.5, z: 0.5)
                    )
            }

            VStack(spacing: 8) {
                Image(systemName: "bolt.heart.fill")
                    .font(.system(size: 40))
                    .foregroundStyle(.teal)
                    .scaleEffect(pulseScale)

                Text("88% Recovery")
                    .font(.title2.bold())
                    .foregroundStyle(.white)

                Text("Floating 3D Volumetric Pod")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(40)
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                rotationAngle = 360.0
            }
            withAnimation(.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                pulseScale = 1.15
            }
        }
    }
}
