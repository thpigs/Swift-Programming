//
//  ContentView.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var healthDataManager: HealthDataManager
        var body: some View {
            NavigationStack {
                TabView {
                    // Home
                    FitnessStatsView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    
                    // Workout Logger
                    WorkoutDisplayView()
                        .tabItem {
                            Label("Workout", systemImage: "star.fill")
                        }
                    
                    // Gym Map
                    MapView()
                        .tabItem {
                            Label("Map", systemImage: "globe")
                        }
                    
                    // Pump Dump
                    PumpGalleryView()
                        .tabItem {
                            Label("Pump Dump", systemImage: "heart.fill")
                        }
                    
                    // Progression Tracker
                    ProgressionGalleryView()
                        .tabItem {
                            Label("Progression", systemImage: "square.fill")
                        }
                    
                    // Bar Tracker
                    BarTrackerGalleryView()
                        .tabItem {
                            Label("Bar Tracker", systemImage: "circle.fill")
                        }
                    
                }
            }
            .ignoresSafeArea(.container, edges: .bottom)

        }
}

#Preview {
    ContentView()
        .environmentObject(HealthDataManager())
}
