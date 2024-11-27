//
//  Campus_MapApp.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/6/24.
//

import SwiftUI

@main
struct Campus_MapApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Manager())
        }
    }
}
