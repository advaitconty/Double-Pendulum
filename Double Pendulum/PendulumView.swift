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
    let timer = Timer.publish(every: 1 / 100, on: .main, in: .common).autoconnect()
    
    init(userData: Binding<UserData>) {
        self._userData = userData
        let initialData = userData.wrappedValue
        self._calculator = StateObject(wrappedValue: Calculator(
            originX: Double(initialData.windowSize.width / 2.0),
            originY: 50.0,
            firstPendulumStringLength: initialData.firstPendulumBobStringLength,
            secondPendulumStringLength: initialData.secondPedulumBobStringLength,
            pendulumBobMass1: 5.0,
            pendulumBobMass2: 5.0,
            angleOfPendulumBob1: .pi / 2.0,
            angleOfPendulumBob2: .pi / 2.0,
            gravitationConstant: 9.8,
            centreOfBob1: .zero,
            centreOfBob2: .zero,
            rotationOfBob1: 0,
            rotationOfBob2: 0,
            velocity1: 0,
            velocity2: 0,
            acceleration1: 0,
            acceleration2: 0,
            timestep: 0.02
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
