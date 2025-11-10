//
//  ContentView.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI
import CompactSlider
import Forever

struct ContentView: View {
    @Forever("userData") var userData: UserData = UserData()
    @State var timestep: Double = 0.02
    var body: some View {
        PendulumView(userData: $userData, timestep: $timestep)
            .padding()
    }
}

#Preview {
    ContentView()
}
