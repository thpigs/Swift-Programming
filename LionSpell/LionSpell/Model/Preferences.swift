//
//  Preferences.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/16/24.
//

import Foundation


struct Preferences {
    var numberOfLetters : NumberOfLetters
    var language: Language
    
}

enum Language: String, CaseIterable, Identifiable {
    case english = "english"
    case french = "french"

    var id: String { self.rawValue }
}

enum NumberOfLetters: Int, CaseIterable, Identifiable {
    case five = 5
    case six = 6
    case seven = 7
    
    var id: Int {self.rawValue}
    
}
