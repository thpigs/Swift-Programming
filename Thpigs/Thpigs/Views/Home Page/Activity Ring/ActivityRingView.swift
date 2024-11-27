//
//  ActivityRingView.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/11/24.
//

import SwiftUI
import HealthKit

struct ActivityRingView: View {
    @EnvironmentObject var healthDataManager: HealthDataManager
    let width: CGFloat
    @State var stepCount: Double = 0
    @State var distanceWalked: Double = 0
    @State var basalEnergy: Double = 0
    @State var activeEnergy: Double = 0
    @State var percents: [Double] = [0, 0, 0, 0, 0]
    let bgColor: Color
    let fgColor: Color
    let ringName: RingTypes
    
    var body: some View {
        VStack {
            
            ZStack {
                Text(ringName.id)
                    .bold()
                    .multilineTextAlignment(.center)
                // Background Ring
                RingShape(percent: 100)
                    .stroke(style: StrokeStyle(lineWidth: self.width, lineCap: .round))
                    .fill(self.bgColor)
                
                // Foreground Ring
                RingShape(percent: self.percents[ringName.index] * 100)
                    .stroke(style: StrokeStyle(lineWidth: self.width, lineCap: .round))
                    .fill(self.fgColor)
            }
            .onAppear {
                let functions: [() -> Void] = [getStepCount, getDistanceMoved, getBEBurned, getAEBurned]
                //print(functions[ringName.index]())
                functions[ringName.index]()
            }
        }
        
    }
    
    func getStepCount() {
        healthDataManager.getHKValue(hasWatch: healthDataManager.isWatchConnected, type: HKQuantityType(.stepCount)) { count in
            DispatchQueue.main.async {
                self.stepCount = count
                self.percents[0] = min(count / healthDataManager.stepGoal, 1.0)
            }
        }
    }
    
    func getDistanceMoved() {
        healthDataManager.getHKValue(hasWatch: healthDataManager.isWatchConnected, type: HKQuantityType(.distanceWalkingRunning)) { distance in
            DispatchQueue.main.async {
                self.distanceWalked = distance
                self.percents[1] = min(distance / healthDataManager.distanceGoal, 1.0)
            }
        }
    }
    
    func getBEBurned() {
        healthDataManager.getHKValue(hasWatch: healthDataManager.isWatchConnected, type: HKQuantityType(.basalEnergyBurned)) { value in
            DispatchQueue.main.async {
                self.basalEnergy = value
                self.percents[1] = min(value / healthDataManager.basalEnergyGoal, 1.0)
            }
        }
    }
    
    func getAEBurned() {
        healthDataManager.getHKValue(hasWatch: healthDataManager.isWatchConnected, type: HKQuantityType(.distanceWalkingRunning)) { value in
            DispatchQueue.main.async {
                self.activeEnergy = value
                self.percents[1] = min(value / healthDataManager.activeEnergyGoal, 1.0)
            }
        }
    }

}

struct ActivityRingView_Previews: PreviewProvider {
    static var previews: some View {
        let healthDataManager = HealthDataManager()
        ActivityRingView(width: 50, bgColor: Color.green, fgColor: Color.blue, ringName: RingTypes.steps)
            .frame(width: 300, height: 300)
            .environmentObject(healthDataManager)
    }
}

/*#Preview {
    ActivityRingView(width: 50, bgColor: Color.green, fgColor: Color.blue)
        .frame(width: 300, height: 300)
 }*/
 
