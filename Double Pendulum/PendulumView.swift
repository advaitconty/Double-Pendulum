//
//  PendulumView.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI

struct PendulumView: View {
    @Binding var userData: UserData
    
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
                    .position(x: reader.size.width / 2, y: CGFloat(userData.firstPendulumBobStringLength) + 50)
                pendulumBob(bob: 2)
                    .position(x: reader.size.width / 2, y: CGFloat(userData.secondPedulumBobStringLength + userData.firstPendulumBobStringLength + 50) + (userData.windowSize.height / 10))
            }
        }
        .frame(width: userData.windowSize.width, height: userData.windowSize.height)
    }
}

#Preview {
    PendulumView(userData: .constant(UserData(pendulumBobColor1: .green, pendulumBobColor2: .black, firstPendulumBobStringColor: .blue, secondPendulumBobStringColor: .brown, lastPositionOfPendulumBob1: nil, lastPositionOfPendulumBob2: nil, firstPendulumBobStringLength: 50, secondPedulumBobStringLength: 30, windowSize: CGSize(width: 500, height: 500))))
}
