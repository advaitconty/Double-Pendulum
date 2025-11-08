//
//  DataItems.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class UserData {
    var pendulumBobColor1: Color = Color.green
    var pendulumBobColor2: Color = Color.green
    var firstPendulumBobStringColor: Color = Color.cyan
    var secondPendulumBobStringColor: Color = Color.orange
    var lastPositionOfPendulumBob1: CGSize?
    var lastPositionOfPendulumBob2: CGSize?
    var firstPendulumBobStringLength: Int = 30
    var secondPedulumBobStringLength: Int = 30
    var windowSize: CGSize = CGSize(width: 600, height: 600)
 
    init(pendulumBobColor1: Color, pendulumBobColor2: Color, firstPendulumBobStringColor: Color, secondPendulumBobStringColor: Color, lastPositionOfPendulumBob1: CGSize? = nil, lastPositionOfPendulumBob2: CGSize? = nil, firstPendulumBobStringLength: Int, secondPedulumBobStringLength: Int, windowSize: CGSize) {
        self.pendulumBobColor1 = pendulumBobColor1
        self.pendulumBobColor2 = pendulumBobColor2
        self.firstPendulumBobStringColor = firstPendulumBobStringColor
        self.secondPendulumBobStringColor = secondPendulumBobStringColor
        self.lastPositionOfPendulumBob1 = lastPositionOfPendulumBob1
        self.lastPositionOfPendulumBob2 = lastPositionOfPendulumBob2
        self.firstPendulumBobStringLength = firstPendulumBobStringLength
        self.secondPedulumBobStringLength = secondPedulumBobStringLength
        self.windowSize = windowSize
    }
}
