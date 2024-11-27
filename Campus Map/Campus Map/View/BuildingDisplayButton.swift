//
//  BuildingDisplayButton.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/7/24.
//

import SwiftUI

struct BuildingDisplayButton: View {
    @EnvironmentObject var manager: Manager
    @Environment(\.editMode) var editMode
    @State var showBuildingList: Bool = false
    @State var selectSelectedBuildings: Bool = true
    @State var selectFavoritedBuildings: Bool = true
    @State var mappedBuildings = Set<building>()
    @State var favoritedBuildings = Set<building>()
    @State var tempMapped = Set<building>()
    @State var tempFaved = Set<building>()
    @State var option: String = "All"
    let views = ["All", "Selected", "Favorites", "Nearby"]
    var displayOption: [building] {
            switch option {
            case "Favorites":
                return manager.buildingData?.filter { $0.favorited } ?? []
            case "Selected":
                return manager.buildingData?.filter { $0.mapped } ?? []
            case "Nearby":
                let nearbyBuildings = manager.getNearbyBuildings()
                return nearbyBuildings
            default:  // "All"
                return manager.buildingData ?? []
            }
        }
    var body: some View {
        Button(action: {
            showBuildingList.toggle()
            if let buildingData = manager.buildingData {
                mappedBuildings = Set(buildingData.filter { $0.mapped })
            }
        }, label: {
            Text("Buildings")
                .bold()
                .foregroundStyle(Color.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(Color.blue))

        })
        
        if (showBuildingList) {
            Spacer()
            NavigationView {
                if let buildings = manager.buildingData {
                    List(displayOption, id: \.self, selection: $mappedBuildings) { building in
                        Label {
                            Text(building.name)
                        } icon : {
                            if (building.favorited) {
                                Image(systemName: "heart.fill")
                            }
                            else {
                                Image(systemName: "heart")
                            }
                        }
                        .onAppear {
                            updateFaves()
                        }
            
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .environment(\.editMode, .constant(EditMode.active))
                    .navigationTitle("Buildings")
                    .toolbar {
                        HStack {
                            Picker("Display Options", selection: $option) {
                                ForEach(views, id: \.self) { option in
                                    Text(option)
                                        .bold()
                                        .lineLimit(1)
                                        .frame(width: 300)
                                }
                            }
                            .pickerStyle(.menu)
                            
                            
                            Button(action: {
                                if selectSelectedBuildings {
                                    tempMapped = mappedBuildings
                                    mappedBuildings.removeAll()
                                } else {
                                    mappedBuildings = tempMapped
                                }
                                selectSelectedBuildings.toggle()
                            }, label: {
                                if (selectSelectedBuildings) {
                                    Text("Deselect \nSelections")
                                        .bold()
                                        .lineLimit(nil)
                                        .frame(width: 90, height: 100)
                                    
                                } else {
                                    Text("Select Selections")
                                        .bold()
                                        .lineLimit(nil)
                                        .frame(width: 90, height: 100)
                                }
                                
                            })
                            Button(action: {
                                // Deselect all
                                if selectFavoritedBuildings {
                                    tempFaved = favoritedBuildings
                                    guard let buildingData = manager.buildingData else {
                                        return
                                    }
                                    for i in 0..<buildingData.count {
                                        var building = buildingData[i]
                                        building.favorited = false
                                        manager.buildingData?[i] = building
                                    }
                                    favoritedBuildings.removeAll()
                                }
                                else {
                                    favoritedBuildings = tempFaved
                                    guard let buildingData = manager.buildingData else {
                                        return
                                    }
                                    for building in favoritedBuildings {
                                        if let index = buildingData.firstIndex(where: { $0.name == building.name }) {
                                            var updatedBuilding = buildingData[index]
                                            updatedBuilding.favorited = true
                                            manager.buildingData?[index] = updatedBuilding
                                        }
                                    }
                                }
                                selectFavoritedBuildings.toggle()
                            }, label: {
                                if (selectFavoritedBuildings) {
                                    Text("Deselect Favorited")
                                        .bold()
                                        .lineLimit(nil)
                                        .frame(width: 90, height: 100)
                                } else {
                                    Text("Select Favorited")
                                        .bold()
                                        .lineLimit(nil)
                                        .frame(width: 90, height: 100)
                                }
                            })
                            //.position(x: -80, y: 0)
                                                        
                            Button(action: {
                                showBuildingList.toggle()
                                //manager.markSelectedBuildings()
                                guard let buildingData = manager.buildingData else {
                                    return
                                }
                                for i in 0..<buildingData.count {
                                    var building = buildingData[i]
                                    if (mappedBuildings.contains(building)) {
                                        building.mapped = true
                                        //print(building.mapped)
                                    }
                                    else {
                                        building.mapped = false
                                    }
                                    manager.buildingData?[i] = building
                                }
                                tempMapped = mappedBuildings
                                updateFaves()
                                guard let x = manager.getFavoritedBuildings() else {
                                    return
                                }
                                tempFaved = Set(x)
                                //print(tempFaved)
                                guard let savedData = manager.buildingData else {
                                    return
                                }
                                 
                                JsonParser().saveUserData(selectedBuildings: savedData, file: "UserData")
                                manager.updateAnnotationList()

                            }, label: {
                                Text("Close")
                                    .bold()
                                    .foregroundStyle(Color.blue)
                                
                                    // add animation to make it close cleaner?
                            })
                        }
                        //.offset(x:-60,y: 0)
                    }
                }
            }
            .onAppear {
               // print("here1")
                manager.isShowingRoute = false
                //print("here2")
            }
                
        }
            
    }
    func updateFaves() {
        guard let favorites = manager.getFavoritedBuildings() else {
            return
        }
        favoritedBuildings = Set(favorites)
    }
    
}

#Preview {
    BuildingDisplayButton()
        .environmentObject(Manager())
}
