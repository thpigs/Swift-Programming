//
//  MapView.swift
//  Thpigs
//
//  Created by Chang, Daniel Soobin on 11/11/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var camera : MapCameraPosition = .automatic
    
    var body: some View {
        NavigationStack {
            Map(position:$camera) {
                
            }
        }
    }
}

#Preview {
    MapView()
}
