//
//  PendulumView.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI
import Combine

struct PendulumView: View {
    @Binding var userData: UserData
    @State var width: Double = 500
    @StateObject var calculator: Calculator
    @Environment(\.colorScheme) var colorScheme
    let timer = Timer.publish(every: 1 / 1000, on: .main, in: .common).autoconnect()
    
    init(userData: Binding<UserData>) {
        self._userData = userData
        let initialData = userData.wrappedValue
        self._calculator = StateObject(wrappedValue: Calculator(
            originX: (initialData.windowSize.width / 2),
            originY: 10.0,
            firstPendulumStringLength: 120.0,
            secondPendulumStringLength: 120.0,
            pendulumBobMass1: 10.0,
            pendulumBobMass2: 10.0,
            angleOfPendulumBob1: Double.pi / 3.0,
            angleOfPendulumBob2: Double.pi / 3.0,
            gravitationConstant: 9.81,
            velocity1: 0,
            velocity2: 0,
            acceleration1: 0,
            acceleration2: 0,
            timestep: 0.01
        ))
    }
    
    
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: calculator.originX, y: calculator.originY))
                path.addLine(to: CGPoint(x: calculator.pivot1X, y: calculator.pivot1Y))
            }
            .stroke(Color.white)
            Path { path in
                path.move(to: CGPoint(x: calculator.pivot1X, y: calculator.pivot1Y))
                path.addLine(to: CGPoint(x: calculator.pivot2X, y: calculator.pivot2Y))
            }
            .stroke(Color.cyan)
            .onAppear {
                calculator.refresh()
            }
        }
        .frame(width: userData.windowSize.width, height: userData.windowSize.height)
        .onReceive(timer) { _ in
            calculator.refresh()
        }
    }
}

#Preview {
    PendulumView(userData: .constant(UserData(pendulumBobColor1: .green, pendulumBobColor2: .black, firstPendulumBobStringColor: .blue, secondPendulumBobStringColor: .brown, lastPositionOfPendulumBob1: nil, lastPositionOfPendulumBob2: nil, firstPendulumBobStringLength: 50, secondPedulumBobStringLength: 30, windowSize: CGSize(width: 500, height: 500))))
}
