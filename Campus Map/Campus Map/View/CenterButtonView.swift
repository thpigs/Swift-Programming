//
//  CenterButtonView.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/15/24.
//

import SwiftUI
import MapKit

struct CenterButtonView: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        Button(action: {
            manager.center.toggle()
            //print(manager.userLocation)
        }, label: {
            Text("Recenter")
                .bold()
                .foregroundStyle(Color.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(Color.blue))
        })
    }
}

#Preview {
    CenterButtonView()        
        .environmentObject(Manager())

}
