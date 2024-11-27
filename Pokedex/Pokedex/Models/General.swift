//
//  General.swift
//  Pokedex
//
//  Created by Chang, Daniel Soobin on 10/28/24.
//

import Foundation

enum filterOptions: String, Codable, Identifiable, CaseIterable {
    var id: String { self.rawValue }

    case id = "ID"
    case types = "Type"
    case height = "Height"
    case weight = "Weight"
}

