//
//  ContentView.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI
import CompactSlider
import SwiftData
import Combine

struct ContentView: View {
    @Query var rememberedUserData: [UserData]
    @Environment(\.modelContext) var modelContext
    @AppStorage("timestep") var timestep: Double = 0.02
    @StateObject var calculator: Calculator = Calculator()
    @State var pollingRate: Double = 200
    @State var timer = Timer.publish(every: 0.016, on: .main, in: .common).autoconnect()
    @State var stepsPerFrame: Double = 10
    @State var showSettings: Bool = false
    @Namespace var namespace
    
    // Get or create userData - always returns the SwiftData object
    var userData: UserData {
        if let existing = rememberedUserData.first {
            return existing
        } else {
            let new = UserData(pendulumBobColor1Hex: "#ABCDEF", pendulumBobColor2Hex: "#ABCDEF", pendulumBobTrail1Hex: "#ABCDEF", pendulumBobTrail2Hex: "#ABCDEF", firstPendulumBobStringColorHex: "#ABCDEF", secondPendulumBobStringColorHex: "#ABCDEF", pendulumBobMass1: 50.0, pendulumBobMass2: 50.0, pendulumBobSize1: 40.0, pendulumBobSize2: 40.0, pendulumBob1TrailDataMaxLength: 100, pendulumBob2TrailDataMaxLength: 100, gravitationalField: 9.81, velocityOfBob1: 0.0, velocityOfBob2: 0.0, lastAccelerationOfPendulumBob1: 0.0, lastAccelerationOfPendulumBob2: 0.0, lastVelocityOfPendulumBob1: 0.0, lastVelocityOfPendulumBob2: 0.0, preferredOriginPositionX: 300.0, preferredOriginPositionY: 200.0, firstPendulumBobStringLength: 120.0, secondPedulumBobStringLength: 120.0, windowSizeX: 600, windowSizeY: 600)
            modelContext.insert(new)
            try? modelContext.save()
            return new
        }
    }
    
