//
//  MapManager.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/20/24.
//

import Foundation
import CoreLocation

class MapManager : NSObject, CLLocationManagerDelegate, ObservableObject {
    let CLLocManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
}
