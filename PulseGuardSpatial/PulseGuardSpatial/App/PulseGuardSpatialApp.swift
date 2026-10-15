//
//  PulseGuardSpatialApp.swift
//  PulseGuardSpatial
//
//  Created for SE4041 MADD Assignment 2 - Part B (VisionOS).
//

import SwiftUI

@main
struct PulseGuardSpatialApp: App {
    @State private var immersionStyle: ImmersionStyle = .progressive

    var body: some Scene {
        // Main Floating 2D/3D Spatial Window
        WindowGroup(id: "SpatialDashboard") {
            SpatialDashboardView()
        }
        .windowStyle(.plain)
        .defaultSize(width: 900, height: 640)

        // Volumetric 3D Recovery Sphere Window
        WindowGroup(id: "VolumetricVitals") {
            VolumetricVitalsView()
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters)

        // Full Immersive Relaxation Sanctuary Space
        ImmersiveSpace(id: "RelaxationSanctuary") {
            ImmersiveRelaxationView()
        }
        .immersionStyle(selection: $immersionStyle, in: .progressive, .full)
    }
}
