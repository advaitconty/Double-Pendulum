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
    @StateObject var calculator: Calculator = Calculator()
    @Environment(\.colorScheme) var colorScheme
    let timer = Timer.publish(every: 1 / 67, on: .main, in: .common).autoconnect()
    @Binding var timestep: Double
    @State var originPivotDragOffset: CGSize = CGSize(width: 0, height: 0)
    
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: calculator.originX, y: calculator.originY))
                path.addLine(to: CGPoint(x: calculator.pivot1X, y: calculator.pivot1Y))
            }
            .stroke(userData.firstPendulumBobStringColor)
            Path { path in
                path.move(to: CGPoint(x: calculator.pivot1X, y: calculator.pivot1Y))
                path.addLine(to: CGPoint(x: calculator.pivot2X, y: calculator.pivot2Y))
            }
            .stroke(userData.secondPendulumBobStringColor)
            .onAppear {
                calculator.refresh()
            }
            Circle()
                .frame(width: 10)
                .position(x: calculator.originX + originPivotDragOffset.width, y: calculator.originY + originPivotDragOffset.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation {
                                calculator.originX = value.location.x
                                calculator.originY = value.location.y
                            }
                        }
                        .onEnded { value in
                            withAnimation {
                                calculator.originX = value.location.x
                                calculator.originY = value.location.y
                            }
                        }
                )
            Circle()
                .frame(width: 50.0)
                .position(x: calculator.pivot1X, y: calculator.pivot1Y)
                .foregroundStyle(userData.pendulumBobColor1)
            Circle()
                .frame(width: 50.0)
                .position(x: calculator.pivot2X, y: calculator.pivot2Y)
                .foregroundStyle(userData.pendulumBobColor2)
        }
        .frame(width: userData.windowSize.width, height: userData.windowSize.height)
        .onReceive(timer) { _ in
            calculator.refresh()
        }
    }
}

#Preview {
    PendulumView(userData: .constant(UserData(pendulumBobColor1: .green, pendulumBobColor2: .black, firstPendulumBobStringColor: .blue, secondPendulumBobStringColor: .brown, lastPositionOfPendulumBob1: nil, lastPositionOfPendulumBob2: nil, firstPendulumBobStringLength: 50, secondPedulumBobStringLength: 30, windowSize: CGSize(width: 500, height: 500))), calculator: Calculator(), timestep: .constant(0.02))
}
