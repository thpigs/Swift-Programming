//
//  User.swift
//  Campus Map
//
//  Created by Chang, Daniel Soobin on 10/15/24.
//

import SwiftUI

struct User: View {
    var body: some View {
        VStack {
            Image(systemName: "location.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
        }
    }
}

#Preview {
    User()
}
