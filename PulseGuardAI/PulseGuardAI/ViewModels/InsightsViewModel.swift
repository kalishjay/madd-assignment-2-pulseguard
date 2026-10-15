//
//  InsightsViewModel.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI
import Observation

/// ViewModel for CoreML Insights, AI Simulation & Recommendations.
@Observable
final class InsightsViewModel {
    // Interactive Simulation Variables
    var simRestingHR: Double = 58.0
    var simHRV: Double = 72.0
    var simSleepHours: Double = 7.5
    var simStressLevel: Int = 4
    var simActiveCalories: Double = 450.0

    // Computed ML Output
    var currentPrediction: MLRecoveryPrediction {
        MLRecoveryPredictor.shared.predictRecovery(
            restingHR: simRestingHR,
            hrv: simHRV,
            sleepHours: simSleepHours,
            stressLevel: simStressLevel,
            activeCalories: simActiveCalories
        )
    }

    // Dynamic AI Recommendations
    var recommendations: [RecoveryInsight] {
        var list: [RecoveryInsight] = [
            RecoveryInsight(
                category: .recovery,
                title: "Optimal Priming Window",
                summary: "Your central nervous system demonstrates high readiness for peak exertion.",
                detailedAdvice: "Schedule complex cognitive work and high-intensity strength sets between 10:00 AM and 2:00 PM.",
                priority: .optimal,
                timestamp: Date()
            ),
            RecoveryInsight(
                category: .sleep,
                title: "Circadian Alignment",
                summary: "Consistent sleep onset over past 3 nights improved HRV by 12%.",
                detailedAdvice: "Limit blue-light exposure 45 minutes prior to bed to preserve REM cycle percentage.",
                priority: .optimal,
                timestamp: Date().addingTimeInterval(-3600)
            )
        ]

        if simStressLevel >= 6 {
            list.insert(
                RecoveryInsight(
                    category: .mentalWellness,
                    title: "Elevated Cortisol Warning",
                    summary: "High stress markers detected. Parasympathetic activation recommended.",
                    detailedAdvice: "Engage in a 4-7-8 resonance breathing session before your next focused block.",
                    priority: .high,
                    timestamp: Date()
                ),
                at: 0
            )
        }

        if simSleepHours < 6.5 {
            list.append(
                RecoveryInsight(
                    category: .sleep,
                    title: "Accumulated Sleep Debt",
                    summary: "Recorded sleep duration is below your personal baseline requirement of 7.5h.",
                    detailedAdvice: "Consider a 20-minute power nap before 3:00 PM to offset cognitive lag.",
                    priority: .moderate,
                    timestamp: Date().addingTimeInterval(-7200)
                )
            )
        }

        return list
    }
}
