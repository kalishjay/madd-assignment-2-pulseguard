//
//  WellnessLocation.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import Foundation
import CoreLocation

/// Model for MapKit location annotations (parks, wellness clinics, meditation centers).
struct WellnessLocation: Identifiable {
    let id = UUID()
    let name: String
    let category: LocationCategory
    let coordinate: CLLocationCoordinate2D
    let address: String
    let rating: Double
    let openHours: String

    enum LocationCategory: String, CaseIterable, Identifiable {
        case park = "Serene Parks"
        case clinic = "Health Clinics"
        case meditation = "Meditation & Yoga"
        case sports = "Fitness Hubs"

        var id: String { rawValue }

        var icon: String {
            switch self {
            case .park: return "tree.fill"
            case .clinic: return "cross.case.fill"
            case .meditation: return "figure.mind.and.body"
            case .sports: return "figure.run"
            }
        }
    }
}
