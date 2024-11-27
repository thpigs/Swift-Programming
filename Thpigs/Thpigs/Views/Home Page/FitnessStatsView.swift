//
//  AppleWatchView.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/11/24.
//

import SwiftUI
import HealthKit
import WatchConnectivity
struct FitnessStatsView: View {
    @EnvironmentObject var healthDataManager: HealthDataManager
    var body: some View {
        VStack {
            HStack {
                ActivityRingView(width: 25, bgColor: Color.green, fgColor: Color.blue, ringName: RingTypes.steps)
                    .frame(width: 150, height: 150)
                    .padding()
                ActivityRingView(width: 25, bgColor: Color.green, fgColor: Color.blue, ringName: RingTypes.distance)
                    .frame(width: 150, height: 150)
                    .padding()
            }
            
            HStack {
                ActivityRingView(width: 25, bgColor: Color.green, fgColor: Color.blue, ringName: RingTypes.basalEnergy)
                    .frame(width: 150, height: 150)
                    .padding()
                ActivityRingView(width: 25, bgColor: Color.green, fgColor: Color.blue, ringName: RingTypes.activeEnergy)
                    .frame(width: 150, height: 150)
                    .padding()
            }
            
        }
        
    }
}

#Preview {
    FitnessStatsView()
        .environmentObject(HealthDataManager())

}
