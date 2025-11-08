//
//  PendulumView.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI

struct PendulumView: View {
    @Binding var userData: UserData
    
    func pendulumBob(bob: Int) -> some View {
        ZStack {
            Rectangle()
                .frame(width: 5, height: userData.windowSize.width / 2.5)
                .offset(y: -userData.windowSize.height / 5)
                .foregroundStyle(bob == 1 ? userData.firstPendulumBobStringColor : userData.secondPendulumBobStringColor)
            Circle()
                .frame(width: userData.windowSize.height / 10)
                .foregroundStyle(bob == 1 ? userData.pendulumBobColor1 : userData.pendulumBobColor2)
        }
    }
    
    var body: some View {
        VStack {
            pendulumBob(bob: 1)
            pendulumBob(bob: 2)
        }
        .frame(width: userData.windowSize.width, height: userData.windowSize.height)
    }
}

#Preview {
    PendulumView(userData: .constant(UserData(pendulumBobColor1: .accentColor, pendulumBobColor2: .black, firstPendulumBobStringColor: .blue, secondPendulumBobStringColor: .brown, lastPositionOfPendulumBob1: nil, lastPositionOfPendulumBob2: nil, firstPendulumBobStringLength: 5, secondPedulumBobStringLength: 30, windowSize: CGSize(width: 500, height: 500))))
}
