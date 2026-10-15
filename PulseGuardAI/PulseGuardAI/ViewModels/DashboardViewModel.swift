//
//  DashboardViewModel.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI
import Observation

/// ViewModel for the main Dashboard view following modern Observation pattern.
@Observable
final class DashboardViewModel {
    var recoveryScore: Double = 86.0
    var recoveryStatus: String = "Optimal"
    var restingHeartRate: Double = 56.0
    var heartRateVariability: Double = 76.0
    var sleepHours: Double = 7.8
    var stepCount: Int = 8940
    var activeCalories: Double = 510.0
    var strainScore: Double = 12.4
    var targetStrain: Double = 14.5

    var isBreathingPresented: Bool = false
    var isSimulatingHeartbeat: Bool = true

    var metrics: [VitalsMetric] {
        [
            VitalsMetric(
                title: "Resting Heart Rate",
                value: "\(Int(restingHeartRate))",
                unit: "BPM",
                icon: "heart.fill",
                iconColor: .red,
                trend: "3 bpm lower than 7d avg",
                isPositive: true
            ),
            VitalsMetric(
                title: "Heart Rate Var. (HRV)",
                value: "\(Int(heartRateVariability))",
                unit: "ms",
                icon: "waveform.path.ecg",
                iconColor: .purple,
                trend: "Higher than baseline (+8ms)",
                isPositive: true
            ),
            VitalsMetric(
                title: "Sleep Architecture",
                value: String(format: "%.1f", sleepHours),
                unit: "Hours",
                icon: "bed.double.fill",
                iconColor: .blue,
                trend: "1h 45m Deep Sleep",
                isPositive: true
            ),
            VitalsMetric(
                title: "Active Step Count",
                value: "\(stepCount)",
                unit: "Steps",
                icon: "figure.walk",
                iconColor: .green,
                trend: "89% of daily 10,000 goal",
                isPositive: true
            )
        ]
    }

    /// Recalculates live recovery using on-device ML predictor
    func refreshMetrics() {
        let prediction = MLRecoveryPredictor.shared.predictRecovery(
            restingHR: restingHeartRate,
            hrv: heartRateVariability,
            sleepHours: sleepHours,
            stressLevel: 3,
            activeCalories: activeCalories
        )
        withAnimation(.spring(response: 0.8, dampingFraction: 0.7)) {
            self.recoveryScore = prediction.score
            self.recoveryStatus = prediction.status
        }
    }
}
