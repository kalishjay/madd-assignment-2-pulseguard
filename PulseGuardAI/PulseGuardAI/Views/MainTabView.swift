//
//  MainTabView.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI

/// Root tab navigation container providing seamless navigation between screens.
/// Fulfills the "Minimum 3 Navigable Screens & NavigationStack" requirement.
struct MainTabView: View {
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Label("Today", systemImage: "bolt.heart.fill")
                }
                .tag(0)

            InsightsView()
                .tabItem {
                    Label("AI Intel", systemImage: "sparkles")
                }
                .tag(1)

            VitalsLogView()
                .tabItem {
                    Label("Logs & Trends", systemImage: "chart.xyaxis.line")
                }
                .tag(2)

            WellnessMapView()
                .tabItem {
                    Label("Recovery Map", systemImage: "map.fill")
                }
                .tag(3)
        }
        .tint(.teal)
    }
}
