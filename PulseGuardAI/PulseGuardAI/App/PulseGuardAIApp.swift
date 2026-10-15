//
//  PulseGuardAIApp.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, macOS 14.0, *)
@main
struct PulseGuardAIApp: App {
    let container: ModelContainer

    init() {
        let manager = HealthDataManager.shared
        self.container = manager.modelContainer
        manager.seedInitialDataIfNeeded(context: manager.modelContainer.mainContext)
    }

    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(container)
    }
}
