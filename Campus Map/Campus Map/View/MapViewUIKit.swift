//
//  MapViewUIKit.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/20/24.
//

import SwiftUI
import Foundation
import MapKit

struct MapViewUIKit: UIViewRepresentable {
    @EnvironmentObject var manager: Manager
    @Binding var mapConfig: String
    
    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.region = manager.region
        map.showsUserLocation = true
        map.showsUserTrackingButton = true
        map.delegate = context.coordinator
        map.preferredConfiguration = manager.getConfig(type: mapConfig)
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(gesture:)))
        map.addGestureRecognizer(tapGesture)
        return map
    }
    
    func updateUIView(_ map: MKMapView, context: Context) {
       // print("Updating")
        map.removeAnnotations(map.annotations)
        map.removeOverlays(map.overlays)
       // print("isShowingRoute: \(manager.isShowingRoute)")
        if(manager.isShowingRoute) {
            if let polyline = manager.polyline {
                var annotationsToKeep: [MKAnnotation] = []
                for place in manager.annotatedBuildings {
                    for i in 0...1 {
                        if (place.building.latitude == manager.buildingsInRoute[i].latitude && place.building.longitude == manager.buildingsInRoute[i].longitude) {
                            annotationsToKeep.append(place)
                        }
                    }
                }
                //print("in the reg if statement of adding markers")
                map.addAnnotations(annotationsToKeep)
                map.addOverlay(polyline)
            }
        }
        else {
           // print("In the else of adding markers")
            map.addAnnotations(manager.annotatedBuildings)
        }
        
        
        // You only change region when user moves or a route is submitted
        if (context.coordinator.oldRegion != manager.region) {
            map.setRegion(manager.region, animated: true)
            
        }
        map.preferredConfiguration = manager.getConfig(type: mapConfig)
        
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(manager: manager)
    }
}

/*#Preview {
    MapViewUIKit()
        .environmentObject(Manager())

}*/
