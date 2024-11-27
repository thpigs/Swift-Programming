//
//  models.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/6/24.
//

import Foundation
import MapKit

struct building : Codable, Hashable, Equatable {
    let name: String
    var mapped: Bool = false
    var favorited: Bool = false
    let latitude: Double
    let longitude: Double
    let opp_bldg_code: Int
    let year_constructed: Int?
    let photo: String?
    
    static func == (lhs: building, rhs: building) -> Bool {
        return lhs.name == rhs.name
    }
    
    // Custom hash to use 'name' as the unique identifier
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)  // Only hash the name property
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case latitude
        case longitude
        case opp_bldg_code
        case year_constructed
        case photo
        case favorited
        case mapped
    }
    
    init(name: String, mapped: Bool = false, favorited: Bool = false, latitude: Double, longitude: Double, opp_bldg_code: Int, year_constructed: Int? = nil, photo: String? = nil) {
        self.name = name
        self.mapped = mapped
        self.favorited = favorited
        self.latitude = latitude
        self.longitude = longitude
        self.opp_bldg_code = opp_bldg_code
        self.year_constructed = year_constructed
        self.photo = photo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode fields normally
        self.name = try container.decode(String.self, forKey: .name)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.opp_bldg_code = try container.decode(Int.self, forKey: .opp_bldg_code)
        self.year_constructed = try container.decodeIfPresent(Int.self, forKey: .year_constructed)
        self.photo = try container.decodeIfPresent(String.self, forKey: .photo)
        
        // Provide default values if the keys are missing
        self.mapped = try container.decodeIfPresent(Bool.self, forKey: .mapped) ?? false
        self.favorited = try container.decodeIfPresent(Bool.self, forKey: .favorited) ?? false
    }
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        if lhs.center.latitude != rhs.center.latitude || lhs.center.longitude != rhs.center.longitude
        {
            return false
        }
        if lhs.span.latitudeDelta != rhs.span.latitudeDelta || lhs.span.longitudeDelta != rhs.span.longitudeDelta
        {
            return false
        }
        return true
    }
}
