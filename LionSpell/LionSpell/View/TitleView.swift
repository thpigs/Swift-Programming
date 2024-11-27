//
//  TitleView.swift
//  LionSpell
//
//  Created by Chang, Daniel Soobin on 9/2/24.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        Text("Lion Spell")
            .bold()
            .font(.system(size:48))
            .foregroundStyle(Color.blue)
    }
}

#Preview {
    TitleView()
}
