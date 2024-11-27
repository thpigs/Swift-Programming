//
//  MapViewCoordinator.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/20/24.
//

import Foundation
import MapKit

class MapViewCoordinator : NSObject, MKMapViewDelegate {
    var manager : Manager
    var oldRegion: MKCoordinateRegion
    var customCounter: Int = 0
    init(manager: Manager) {
        self.manager = manager
        self.oldRegion = manager.region
        super.init()
    }
    
    // Annotations
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let markerID = "Place"
        let customID = "CustomMarker"
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let marker = (mapView.dequeueReusableAnnotationView(withIdentifier: markerID) ?? MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: markerID)) as! MKMarkerAnnotationView
        if let place = annotation as? Place {
            if (place.building.favorited) {
                marker.markerTintColor = .blue
               // print("Making a favorited pin for \(place.building.name) of color \(String(describing: marker.tintColor))")
                //marker.glyphTintColor = .orange
            }
            else if (place.building.mapped) {
                marker.markerTintColor = .white
               // print("Making a mapped pin for \(place.building.name) of color \(String(describing: marker.tintColor))")
                //marker.glyphTintColor = .black
            }
            
            marker.glyphImage = UIImage(systemName: "mappin")
           // print("making place marker")
            
        }
        return marker
         
    }
    
    // Routes
    func mapView(_ mapView: MKMapView, rendererFor polyline: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: polyline as! MKPolyline)
        polylineRenderer.lineWidth = 8.0
        polylineRenderer.strokeColor = UIColor.red
        return polylineRenderer
    }
    
    // Building Info Sheet
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotationView) {
        if let place = annotation.annotation as? Place {
            //print("Inside delegate for clicking a pin. Place: \(place)")
            manager.buildingToPresent = place.building
            manager.isShowingDetails = true
        }
    }
    
    // Placing custom marker
    @objc func handleTap(gesture: UITapGestureRecognizer) {
       // print("in handletap")
        let mapView = gesture.view as! MKMapView
        let touchPoint = gesture.location(in: mapView)
        let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        if (manager.isPlacingMarker) {
           // print("placing custom marker")
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            customCounter += 1
            let building = building(name: "Custom \(customCounter)", mapped: true, favorited: false, latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude, opp_bldg_code: customCounter)
            let place = Place(building: building)
            manager.annotatedBuildings.insert(place, at: manager.annotatedBuildings.count == 0 ? 0 : manager.annotatedBuildings.count - 1)
            if var buildings = manager.buildingData {
                buildings.append(building)
                manager.buildingData = buildings
            }
            
            manager.isPlacingMarker = false
        }
    }

}


