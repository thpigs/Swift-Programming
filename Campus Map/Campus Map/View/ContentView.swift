//
//  ContentView.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/6/24.
//

import SwiftUI
import MapKit
struct ContentView: View {
    @EnvironmentObject var manager: Manager
    
    var body: some View {
            ZStack  {
                //MapView()
                MapViewUIKit(mapConfig: $manager.mapConfig)
                    .sheet(isPresented: $manager.isShowingDetails) {
                        BuildingInfoView()
                    }
                VStack {
                    RouteView()
                        .offset(x: -120 , y: 60)
                    CustomMarker()
                        .offset(x: -115 , y: 60)
                    MapConfigurationView()
                        .offset(x: -130, y: 70)
                    Spacer()
                    //CenterButtonView()
                    Spacer()
                }
                .safeAreaInset(edge: .bottom) {
                    BuildingDisplayButton()
                        .padding([.top, .bottom])
                        //.offset(x: 80)
                }
                
            }
            
            .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let manager = Manager()

            
        return ContentView()
            .environmentObject(manager)
    }
}

/*#Preview {
    ContentView()
        .environmentObject(Manager())

}*/

