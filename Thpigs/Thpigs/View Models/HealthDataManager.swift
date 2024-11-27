//
//  HealthDataManager.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/11/24.
//

import Foundation
import HealthKit
class HealthDataManager : ObservableObject {
    @Published var authorized = false
    @Published var stepGoal: Double = 10000
    @Published var distanceGoal: Double = 10000
    @Published var basalEnergyGoal: Double = 10000
    @Published var activeEnergyGoal: Double = 10000
    @Published var isWatchConnected: Bool = false
    let healthStore = HKHealthStore()
    let activeSummary = HKActivitySummary()
    let allTypes: Set = [HKQuantityType(.stepCount),
                    HKQuantityType(.distanceWalkingRunning),
                    HKQuantityType(.basalEnergyBurned),
                    HKQuantityType(.activeEnergyBurned),
                    HKQuantityType(.heartRate)]
    
    init() {
        #if DEBUG
        // In preview mode, skip HealthKit authorization
        self.authorized = true
        
        #else
        Task {
            await accessHealthStore()
        }
        #endif
    }
 
    func accessHealthStore() async {
        do {
            if HKHealthStore.isHealthDataAvailable() {
                // Read and write permissions.
                try await healthStore.requestAuthorization(toShare: allTypes, read: allTypes)
                self.authorized = true
            }
        // User doesn't allow health permissions or doesn't have a compatible device.
        } catch {
            fatalError("Error requesting authorization: \(error.localizedDescription)")
        }
    }
    
    func getHKValue(hasWatch: Bool, type: HKQuantityType, completion: @escaping (Double) -> Void) {
        //#if DEBUG
        //completion(7500)
        
        //#else
        let hkType = type
        let dayStart = Calendar.current.startOfDay(for: Date())
        // Time span (Whole day)
        let timePredicate = HKQuery.predicateForSamples(withStart: dayStart, end: Date())
        let devicePredicate: NSPredicate
        if hasWatch {
            // Any Apple watch device. Keeping it general for now.
            let watchDevice = HKDevice(
                name: nil,
                manufacturer: "Apple",
                model: "Watch",
                hardwareVersion: nil,
                firmwareVersion: nil,
                softwareVersion: nil,
                localIdentifier: nil,
                udiDeviceIdentifier: nil
            )
            
            // Combines the predicates: Data from the watch and within the current day.
            devicePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                timePredicate,
                HKQuery.predicateForObjects(from: [watchDevice])
            ])
        } else {
            // Any data from the current day, regardless of device
            devicePredicate = timePredicate
        }

        let query = HKStatisticsQuery(quantityType: hkType, quantitySamplePredicate: devicePredicate, options: .cumulativeSum) { _, result, _ in
            let value = result?.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
            completion(value)
        }

        healthStore.execute(query)
       // #endif
    }
    
}
