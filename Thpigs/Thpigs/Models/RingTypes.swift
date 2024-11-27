//
//  RingTypes.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/20/24.
//

import Foundation

enum RingTypes: String, Codable, Identifiable, CaseIterable {
    var id: String { self.rawValue }

    case steps = "Steps"
    case distance = "Distance Moved"
    case basalEnergy = "Basal Energy Burned"
    case activeEnergy = "Active Energy Burned"
    
    var index: Int {
        return RingTypes.allCases.firstIndex(of: self)!
    }
}