    var body: some View {
        HStack {
            VStack {
                if showSettings == false {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                showSettings = true
                            }
                        } label: {
                            Image(systemName: "sidebar.right")
                        }
                        .matchedGeometryEffect(id: "sidebar", in: namespace)
                    }
                }
                PendulumView(userData: Binding(get: { userData }, set: { _ in }), calculator: calculator, timer: $timer, timestep: $timestep, stepsPerFrame: $stepsPerFrame)
                    .padding()
            }
            .onAppear {
                loadUserDataIntoCalculator()
            }
            .onChange(of: rememberedUserData) {
                loadUserDataIntoCalculator()
            }
            .onReceive(timer) { _ in
                userData.lastPositionOfPendulumBob1X = calculator.pivot1X
                userData.lastPositionOfPendulumBob1Y = calculator.pivot1Y
                userData.lastPositionOfPendulumBob2X = calculator.pivot2X
                userData.lastPositionOfPendulumBob2Y = calculator.pivot2Y
                userData.lastVelocityOfPendulumBob1 = calculator.velocity1
                userData.lastVelocityOfPendulumBob2 = calculator.velocity2
                userData.lastAccelerationOfPendulumBob1 = calculator.acceleration1
                userData.lastAccelerationOfPendulumBob2 = calculator.acceleration2
                userData.preferredOriginPositionX = calculator.originX
                userData.preferredOriginPositionY = calculator.originY
                try? modelContext.save()
            }
            if showSettings {
                Group {
                    Divider()
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                withAnimation {
                                    showSettings = false
                                }
                            } label: {
                                Image(systemName: "sidebar.right")
                            }
                            .matchedGeometryEffect(id: "sidebar", in: namespace)
                        }
                        SettingsView(userData: Binding(get: { userData }, set: { _ in }), timestep: $timestep, stepsPerFrame: $stepsPerFrame)
                            .frame(minWidth: 400)
                            .onChange(of: userData.pendulumBobColor1Hex) { saveUserData() }
                            .onChange(of: userData.pendulumBobColor2Hex) { saveUserData() }
                            .onChange(of: userData.pendulumBobTrail1Hex) { saveUserData() }
                            .onChange(of: userData.pendulumBobTrail2Hex) { saveUserData() }
                            .onChange(of: userData.firstPendulumBobStringColorHex) { saveUserData() }
                            .onChange(of: userData.secondPendulumBobStringColorHex) { saveUserData() }
                            .onChange(of: userData.pendulumBobMass1) {
                                calculator.pendulumBobMass1 = userData.pendulumBobMass1
                                saveUserData()
                            }
                            .onChange(of: userData.pendulumBobMass2) {
                                calculator.pendulumBobMass2 = userData.pendulumBobMass2
                                saveUserData()
                            }
                            .onChange(of: userData.pendulumBobSize1) { saveUserData() }
                            .onChange(of: userData.pendulumBobSize2) { saveUserData() }
                            .onChange(of: userData.firstPendulumBobStringLength) {
                                calculator.firstPendulumStringLength = userData.firstPendulumBobStringLength
                                saveUserData()
                            }
                            .onChange(of: userData.secondPedulumBobStringLength) {
                                calculator.secondPendulumStringLength = userData.secondPedulumBobStringLength
                                saveUserData()
                            }
                            .onChange(of: timestep) {
                                calculator.timestep = timestep
                            }
                            .onChange(of: calculator.pivot1X) { _ in
                                userData.lastPositionOfPendulumBob1X = calculator.pivot1X
                                userData.lastPositionOfPendulumBob1Y = calculator.pivot1Y
                                userData.lastPositionOfPendulumBob2X = calculator.pivot2X
                                userData.lastPositionOfPendulumBob2Y = calculator.pivot2Y
                                userData.lastVelocityOfPendulumBob1 = calculator.velocity1
                                userData.lastVelocityOfPendulumBob2 = calculator.velocity2
                                userData.lastAccelerationOfPendulumBob1 = calculator.acceleration1
                                userData.lastAccelerationOfPendulumBob2 = calculator.acceleration2
                                userData.preferredOriginPositionX = calculator.originX
                                userData.preferredOriginPositionY = calculator.originY
                                saveUserData()
                            }
                            .onChange(of: calculator.originX) { _ in
                                userData.preferredOriginPositionX = calculator.originX
                                userData.preferredOriginPositionY = calculator.originY
                                saveUserData()
                            }
                        Button {
                            calculator.originX = userData.preferredOriginPositionX
                            calculator.originY = userData.preferredOriginPositionY
                            calculator.firstPendulumStringLength = userData.firstPendulumBobStringLength
                            calculator.secondPendulumStringLength = userData.secondPedulumBobStringLength
                            calculator.pendulumBobMass1 = userData.pendulumBobMass1
                            calculator.pendulumBobMass2 = userData.pendulumBobMass2
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
                .transition(.move(edge: .trailing))
            }
        }
    }
    
    private func loadUserDataIntoCalculator() {
        let data = userData
        calculator.originX = data.preferredOriginPositionX
        calculator.originY = data.preferredOriginPositionY
        calculator.firstPendulumStringLength = data.firstPendulumBobStringLength
        calculator.secondPendulumStringLength = data.secondPedulumBobStringLength
        calculator.pendulumBobMass1 = data.pendulumBobMass1
        calculator.pendulumBobMass2 = data.pendulumBobMass2
        calculator.angleOfPendulumBob1 = (Double.pi / 2)
        calculator.angleOfPendulumBob2 = Double.pi / 2
        calculator.gravitationConstant = 9.81
        calculator.velocity1 = data.lastVelocityOfPendulumBob1
        calculator.velocity2 = data.lastVelocityOfPendulumBob2
        calculator.acceleration1 = data.lastAccelerationOfPendulumBob1
        calculator.acceleration2 = data.lastAccelerationOfPendulumBob2
        if let x1 = data.lastPositionOfPendulumBob1X,
           let y1 = data.lastPositionOfPendulumBob1Y,
           let x2 = data.lastPositionOfPendulumBob2X,
           let y2 = data.lastPositionOfPendulumBob2Y {
            calculator.pivot1X = x1
            calculator.pivot1Y = y1
            calculator.pivot2X = x2
            calculator.pivot2Y = y2
        }
        calculator.timestep = timestep
        calculator.trails1 = []
        calculator.trails2 = []
    }
    
    private func saveUserData() {
        try? modelContext.save()
    }
}

#Preview {
    ContentView()
}
