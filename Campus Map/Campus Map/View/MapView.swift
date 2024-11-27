//
//  MapView.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/6/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    // Coordinates of the Hub
    static let stateCollege = CLLocationCoordinate2D(latitude: 40.7982, longitude: -77.8615)
    
}

struct MapView: View {
    @EnvironmentObject var manager: Manager
    @State var camera : MapCameraPosition = .automatic
    @State var isCentered = false
    @State var centerEnabled = false
    @State var region = MKCoordinateRegion(center: .stateCollege, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
    var body: some View {
        NavigationStack {
            Map(position:$camera) {
                manager.markSelectedBuildings()
                if let route = manager.route {
                    MapPolyline(route.polyline)
                        .stroke(Color.blue, lineWidth: 6)
                }
                
                if let userLocation = manager.userLocation {
                    Annotation("UserLocation",coordinate: userLocation) {
                        User()
                    }
                }
            }
            .onAppear {
                //region = manager.region
                
                if let userLocation = manager.userLocation {
                    // Center the camera on the user location
                    camera = .region(MKCoordinateRegion(
                        center: userLocation,
                        span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008)
                    ))
                } else {
                    // Default location (State College)
                    camera = .region(manager.region)
                }
            }
            .onChange(of: manager.route) { newRoute in
                if let route = newRoute {
                    let newRegion = manager.calculateRegion(from: route.polyline, buildings: manager.buildingsInRoute)
                    camera = .region(newRegion)
                    manager.region = newRegion
                }
            }
            .onChange(of: manager.center) { _ in
                guard let userLoc = manager.userLocation else {
                    return
                }
                manager.region = MKCoordinateRegion(center: userLoc, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
                camera = .region(manager.region)
            }
            .sheet(isPresented: $manager.isShowingDetails) {
                BuildingInfoView()
            }
            
            
        }
    }

}

#Preview {
    MapView()
        .environmentObject(Manager())
}
