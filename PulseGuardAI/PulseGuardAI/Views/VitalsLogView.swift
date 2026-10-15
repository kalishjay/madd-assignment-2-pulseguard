//
//  VitalsLogView.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI
import SwiftData
import Charts

/// View for tracking historical biometric logs, viewing Swift Charts trends, and adding new data.
/// Fulfills the "Data Persistence & Testing" requirement using SwiftData.
struct VitalsLogView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \HealthRecord.date, order: .reverse) private var records: [HealthRecord]

    @State private var isAddingRecord = false
    @State private var selectedTrend: TrendMetric = .recovery

    enum TrendMetric: String, CaseIterable, Identifiable {
        case recovery = "Recovery"
        case sleep = "Sleep"
        case hrv = "HRV"
        var id: String { rawValue }
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    // Trend Chart Card
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            Text("7-Day Biometric Trends")
                                .font(.headline)
                            Spacer()
                            Picker("Metric", selection: $selectedTrend) {
                                ForEach(TrendMetric.allCases) { metric in
                                    Text(metric.rawValue).tag(metric)
                                }
                            }
                            .pickerStyle(.segmented)
                            .frame(width: 180)
                        }

                        if records.isEmpty {
                            Text("No historical data available. Tap '+' to record your first entry.")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .frame(height: 160)
                        } else {
                            Chart {
                                ForEach(records.prefix(7).reversed()) { item in
                                    switch selectedTrend {
                                    case .recovery:
                                        LineMark(
                                            x: .value("Date", item.date, unit: .day),
                                            y: .value("Recovery", item.recoveryScore)
                                        )
                                        .foregroundStyle(.teal.gradient)
                                        .interpolationMethod(.catmullRom)

                                        AreaMark(
                                            x: .value("Date", item.date, unit: .day),
                                            y: .value("Recovery", item.recoveryScore)
                                        )
                                        .foregroundStyle(
                                            LinearGradient(
                                                colors: [.teal.opacity(0.3), .clear],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                        .interpolationMethod(.catmullRom)

                                        PointMark(
                                            x: .value("Date", item.date, unit: .day),
                                            y: .value("Recovery", item.recoveryScore)
                                        )
                                        .foregroundStyle(.teal)

                                    case .sleep:
                                        BarMark(
                                            x: .value("Date", item.date, unit: .day),
                                            y: .value("Sleep (Hrs)", item.sleepHours)
                                        )
                                        .foregroundStyle(.blue.gradient)
                                        .cornerRadius(6)

                                    case .hrv:
                                        LineMark(
                                            x: .value("Date", item.date, unit: .day),
                                            y: .value("HRV (ms)", item.heartRateVariability)
                                        )
                                        .foregroundStyle(.purple.gradient)
                                        .interpolationMethod(.monotone)

                                        PointMark(
                                            x: .value("Date", item.date, unit: .day),
                                            y: .value("HRV (ms)", item.heartRateVariability)
                                        )
                                        .foregroundStyle(.purple)
                                    }
                                }
                            }
                            .chartYAxis {
                                AxisMarks(position: .leading)
                            }
                            .frame(height: 180)
                        }
                    }
                    .glassCard(cornerRadius: 22, padding: 18)
                    .padding(.horizontal)

                    // Historical Logs List
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Persisted Telemetry Log")
                                .font(.headline)
                            Spacer()
                            Text("\(records.count) entries")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal)

                        ForEach(records) { record in
                            HStack(spacing: 14) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(record.date.formatted(date: .abbreviated, time: .omitted))
                                        .font(.subheadline.bold())

                                    HStack(spacing: 8) {
                                        Text("HRV: \(Int(record.heartRateVariability))ms")
                                        Text("•")
                                        Text("Sleep: \(String(format: "%.1f", record.sleepHours))h")
                                        Text("•")
                                        Text("HR: \(Int(record.restingHeartRate))bpm")
                                    }
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)

                                    if !record.notes.isEmpty {
                                        Text(record.notes)
                                            .font(.caption2)
                                            .foregroundStyle(.secondary.opacity(0.8))
                                            .lineLimit(1)
                                    }
                                }

                                Spacer()

                                VStack(alignment: .trailing, spacing: 2) {
                                    Text("\(Int(record.recoveryScore))%")
                                        .font(.title3.bold())
                                        .foregroundStyle(record.recoveryScore >= 70 ? .teal : .orange)

                                    Text(record.recoveryStatus)
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .glassCard(cornerRadius: 16, padding: 14)
                            .padding(.horizontal)
                            .contextMenu {
                                Button(role: .destructive) {
                                    deleteRecord(record)
                                } label: {
                                    Label("Delete Entry", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Vitals History")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isAddingRecord = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                            .foregroundStyle(.teal)
                    }
                    .accessibilityLabel("Add New Health Record")
                }
            }
            .sheet(isPresented: $isAddingRecord) {
                AddRecordSheet()
            }
        }
    }

    private func deleteRecord(_ record: HealthRecord) {
        withAnimation {
            modelContext.delete(record)
            try? modelContext.save()
        }
    }
}

/// Modal Sheet to record a new biometric entry and persist it to SwiftData.
struct AddRecordSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var rhr: Double = 60.0
    @State private var hrv: Double = 65.0
    @State private var sleepHours: Double = 7.0
    @State private var steps: String = "8000"
    @State private var stressLevel: Int = 4
    @State private var notes: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Biometric Readings") {
                    HStack {
                        Text("Resting Heart Rate")
                        Spacer()
                        Text("\(Int(rhr)) BPM").bold().foregroundStyle(.red)
                    }
                    Slider(value: $rhr, in: 40...100, step: 1)
                        .tint(.red)

                    HStack {
                        Text("Heart Rate Variability")
                        Spacer()
                        Text("\(Int(hrv)) ms").bold().foregroundStyle(.purple)
                    }
                    Slider(value: $hrv, in: 20...120, step: 1)
                        .tint(.purple)

                    HStack {
                        Text("Sleep Duration")
                        Spacer()
                        Text(String(format: "%.1f hrs", sleepHours)).bold().foregroundStyle(.blue)
                    }
                    Slider(value: $sleepHours, in: 3.0...12.0, step: 0.5)
                        .tint(.blue)
                }

                Section("Daily Activity & Stress") {
                    TextField("Step Count", text: $steps)
                        .keyboardType(.numberPad)

                    Stepper("Stress Level: \(stressLevel)/10", value: $stressLevel, in: 1...10)

                    TextField("Notes (e.g. workout, diet, feel)", text: $notes)
                }
            }
            .navigationTitle("New Biometric Log")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveNewRecord()
                        dismiss()
                    }
                }
            }
        }
    }

    private func saveNewRecord() {
        let stepCount = Int(steps) ?? 7500
        let prediction = MLRecoveryPredictor.shared.predictRecovery(
            restingHR: rhr,
            hrv: hrv,
            sleepHours: sleepHours,
            stressLevel: stressLevel,
            activeCalories: 450
        )

        let newRecord = HealthRecord(
            date: Date(),
            restingHeartRate: rhr,
            heartRateVariability: hrv,
            sleepHours: sleepHours,
            stepCount: stepCount,
            activeCalories: 450,
            stressLevel: stressLevel,
            recoveryScore: prediction.score,
            recoveryStatus: prediction.status,
            notes: notes
        )

        modelContext.insert(newRecord)
        try? modelContext.save()
    }
}
