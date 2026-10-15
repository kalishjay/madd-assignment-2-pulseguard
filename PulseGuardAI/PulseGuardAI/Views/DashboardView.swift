//
//  DashboardView.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI

/// Main Dashboard Screen displaying live biometric gauges and recovery summary.
struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()
    @State private var dragOffset: CGSize = .zero

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    // Header Status
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Welcome back,")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("Daily Vitals Guardian")
                                .font(.title.bold())
                        }
                        Spacer()
                        Button {
                            viewModel.refreshMetrics()
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.title3.bold())
                                .foregroundStyle(.teal)
                                .padding(10)
                                .background(Circle().fill(.teal.opacity(0.12)))
                        }
                        .accessibilityLabel("Refresh Recovery Prediction")
                    }
                    .padding(.horizontal)

                    // Hero Animated Recovery Ring Card
                    VStack(spacing: 16) {
                        AnimatedRingView(
                            progress: viewModel.recoveryScore / 100.0,
                            scoreText: "\(Int(viewModel.recoveryScore))%",
                            statusText: viewModel.recoveryStatus,
                            ringDiameter: 210,
                            strokeWidth: 20
                        )
                        .padding(.vertical, 8)

                        // Cardiovascular Strain Target Bar
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Cardiovascular Strain Target")
                                    .font(.caption.bold())
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Text(String(format: "%.1f / %.1f", viewModel.strainScore, viewModel.targetStrain))
                                    .font(.caption.bold())
                                    .foregroundStyle(.teal)
                            }

                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Capsule()
                                        .fill(Color.primary.opacity(0.08))
                                        .frame(height: 10)

                                    Capsule()
                                        .fill(LinearGradient(colors: [.teal, .blue], startPoint: .leading, endPoint: .trailing))
                                        .frame(width: geo.size.width * CGFloat(viewModel.strainScore / viewModel.targetStrain), height: 10)
                                }
                            }
                            .frame(height: 10)
                        }
                        .padding(.horizontal, 12)
                    }
                    .glassCard(cornerRadius: 24, padding: 20)
                    .padding(.horizontal)
                    .offset(x: dragOffset.width * 0.1)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                dragOffset = gesture.translation
                            }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    dragOffset = .zero
                                }
                            }
                    )

                    // Quick Action: Guided Breathing
                    Button {
                        viewModel.isBreathingPresented = true
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: "lungs.fill")
                                .font(.title2)
                                .foregroundStyle(.white)
                                .padding(10)
                                .background(Circle().fill(.white.opacity(0.2)))

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Reduce Acute Stress")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text("Launch 4-7-8 Guided Vagus Nerve Reset")
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.8))
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.white.opacity(0.8))
                        }
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color.indigo, Color.teal],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .shadow(color: .indigo.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $viewModel.isBreathingPresented) {
                        BreathingExerciseView()
                    }

                    // Biometrics Grid
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Today's Biometric Telemetry")
                            .font(.headline)
                            .padding(.horizontal)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 14) {
                            ForEach(viewModel.metrics) { metric in
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Image(systemName: metric.icon)
                                            .font(.title3)
                                            .foregroundStyle(metric.iconColor)
                                        Spacer()
                                        Image(systemName: metric.isPositive ? "arrow.up.right" : "arrow.down.right")
                                            .font(.caption2.bold())
                                            .foregroundStyle(metric.isPositive ? .green : .orange)
                                    }

                                    VStack(alignment: .leading, spacing: 2) {
                                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                                            Text(metric.value)
                                                .font(.system(size: 26, weight: .bold, design: .rounded))
                                            Text(metric.unit)
                                                .font(.caption.bold())
                                                .foregroundStyle(.secondary)
                                        }

                                        Text(metric.title)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }

                                    Text(metric.trend)
                                        .font(.system(size: 10, weight: .medium))
                                        .foregroundStyle(.secondary)
                                        .lineLimit(1)
                                }
                                .glassCard(cornerRadius: 18, padding: 14)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("PulseGuard AI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
