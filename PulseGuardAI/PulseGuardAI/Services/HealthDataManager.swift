//
//  HealthDataManager.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import Foundation
import SwiftData

/// Manages SwiftData container lifecycle and provides sample seed data for previews/testing.
@MainActor
final class HealthDataManager {
    static let shared = HealthDataManager()

    let modelContainer: ModelContainer

    private init() {
        do {
            let schema = Schema([HealthRecord.self])
            let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            modelContainer = try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to initialize SwiftData ModelContainer: \(error.localizedDescription)")
        }
    }

    /// Seeds realistic 7-day historical biometric data if the database is empty.
    func seedInitialDataIfNeeded(context: ModelContext) {
        do {
            let descriptor = FetchDescriptor<HealthRecord>()
            let existing = try context.fetch(descriptor)
            guard existing.isEmpty else { return }

            let calendar = Calendar.current
            let now = Date()

            // 7 Days of realistic Apple Watch biometric history
            let samples: [(dayOffset: Int, hr: Double, hrv: Double, sleep: Double, steps: Int, stress: Int, note: String)] = [
                (6, 62.0, 52.0, 6.8, 7400, 5, "Busy work day with meetings"),
                (5, 59.0, 68.0, 7.5, 9200, 3, "Evening jog and relaxing walk"),
                (4, 64.0, 48.0, 6.0, 6100, 7, "Deadlines and late-night study"),
                (3, 56.0, 74.0, 8.2, 10500, 2, "Weekend recovery and outdoor hike"),
                (2, 57.0, 71.0, 7.8, 8900, 3, "Light resistance workout"),
                (1, 60.0, 58.0, 7.0, 8100, 4, "Normal active day"),
                (0, 55.0, 78.0, 8.0, 9400, 2, "Woke up feeling fully refreshed")
            ]

            for sample in samples {
                let date = calendar.date(byAdding: .day, value: -sample.dayOffset, to: now) ?? now
                let prediction = MLRecoveryPredictor.shared.predictRecovery(
                    restingHR: sample.hr,
                    hrv: sample.hrv,
                    sleepHours: sample.sleep,
                    stressLevel: sample.stress,
                    activeCalories: 450
                )

                let record = HealthRecord(
                    date: date,
                    restingHeartRate: sample.hr,
                    heartRateVariability: sample.hrv,
                    sleepHours: sample.sleep,
                    stepCount: sample.steps,
                    activeCalories: 480,
                    stressLevel: sample.stress,
                    recoveryScore: prediction.score,
                    recoveryStatus: prediction.status,
                    notes: sample.note
                )
                context.insert(record)
            }

            try context.save()
        } catch {
            print("Failed to seed initial HealthRecord data: \(error)")
        }
    }
}
