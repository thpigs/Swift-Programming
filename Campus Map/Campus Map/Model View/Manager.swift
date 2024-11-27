//
//  Manager.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/6/24.
//

import Foundation
import MapKit
import SwiftUI


class Manager : NSObject, ObservableObject, CLLocationManagerDelegate {
    var region = MKCoordinateRegion(center: .stateCollege, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
    @Published var buildingData: [building]?
    @Published var buildingToPresent: building?
    @Published var isShowingDetails = false
    @Published var userLocation: CLLocationCoordinate2D?
    let locationManager: CLLocationManager
    @Published var route: MKRoute?
    @Published var polyline: MKPolyline?
    @Published var buildingsInRoute: [CLLocationCoordinate2D] = []
    @Published var center = true
    
    @Published var annotatedBuildings: [Place] = []
    @Published var isShowingRoute = false
    //@Published var mapConfig: MKMapConfiguration = MKStandardMapConfiguration()
    @Published var mapConfig: String = "Standard"
    @Published var isPlacingMarker = false
        
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if let temp = JsonParser().readJson(file: "UserData") {
            buildingData = temp
            //print("init good1")
        }
        else {
            buildingData = JsonParser().readJson(file: "buildings")
            //print("here2")
        }
        polyline = route?.polyline
        
        alphabetizeBuildingData()
        updateAnnotationList()

    }
    
    func updateAnnotationList() {
        self.annotatedBuildings = []
        if let buildingList = self.buildingData {
            for building in buildingList {
                if (building.favorited || building .mapped) {
                    let place = Place(building: building)
                    self.annotatedBuildings.append(place)
                }
            }
        }
    }
    func alphabetizeBuildingData() {
        buildingData?.sort(by: { $0.name < $1.name })
        /*if let x = buildingData {
            print(x.count)
        }*/
        
    }
    
    @MapContentBuilder
    func markSelectedBuildings() -> some MapContent {
        if let buildingList = self.buildingData {
            ForEach(buildingList, id: \.name) { building in
                if (building.favorited || building.mapped) {
                    Annotation(building.name, coordinate: CLLocationCoordinate2D(latitude: building.latitude, longitude: building.longitude)) {
                        
                        Button(action: {
                            self.buildingToPresent = building
                            self.isShowingDetails = true
                        }, label: {
                            VStack {
                                Image(systemName: "mappin")
                                    .scaleEffect(2)
                                    .foregroundColor(building.favorited ? Color.red : Color.blue)
                                Text(building.name)
                            }
                        })
                    }
                }
                
            }
        }
    }
    
    func favorite(building: building) {
        guard let buildingList = buildingData else {
            return
        }
        for i in 0..<buildingList.count {
            if (buildingList[i] == building) {
                buildingData?[i].favorited.toggle()
                buildingToPresent = buildingData?[i]
                
            }
        }
    }
    
    func getFavoritedBuildings() -> [building]? {
        guard let favorites = buildingData else {
            return nil
        }
        return favorites.filter { $0.favorited }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            // Update the userLocation and region when the location changes
            DispatchQueue.main.async {
                self.userLocation = location.coordinate
                self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
            }
        } 
        else {
            DispatchQueue.main.async {
            self.userLocation = CLLocationCoordinate2D(latitude: 40.7982, longitude: -77.8615) // State College coordinates
            self.region = MKCoordinateRegion(center: self.userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            self.userLocation = CLLocationCoordinate2D(latitude: 40.7982, longitude: -77.8615) // State College coordinates
            self.region = MKCoordinateRegion(center: self.userLocation!, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        }
    }
    
    func DisplayRoute(start: building, end: building) {
        self.polyline = nil
        let startPoint = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: start.latitude, longitude: start.longitude))
        let endPoint = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: end.latitude, longitude: end.longitude))
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: startPoint)
        request.destination = MKMapItem(placemark: endPoint)
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let response = response, let route = response.routes.first {
                self.route = route 
                self.polyline = route.polyline
                if let poly = self.polyline {
                    self.calculateRegion(from: poly, buildings: self.buildingsInRoute)

                }
            }
        }
        
    }
    
    func calculateRegion(from polyline: MKPolyline, buildings: [CLLocationCoordinate2D]) -> MKCoordinateRegion {
        var boundingMapRect = polyline.boundingMapRect
        
        for building in buildings {
            let buildingPoint = MKMapPoint(building)
            let buildingRect = MKMapRect(x: buildingPoint.x, y: buildingPoint.y, width: 0.1, height: 0.1)
            boundingMapRect = boundingMapRect.union(buildingRect)
        }
        self.region = MKCoordinateRegion(boundingMapRect)
        return MKCoordinateRegion(boundingMapRect)
    }
    
    // Nearby is .25 miles
    func getNearbyBuildings() -> [building]{
        guard let userLocation = userLocation else {
            return []
        }
        
        let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let nearByBuildings = buildingData?.filter { building in
            let buildingLocation = CLLocation(latitude: building.latitude, longitude: building.longitude)
            let distance = location.distance(from: buildingLocation)
            
            return distance <= 1609/4 // .25 times 1609 meters per mile
        } ?? []
        //print(nearByBuildings.count)
        return nearByBuildings
    
    }
    
    func removeAllSelects() {
        if let buildingCount = buildingData {
            for i in 0..<buildingCount.count {
                if (buildingCount[i].mapped || buildingCount[i].favorited) {
                    buildingData?[i].mapped = false
                    buildingData?[i].favorited = false
                }
            }
        }
        
    }
    
    func getConfig(type: String) -> MKMapConfiguration {
        switch type {
        case "Standard":
            return MKStandardMapConfiguration()
        case "Imagery":
            return MKImageryMapConfiguration()
        case "Hybrid":
            return MKHybridMapConfiguration()
        default:
            return MKStandardMapConfiguration()
        }
    }
}
    

