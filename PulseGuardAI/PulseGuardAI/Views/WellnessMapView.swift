//
//  WellnessMapView.swift
//  PulseGuardAI
//
//  Created for SE4041 MADD Assignment 2.
//

import SwiftUI
import MapKit

/// Interactive recovery centers and serene walking parks map.
/// Fulfills the "Emerging Technologies (MapKit Integration)" requirement.
struct WellnessMapView: View {
    @State private var viewModel = MapViewModel()

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Interactive MapKit View
                Map(position: $viewModel.cameraPosition) {
                    ForEach(viewModel.filteredLocations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Button {
                                withAnimation(.spring()) {
                                    viewModel.selectedLocation = location
                                }
                            } label: {
                                Image(systemName: location.category.icon)
                                    .font(.subheadline)
                                    .foregroundStyle(.white)
                                    .padding(8)
                                    .background(Circle().fill(.teal))
                                    .shadow(radius: 4)
                            }
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .ignoresSafeArea(edges: .bottom)

                // Floating Overlay: Category Filter & Selected Card
                VStack(spacing: 12) {
                    // Category Picker Chips
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(WellnessLocation.LocationCategory.allCases) { cat in
                                Button {
                                    withAnimation {
                                        viewModel.selectedCategory = cat
                                        if let first = viewModel.filteredLocations.first {
                                            viewModel.selectedLocation = first
                                        }
                                    }
                                } label: {
                                    HStack(spacing: 6) {
                                        Image(systemName: cat.icon)
                                        Text(cat.rawValue)
                                    }
                                    .font(.caption.bold())
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(
                                        viewModel.selectedCategory == cat ? Color.teal : Color.secondary.opacity(0.2)
                                    )
                                    .foregroundStyle(viewModel.selectedCategory == cat ? .white : .primary)
                                    .clipShape(Capsule())
                                    .shadow(radius: 2)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }

                    // Selected Location Detail Card
                    if let loc = viewModel.selectedLocation {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(loc.name)
                                        .font(.headline)
                                    Text(loc.address)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                HStack(spacing: 3) {
                                    Image(systemName: "star.fill")
                                        .foregroundStyle(.yellow)
                                    Text(String(format: "%.1f", loc.rating))
                                        .font(.caption.bold())
                                }
                            }

                            HStack {
                                Label(loc.openHours, systemImage: "clock.fill")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                Spacer()
                                Button {
                                    // Open in Apple Maps
                                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: loc.coordinate))
                                    mapItem.name = loc.name
                                    mapItem.openInMaps()
                                } label: {
                                    Text("Directions")
                                        .font(.caption.bold())
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 6)
                                        .background(Capsule().fill(.teal))
                                }
                            }
                        }
                        .glassCard(cornerRadius: 18, padding: 14)
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                    }
                }
                .padding(.bottom, 16)
            }
            .navigationTitle("Wellness Radar")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if viewModel.selectedLocation == nil {
                    viewModel.selectedLocation = viewModel.filteredLocations.first
                }
            }
        }
    }
}
