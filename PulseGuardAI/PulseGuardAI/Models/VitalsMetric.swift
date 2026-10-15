//
//  VitalsMetric.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI

/// Defines a quick vitals card metric for the dashboard.
struct VitalsMetric: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let unit: String
    let icon: String
    let iconColor: Color
    let trend: String
    let isPositive: Bool
}

/// Represents an AI health recommendation or insight.
struct RecoveryInsight: Identifiable {
    let id = UUID()
    let category: InsightCategory
    let title: String
    let summary: String
    let detailedAdvice: String
    let priority: InsightPriority
    let timestamp: Date

    enum InsightCategory: String, CaseIterable {
        case recovery = "Recovery"
        case sleep = "Sleep Architecture"
        case cardiovascular = "Heart & HRV"
        case strain = "Activity & Strain"
        case mentalWellness = "Stress & Mindfulness"

        var iconName: String {
            switch self {
            case .recovery: return "bolt.heart.fill"
            case .sleep: return "bed.double.fill"
            case .cardiovascular: return "waveform.path.ecg"
            case .strain: return "flame.fill"
            case .mentalWellness: return "brain.head.profile"
            }
        }
    }

    enum InsightPriority: String {
        case high = "High Attention"
        case moderate = "Moderate"
        case optimal = "Optimal"

        var badgeColor: Color {
            switch self {
            case .high: return .red
            case .moderate: return .orange
            case .optimal: return .green
            }
        }
    }
}
