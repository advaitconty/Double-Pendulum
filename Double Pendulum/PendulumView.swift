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
    @StateObject var calculator: Calculator = Calculator(originX: Double(500.0 / 2.0), originY: 50.0, firstPendulumStringLength: 50.0, secondPendulumStringLength: 30.0, pendulumBobMass1: 5.0, pendulumBobMass2: 5.0, angleOfPendulumBob1: (Double.pi / 2.0), angleOfPendulumBob2: (Double.pi / 2.0), gravitationConstant: 9.8, centreOfBob1: CGSize(width: CGFloat(500 / 2), height: CGFloat(50.0) + 50), centreOfBob2: CGSize(width: 500.0 / 2, height: CGFloat(30.0 + 50.0 + 50) + (500.0 / 10)), rotationOfBob1: -90, rotationOfBob2: -90, velocity1: 1.0, velocity2: 1.0, acceleration1: 1.0, acceleration2: 1.0, timestep: 0.02)
    let timer = Timer.publish(every: 1 / 100, on: .main, in: .common).autoconnect()

    func calculateOffsetForString(bob: Int) -> CGFloat {
        if bob == 1 {
            let halfOfLengthOfString: CGFloat = CGFloat(Double(userData.firstPendulumBobStringLength))
            let radiusOfBob: CGFloat = CGFloat((userData.windowSize.height / 10.0) * 0.5)
            return CGFloat(halfOfLengthOfString + radiusOfBob)
        } else {
            let halfOfLengthOfString: CGFloat = CGFloat(Double(userData.secondPedulumBobStringLength))
            let radiusOfBob: CGFloat = CGFloat((userData.windowSize.height / 10.0) * 0.5)
            return CGFloat(halfOfLengthOfString + radiusOfBob * 2)        }
    }
    
    func pendulumBob(bob: Int) -> some View {
        Group {
            ZStack {
                Rectangle()
                    .frame(width: 5, height: calculateOffsetForString(bob: bob))
                    .offset(y: -CGFloat(calculateOffsetForString(bob: bob) * 0.5))
                    .foregroundStyle(bob == 1 ? userData.firstPendulumBobStringColor : userData.secondPendulumBobStringColor)
                Circle()
                    .frame(width: userData.windowSize.height / 10)
                    .foregroundStyle(bob == 1 ? userData.pendulumBobColor1 : userData.pendulumBobColor2)
                //                    .foregroundStyle(.black)
                
            }
        }
    }
    
    
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                pendulumBob(bob: 1)
                    .rotationEffect(Angle(radians: calculator.rotationOfBob1))
                    .position(x: calculator.pivot1X, y: calculator.pivot1X)
                pendulumBob(bob: 2)
                    .rotationEffect(Angle(radians: calculator.rotationOfBob2))
                    .position(x: calculator.pivot2X, y: calculator.pivot2Y)
            }
            .onChange(of: reader.size) {
                width = Double(reader.size.width)
            }
            .onReceive(timer) { _ in
                calculator.refresh()
            }
        }
        .frame(width: userData.windowSize.width, height: userData.windowSize.height)
    }
}

#Preview {
    PendulumView(userData: .constant(UserData(pendulumBobColor1: .green, pendulumBobColor2: .black, firstPendulumBobStringColor: .blue, secondPendulumBobStringColor: .brown, lastPositionOfPendulumBob1: nil, lastPositionOfPendulumBob2: nil, firstPendulumBobStringLength: 50, secondPedulumBobStringLength: 30, windowSize: CGSize(width: 500, height: 500))))
}
