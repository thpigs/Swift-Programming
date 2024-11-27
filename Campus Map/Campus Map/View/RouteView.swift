//
//  RouteView.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/14/24.
//

import SwiftUI
import MapKit

struct RouteView: View {
    @EnvironmentObject var manager: Manager
    @State var startPlace: building?
    @State var endPlace: building?
    @State private var showSheet = false
    @State var displayRoute = false
    @State var displayRouteData = false
    var body: some View {
        Button(action:{
            showSheet.toggle()
        }, label: {
            Text("Get Directions")
                .bold()
                .foregroundStyle(Color.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(Color.blue))
        })
        .sheet(isPresented: $showSheet) {
            VStack {
                HStack {
                    let buildings = addUserToBuilding()
                    
                    Picker("Start Point", selection: $startPlace) {
                        Text("Select a location")
                            .tag(nil as building?)
                        if let userPlusBuildings = buildings {
                            ForEach(userPlusBuildings, id: \.self) { option in
                                Text(option.name)
                                    .bold()
                                    .tag(option as building?)
                            }
                        }
 
                    }
                    .pickerStyle(.menu)
                    .onAppear {
                        if startPlace == nil {
                            guard let building = manager.buildingData?.first else {
                                return
                            }
                            startPlace = building
                        }
                    }
                    
                    Picker("End Point", selection: $endPlace) {
                        Text("Select a location")
                            .tag(nil as building?)
                        ForEach(manager.buildingData ?? [], id: \.self) { option in
                            Text(option.name)
                                .bold()
                                .tag(option as building?)
                        }
                    }
                    .pickerStyle(.menu)
                    .onAppear {
                        if endPlace == nil {
                            guard let building = manager.buildingData?.last else {
                                return
                            }
                            endPlace = building
                        }
                    }
                }
                
                Button(action: {
                    showSheet = false
                    if let start = startPlace, let end = endPlace {
                        manager.buildingsInRoute = []
                        var location = CLLocationCoordinate2D(latitude: start.latitude, longitude: start.longitude)
                        manager.buildingsInRoute.append(location)
                        location = CLLocationCoordinate2D(latitude: end.latitude, longitude: end.longitude)
                        manager.buildingsInRoute.append(location)

                        manager.DisplayRoute(start: start, end: end)
                    }
                    
                    displayRouteData = true
                    displayRoute = true
                    manager.isShowingRoute = true
                    manager.removeAllSelects()
                    
                    if let buildings = manager.buildingData {
                        for i in 0..<buildings.count {
                            if (buildings[i] == startPlace || buildings[i] == endPlace) {
                                manager.buildingData?[i].mapped = true
                            }
                        }
                    }
                    
                }, label: {
                    Text("Submit")
                        .bold()
                })
                
                NavigationLink(destination: MapView(), isActive: $displayRoute, label: {EmptyView()})
                
                Button(action: {
                    showSheet = false
                }, label: {
                    Text("Close")
                        .bold()
                })
            }
        }
        .sheet(isPresented: $displayRouteData) {
            RouteDataView()
                .presentationDetents([.fraction(0.3)])
        }
        .onDisappear {
            displayRouteData = false
        }
    }
    
    func addUserToBuilding() -> [building]? {
        if var buildings = manager.buildingData {
            if let userLoc = manager.userLocation {
                let userBuilding = building(name: "You", mapped: false, favorited: false, latitude: userLoc.latitude, longitude: userLoc.longitude, opp_bldg_code: 00)
                buildings.insert(userBuilding, at: 0)
            }
            return buildings
        }
        return nil
    }
}

#Preview {
    RouteView()
        .environmentObject(Manager())
}
