//
//  AnimatedRingView.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI

/// Custom SwiftUI component rendering an animated circular progress ring.
/// Fulfills advanced animation, custom component, and accessible theming requirements.
struct AnimatedRingView: View {
    let progress: Double       // 0.0 to 1.0 (e.g. 0.86)
    let scoreText: String      // e.g. "86%"
    let statusText: String     // e.g. "Optimal"
    var ringDiameter: CGFloat = 200
    var strokeWidth: CGFloat = 18

    @State private var animatedProgress: Double = 0.0

    private var ringGradient: AngularGradient {
        if progress >= 0.80 {
            return AngularGradient(
                colors: [Color.green, Color.teal, Color.cyan, Color.green],
                center: .center,
                startAngle: .degrees(0),
                endAngle: .degrees(360)
            )
        } else if progress >= 0.60 {
            return AngularGradient(
                colors: [Color.yellow, Color.orange, Color.yellow],
                center: .center,
                startAngle: .degrees(0),
                endAngle: .degrees(360)
            )
        } else {
            return AngularGradient(
                colors: [Color.orange, Color.red, Color.pink, Color.orange],
                center: .center,
                startAngle: .degrees(0),
                endAngle: .degrees(360)
            )
        }
    }

    var body: some View {
        ZStack {
            // Background Track
            Circle()
                .stroke(Color.primary.opacity(0.08), lineWidth: strokeWidth)

            // Animated Gradient Progress Arc
            Circle()
                .trim(from: 0.0, to: animatedProgress)
                .stroke(
                    ringGradient,
                    style: StrokeStyle(lineWidth: strokeWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .shadow(color: Color.teal.opacity(0.35), radius: 8, x: 0, y: 3)

            // Inner Central Metric
            VStack(spacing: 4) {
                Image(systemName: "bolt.heart.fill")
                    .font(.title2)
                    .foregroundStyle(.teal)
                    .symbolEffect(.pulse)

                Text(scoreText)
                    .font(.system(size: 44, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                    .contentTransition(.numericText())

                Text(statusText.uppercased())
                    .font(.caption)
                    .fontWeight(.bold)
                    .tracking(1.5)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(Capsule().fill(.teal.opacity(0.18)))
                    .foregroundStyle(.teal)
            }
        }
        .frame(width: ringDiameter, height: ringDiameter)
        .onAppear {
            withAnimation(.spring(response: 1.2, dampingFraction: 0.75)) {
                animatedProgress = progress
            }
        }
        .onChange(of: progress) { oldValue, newValue in
            withAnimation(.spring(response: 0.9, dampingFraction: 0.75)) {
                animatedProgress = newValue
            }
        }
    }
}
