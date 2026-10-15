//
//  HealthRecord.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import Foundation
import SwiftData

/// Represents a persistent daily biometric and recovery record.
/// Utilizes SwiftData for modern on-device persistence.
@Model
final class HealthRecord {
    @Attribute(.unique) var id: UUID
    var date: Date
    var restingHeartRate: Double       // Beats per minute (e.g. 58.0)
    var heartRateVariability: Double   // HRV in milliseconds (e.g. 64.0)
    var sleepHours: Double             // Hours of sleep (e.g. 7.5)
    var stepCount: Int                 // Daily steps (e.g. 8420)
    var activeCalories: Double         // kCal burned (e.g. 450.0)
    var stressLevel: Int               // 1 (Very Calm) to 10 (Extremely Stressed)
    var recoveryScore: Double          // 0 to 100 percentage calculated by CoreML
    var recoveryStatus: String         // "Optimal", "Good", "Moderate", "Needs Rest"
    var notes: String

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        restingHeartRate: Double,
        heartRateVariability: Double,
        sleepHours: Double,
        stepCount: Int,
        activeCalories: Double = 400.0,
        stressLevel: Int = 4,
        recoveryScore: Double = 85.0,
        recoveryStatus: String = "Good",
        notes: String = ""
    ) {
        self.id = id
        self.date = date
        self.restingHeartRate = restingHeartRate
        self.heartRateVariability = heartRateVariability
        self.sleepHours = sleepHours
        self.stepCount = stepCount
        self.activeCalories = activeCalories
        self.stressLevel = stressLevel
        self.recoveryScore = recoveryScore
        self.recoveryStatus = recoveryStatus
        self.notes = notes
    }
}
