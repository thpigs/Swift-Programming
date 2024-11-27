//
//  RouteDataView.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/15/24.
//

import SwiftUI

struct RouteDataView: View {
    @EnvironmentObject var manager: Manager
    @State var currentStepIndex = 0
    
    var body: some View {
        VStack {
            if let route = manager.route {
                Text("Estimated travel time: \(formattedTravelTime(route.expectedTravelTime))")
                    .bold()
                    .padding()
                
                if route.steps.indices.contains(currentStepIndex) {
                    Text(route.steps[currentStepIndex].instructions)
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color.white)
                }
                
                HStack {
                    Button("Previous") {
                        if currentStepIndex > 0 {
                            currentStepIndex -= 1
                        }
                    }
                    .disabled(currentStepIndex == 0) // Can't click previous on first step
                    
                    Spacer()
                    
                    Button("Next") {
                        if currentStepIndex < route.steps.count - 1 {
                            currentStepIndex += 1
                        }
                    }
                    .disabled(currentStepIndex == route.steps.count - 1) // Can't click next on last step
                }
                .padding()
            } else {
                Text("No route available.")
                    .padding()
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
    }
        
    
    private func formattedTravelTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return "\(minutes) min \(seconds) sec"
    }
}

#Preview {
    RouteDataView()
        .environmentObject(Manager())
}
