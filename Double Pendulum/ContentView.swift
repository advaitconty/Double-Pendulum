//
//  ContentView.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI
import CompactSlider
import Forever
import Combine

struct ContentView: View {
    @Forever("userData") var userData: UserData = UserData()
    @State var timestep: Double = 0.02
    @StateObject var calculator: Calculator = Calculator()
    @State var pollingRate: Double = 200
    @State var timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    @State var stepsPerFrame: Double = 10
    
    var body: some View {
        HStack {
            PendulumView(userData: $userData, calculator: calculator, timer: $timer, timestep: $timestep, stepsPerFrame: $stepsPerFrame)
                .padding()
            Divider()
            VStack {
                SettingsView(userData: $userData, timestep: $timestep, stepsPerFrame: $stepsPerFrame)
                    .frame(minWidth: 400)
                    .onChange(of: userData) { data in
                        calculator.firstPendulumStringLength = data.firstPendulumBobStringLength
                        calculator.secondPendulumStringLength = data.secondPedulumBobStringLength
                        calculator.pendulumBobMass1 = data.pendulumBobMass1
                        calculator.pendulumBobMass2 = data.pendulumBobMass2
                        calculator.gravitationConstant = 9.81
                    }
                    .onChange(of: timestep) { timestep in
                        calculator.timestep = timestep
                    }
                    .onChange(of: calculator.pivot1X) {
                        userData.lastPositionOfPendulumBob1 = CGSize(width: calculator.pivot1X, height: calculator.pivot2X)
                    }
                Button {
                    calculator.originX = 50.0
                    calculator.originY = 50.0
                    calculator.firstPendulumStringLength = 120.0
                    calculator.secondPendulumStringLength = 120.0
                    calculator.pendulumBobMass1 = 50.0
                    calculator.pendulumBobMass2 = 50.0
                    calculator.angleOfPendulumBob1 = (Double.pi / 2)
                    calculator.angleOfPendulumBob2 = Double.pi / 2
                    calculator.gravitationConstant = 9.81
                    calculator.velocity1 = 0.0
                    calculator.velocity2 = 0.0
                    calculator.acceleration1 = 0.0
                    calculator.acceleration2 = 0.0
                    calculator.timestep = 0.02
                    calculator.trails1 = []
                    calculator.trails2 = []
                } label: {
                    Text("Reset simulation")
                }
                .fontWidth(.condensed)
                Button {
                    calculator.paused.toggle()
                } label: {
                    Text(calculator.paused ? "Resume simulation" : "Pause simulation")
                }
                .fontWidth(.condensed)
            }
        }
    }
}

#Preview {
    ContentView()
}
