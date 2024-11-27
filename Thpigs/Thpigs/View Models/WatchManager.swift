//
//  WatchManager.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/11/24.
//

import Foundation
import HealthKit
import WatchConnectivity
/*
 Don't need a watch manager specifically. You can reuse the HealthDataManagerCode since both the watch and the phone's fitness app send data to the HKStore. Only need to have a WCSessionDelegate if you need to access other functions of the watch.
 */
class WatchManager : NSObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if activationState == .activated && session.isPaired {
            
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    
    
    
    func startSession() {
        if (WCSession.isSupported()) {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func checkWatchStatus() -> Bool {
        if (WCSession.isSupported()) {
            let session = WCSession.default
            return session.isPaired && session.isWatchAppInstalled
        }
        return false
    }
    
}
