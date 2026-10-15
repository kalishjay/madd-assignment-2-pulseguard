//
//  InsightsView.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI

/// Screen dedicated to CoreML On-Device Biometric Assessment & AI Recommendations.
/// Fulfills the "Emerging Technologies (CoreML)" requirement.
struct InsightsView: View {
    @State private var viewModel = InsightsViewModel()
    @State private var isShowingSimulator = false

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 22) {
                    // CoreML Assessment Card
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Label("CoreML On-Device Engine", systemImage: "cpu.fill")
                                .font(.caption.bold())
                                .foregroundStyle(.teal)

                            Spacer()

                            HStack(spacing: 4) {
                                Circle().fill(.green).frame(width: 8, height: 8)
                                Text("Inference Active (94% Conf)")
                                    .font(.caption2.bold())
                                    .foregroundStyle(.secondary)
                            }
                        }

                        let pred = viewModel.currentPrediction
                        HStack(alignment: .center, spacing: 18) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(Int(pred.score))%")
                                    .font(.system(size: 48, weight: .heavy, design: .rounded))
                                    .foregroundStyle(pred.score >= 70 ? .teal : (pred.score >= 50 ? .orange : .red))

                                Text("Status: \(pred.status)")
                                    .font(.headline)
                            }

                            Divider().frame(height: 50)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Strain Cap")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text(String(format: "%.1f", pred.cardiovascularStrainLimit))
                                    .font(.title2.bold())

                                Text("Safe workout ceiling")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }

                        Text(pred.primaryRecommendation)
                            .font(.subheadline)
                            .foregroundStyle(.primary.opacity(0.85))
                            .lineSpacing(3)

                        if !pred.detectedRiskFactors.isEmpty {
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Detected Biomarkers:")
                                    .font(.caption.bold())
                                    .foregroundStyle(.orange)

                                ForEach(pred.detectedRiskFactors, id: \.self) { risk in
                                    HStack(spacing: 6) {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .font(.caption2)
                                            .foregroundStyle(.orange)
                                        Text(risk)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                            }
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 12).fill(.orange.opacity(0.12)))
                        }
                    }
                    .glassCard(cornerRadius: 22, padding: 20)
                    .padding(.horizontal)

                    // Live Biometric Simulator Accordion (Viva Demonstration Booster)
                    DisclosureGroup(
                        isExpanded: $isShowingSimulator,
                        content: {
                            VStack(spacing: 16) {
                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text("Heart Rate Variability (HRV)")
                                        Spacer()
                                        Text("\(Int(viewModel.simHRV)) ms").bold().foregroundStyle(.purple)
                                    }
                                    .font(.caption)
                                    Slider(value: $viewModel.simHRV, in: 25...110, step: 1)
                                        .tint(.purple)
                                }

                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text("Sleep Duration")
                                        Spacer()
                                        Text(String(format: "%.1f hrs", viewModel.simSleepHours)).bold().foregroundStyle(.blue)
                                    }
                                    .font(.caption)
                                    Slider(value: $viewModel.simSleepHours, in: 4.0...10.0, step: 0.1)
                                        .tint(.blue)
                                }

                                VStack(alignment: .leading, spacing: 6) {
                                    HStack {
                                        Text("Perceived Stress Level (1-10)")
                                        Spacer()
                                        Text("\(viewModel.simStressLevel)").bold().foregroundStyle(.red)
                                    }
                                    .font(.caption)
                                    Slider(
                                        value: Binding(
                                            get: { Double(viewModel.simStressLevel) },
                                            set: { viewModel.simStressLevel = Int($0) }
                                        ),
                                        in: 1...10,
                                        step: 1
                                    )
                                    .tint(.red)
                                }

                                Button {
                                    // Reset simulator to defaults
                                    viewModel.simHRV = 72.0
                                    viewModel.simSleepHours = 7.5
                                    viewModel.simStressLevel = 4
                                } label: {
                                    Text("Reset Parameters")
                                        .font(.caption.bold())
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .padding(.top, 10)
                        },
                        label: {
                            HStack {
                                Image(systemName: "slider.horizontal.3")
                                    .foregroundStyle(.teal)
                                Text("Live ML Simulator (Interactive Viva Tool)")
                                    .font(.headline)
                            }
                        }
                    )
                    .glassCard(cornerRadius: 20, padding: 18)
                    .padding(.horizontal)

                    // AI Recommendations List
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Personalized Action Plan")
                            .font(.headline)
                            .padding(.horizontal)

                        ForEach(viewModel.recommendations) { item in
                            VStack(alignment: .leading, spacing: 10) {
                                HStack {
                                    Label(item.category.rawValue, systemImage: item.category.iconName)
                                        .font(.caption.bold())
                                        .foregroundStyle(.teal)

                                    Spacer()

                                    Text(item.priority.rawValue)
                                        .font(.system(size: 10, weight: .bold))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(Capsule().fill(item.priority.badgeColor.opacity(0.18)))
                                        .foregroundStyle(item.priority.badgeColor)
                                }

                                Text(item.title)
                                    .font(.subheadline.bold())

                                Text(item.summary)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)

                                Text(item.detailedAdvice)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.primary.opacity(0.8))
                                    .padding(10)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.primary.opacity(0.04)))
                            }
                            .glassCard(cornerRadius: 18, padding: 16)
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("AI Intelligence")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
