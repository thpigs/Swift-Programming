//
//  CustomMarker.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/21/24.
//

import SwiftUI

struct CustomMarker: View {
    @EnvironmentObject var manager: Manager

    var body: some View {
        //Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(action: {
            manager.isPlacingMarker = true
        }, label: {
            Text("Custom Marker")
                .bold()
                .foregroundStyle(Color.white)
                .padding()
                .background(RoundedRectangle(cornerRadius: 25.0).foregroundStyle(Color.blue))
        })
    }
}

#Preview {
    CustomMarker()
        .environmentObject(Manager())

}
