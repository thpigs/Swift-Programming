//
//  BuildingInfoView.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/21/24.
//

import SwiftUI

struct BuildingInfoView: View {
    @EnvironmentObject var manager: Manager

    var body: some View {
        if let building = manager.buildingToPresent {
            VStack {
                Text(building.name)
                    .font(.largeTitle)
                    .padding()
                if let photoName = building.photo {
                    Image(photoName)
                        .padding()
                }
                
                Button(action: {
                    manager.favorite(building: building)
                    //print(manager.getFavoritedBuildings())
                    //print(building.favorited)
                }, label: {
                    if building.favorited {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                })
                
                if let year = building.year_constructed {
                    Text("Year Established: \(String(year))")
                }
                
                Button("Close") {
                    manager.buildingToPresent = nil  // Dismiss the sheet
                    manager.isShowingDetails = false
                    guard let buildingData = manager.buildingData else {
                        return
                    }
                    JsonParser().saveUserData(selectedBuildings: buildingData, file: "UserData")
                    manager.updateAnnotationList()

                }
                

            }
            .onAppear {
                if let buildingIndex = manager.buildingData?.firstIndex(where: { $0.name == building.name}) {
                     manager.buildingToPresent = manager.buildingData?[buildingIndex]
                }
                
            }
        }
    }
}

#Preview {
    BuildingInfoView()
        .environmentObject(Manager())

}
