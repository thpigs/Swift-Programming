//
//  MapConfigurationView.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/21/24.
//

import SwiftUI
import MapKit

struct MapConfigurationView: View {
    @EnvironmentObject var manager: Manager
    //@State var config: String = "Select"
    //let choices: [MKMapConfiguration] = [MKStandardMapConfiguration(), MKHybridMapConfiguration(), MKImageryMapConfiguration()]
    let choices = ["Standard", "Imagery", "Hybrid"]
    
    var body: some View {
        Picker("Configurations", selection: $manager.mapConfig) {
            Text("Choose a Map Layout")
            ForEach(choices, id: \.self) { option in
                Text(option)
                    .bold()
            }
        }
        .pickerStyle(.menu)
        //.foregroundColor(.red)
        .background(Color.white)
        .cornerRadius(25)
    }

}

#Preview {
    MapConfigurationView()
        .environmentObject(Manager())

}
