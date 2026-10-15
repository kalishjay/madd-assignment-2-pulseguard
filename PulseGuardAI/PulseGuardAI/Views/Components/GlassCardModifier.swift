//
//  GlassCardModifier.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI

/// Custom ViewModifier that adds an adaptive glassmorphism appearance.
/// Satisfies the "Custom SwiftUI Modifier & Theming" requirement.
struct GlassCardModifier: ViewModifier {
    var cornerRadius: CGFloat = 20
    var padding: CGFloat = 16
    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        content
            .padding(padding)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(colorScheme == .dark ? Material.ultraThinMaterial : Material.regularMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .stroke(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(colorScheme == .dark ? 0.25 : 0.6),
                                        Color.clear
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1.2
                            )
                    )
                    .shadow(
                        color: colorScheme == .dark ? Color.black.opacity(0.3) : Color.gray.opacity(0.15),
                        radius: 12,
                        x: 0,
                        y: 6
                    )
            }
    }
}

/// Pulsing aura effect modifier for live heart rate simulation
struct PulsingAuraModifier: ViewModifier {
    @State private var isPulsing = false
    var color: Color = .red

    func body(content: Content) -> some View {
        content
            .overlay(
                Circle()
                    .stroke(color.opacity(0.35), lineWidth: 3)
                    .scaleEffect(isPulsing ? 1.4 : 1.0)
                    .opacity(isPulsing ? 0.0 : 1.0)
            )
            .onAppear {
                withAnimation(
                    Animation.easeInOut(duration: 1.1)
                        .repeatForever(autoreverses: false)
                ) {
                    isPulsing = true
                }
            }
    }
}

extension View {
    /// Applies a modern iOS glassmorphism card style.
    func glassCard(cornerRadius: CGFloat = 20, padding: CGFloat = 16) -> some View {
        modifier(GlassCardModifier(cornerRadius: cornerRadius, padding: padding))
    }

    /// Applies a rhythmic heartbeat pulsing aura.
    func pulsingAura(color: Color = .red) -> some View {
        modifier(PulsingAuraModifier(color: color))
    }
}
