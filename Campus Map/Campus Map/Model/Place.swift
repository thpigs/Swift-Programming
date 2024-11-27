//
//  UIModels.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/20/24.
//

import Foundation
import MapKit

class Place : NSObject, MKAnnotation {
    let building: building
    var coordinate : CLLocationCoordinate2D
    
    init(building: building) {
        self.building = building
        self.coordinate = CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)
    }
}
