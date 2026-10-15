//
//  MapViewModel.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI
import MapKit
import Observation

/// ViewModel managing MapKit interactive locations and categories.
@Observable
final class MapViewModel {
    var selectedCategory: WellnessLocation.LocationCategory = .park
    var selectedLocation: WellnessLocation?

    // Default map camera positioned over a scenic wellness & health cluster (e.g., Colombo / Viharamahadevi area or Central Park)
    var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 6.9147, longitude: 79.8612),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    // Curated wellness spots for physical and mental recovery
    var allLocations: [WellnessLocation] = [
        WellnessLocation(
            name: "Viharamahadevi Botanical Park",
            category: .park,
            coordinate: CLLocationCoordinate2D(latitude: 6.9147, longitude: 79.8612),
            address: "Albert Crescent, Cinnamon Gardens",
            rating: 4.8,
            openHours: "06:00 AM - 08:00 PM"
        ),
        WellnessLocation(
            name: "Independence Square Walking Track",
            category: .park,
            coordinate: CLLocationCoordinate2D(latitude: 6.9034, longitude: 79.8678),
            address: "Independence Avenue, Colombo 07",
            rating: 4.9,
            openHours: "Open 24 Hours"
        ),
        WellnessLocation(
            name: "Diyatha Uyana Lakeside Trail",
            category: .park,
            coordinate: CLLocationCoordinate2D(latitude: 6.9015, longitude: 79.9168),
            address: "Sri Jayawardenepura Kotte",
            rating: 4.7,
            openHours: "05:30 AM - 10:00 PM"
        ),
        WellnessLocation(
            name: "Asiri Central Sports Recovery Unit",
            category: .clinic,
            coordinate: CLLocationCoordinate2D(latitude: 6.9240, longitude: 79.8685),
            address: "114 Norris Canal Road, Colombo 10",
            rating: 4.8,
            openHours: "24/7 Emergency & Recovery"
        ),
        WellnessLocation(
            name: "Nawaloka Wellness & Physiotherapy",
            category: .clinic,
            coordinate: CLLocationCoordinate2D(latitude: 6.9221, longitude: 79.8540),
            address: "23 Deshamanya H K Dharmadasa Mw",
            rating: 4.6,
            openHours: "07:00 AM - 09:00 PM"
        ),
        WellnessLocation(
            name: "Prana Lounge Yoga & Meditation",
            category: .meditation,
            coordinate: CLLocationCoordinate2D(latitude: 6.8992, longitude: 79.8631),
            address: "60 Horton Place, Colombo 07",
            rating: 4.9,
            openHours: "06:30 AM - 07:30 PM"
        ),
        WellnessLocation(
            name: "Zenith Mindfulness Sanctuary",
            category: .meditation,
            coordinate: CLLocationCoordinate2D(latitude: 6.9110, longitude: 79.8700),
            address: "Barnes Place, Colombo 07",
            rating: 4.7,
            openHours: "07:00 AM - 08:00 PM"
        ),
        WellnessLocation(
            name: "The Fitness Hub Colombo",
            category: .sports,
            coordinate: CLLocationCoordinate2D(latitude: 6.9080, longitude: 79.8550),
            address: "Galle Road, Kollupitiya",
            rating: 4.7,
            openHours: "05:00 AM - 11:00 PM"
        )
    ]

    var filteredLocations: [WellnessLocation] {
        allLocations.filter { $0.category == selectedCategory }
    }
}
