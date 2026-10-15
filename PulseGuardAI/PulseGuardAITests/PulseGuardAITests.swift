//
//  PulseGuardAITests.swift
//  PulseGuardAITests
//
//  Created for SE4041 MADD Assignment 2.
//

import XCTest
@testable import PulseGuardAI

final class PulseGuardAITests: XCTestCase {

    var predictor: MLRecoveryPredictor!

    override func setUpWithError() throws {
        try super.setUpWithError()
        predictor = MLRecoveryPredictor.shared
    }

    override func tearDownWithError() throws {
        predictor = nil
        try super.tearDownWithError()
    }

    /// Tests that prime biometric inputs yield an 'Optimal' recovery rating (>= 80%)
    func testOptimalBiometricsPrediction() {
        let prediction = predictor.predictRecovery(
            restingHR: 52.0,
            hrv: 82.0,
            sleepHours: 8.5,
            stressLevel: 2,
            activeCalories: 500.0
        )

        XCTAssertGreaterThanOrEqual(prediction.score, 80.0, "Score should reflect optimal recovery for high HRV and low resting HR")
        XCTAssertEqual(prediction.status, "Optimal")
        XCTAssertTrue(prediction.detectedRiskFactors.isEmpty, "Optimal state should not trigger fatigue risk warnings")
        XCTAssertGreaterThan(prediction.cardiovascularStrainLimit, 12.0)
    }

    /// Tests that compromised vitals (high stress, low sleep, depressed HRV) trigger risk warnings
    func testFatiguedBiometricsPrediction() {
        let prediction = predictor.predictRecovery(
            restingHR: 78.0,
            hrv: 30.0,
            sleepHours: 4.5,
            stressLevel: 8,
            activeCalories: 150.0
        )

        XCTAssertLessThan(prediction.score, 50.0, "Compromised vitals should result in moderate or needs rest status")
        XCTAssertFalse(prediction.detectedRiskFactors.isEmpty, "Should identify elevated resting HR and sleep debt")
        XCTAssertTrue(prediction.detectedRiskFactors.contains(where: { $0.contains("HRV") }))
    }

    /// Tests model initialization and boundary validations
    func testHealthRecordInitialization() {
        let record = HealthRecord(
            restingHeartRate: 60.0,
            heartRateVariability: 65.0,
            sleepHours: 7.0,
            stepCount: 8500,
            activeCalories: 450.0,
            stressLevel: 4,
            recoveryScore: 82.0,
            recoveryStatus: "Good",
            notes: "Unit test record"
        )

        XCTAssertEqual(record.restingHeartRate, 60.0)
        XCTAssertEqual(record.stepCount, 8500)
        XCTAssertEqual(record.recoveryStatus, "Good")
        XCTAssertFalse(record.id.uuidString.isEmpty)
    }
}
