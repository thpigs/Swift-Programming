//
//  MenuButtonsView.swift
//  Pentominoes
//
//  Created by Chang, Daniel Soobin on 9/24/24.
//

import SwiftUI

struct MenuButtonsView: View {
    @EnvironmentObject var gameManager: GameManager
    let buttonNames = ["Reset", "Solve"]
    var body: some View {
        HStack{
            ForEach(0...1, id:\.self) { num in
                Button(action: {
                    if num == 1 {
                        gameManager.showSolution()
                    } else {
                        
                    }
                }) {
                    Text(buttonNames[num])
                        .bold()
                }
                if num == 0 {
                    Spacer()
                }
            }
            
        }
        .padding()
    }
}


 #Preview {
     MenuButtonsView()
        .environmentObject(GameManager())
 
 }
 
