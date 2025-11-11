//
//  DataItems.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class UserData {
    var pendulumBobColor1Hex: String = "#ABCDEF"
    var pendulumBobColor2Hex: String = "#ABCDEF"
    var pendulumBobTrail1Hex: String = "#ABCDEF"
    var pendulumBobTrail2Hex: String = "#ABCDEF"
    var firstPendulumBobStringColorHex: String = "#ABCDEF"
    var secondPendulumBobStringColorHex: String = "#ABCDEF"
    
    var pendulumBobMass1: Double = 10.0
    var pendulumBobMass2: Double = 10.0
    var pendulumBobSize1: Double = 40.0
    var pendulumBobSize2: Double = 40.0
    var pendulumBob1TrailDataMaxLength: Int = 75
    var pendulumBob2TrailDataMaxLength: Int = 75
    var gravitationalField: Double = 9.8
    var velocityOfBob1: Double = 0
    var velocityOfBob2: Double = 0
    var lastPositionOfPendulumBob1X: Double? = nil
    var lastPositionOfPendulumBob1Y: Double? = nil
    var lastPositionOfPendulumBob2X: Double? = nil
    var lastPositionOfPendulumBob2Y: Double? = nil
    var lastAccelerationOfPendulumBob1: Double = 0
    var lastAccelerationOfPendulumBob2: Double = 0
    var lastVelocityOfPendulumBob1: Double = 0
    var lastVelocityOfPendulumBob2: Double = 0
    var preferredOriginPositionX: Double = 50.0
    var preferredOriginPositionY: Double = 50.0
    var firstPendulumBobStringLength: Double = 30
    var secondPedulumBobStringLength: Double = 30
    var windowSizeX: Int = 600
    var windowSizeY: Int = 600
    
    var pendulumBobColor1: Color {
        get { Color(hex: pendulumBobColor1Hex) }
        set { pendulumBobColor1Hex = newValue.toHex ?? "#ABCDEF" }
    }
    
    var pendulumBobColor2: Color {
        get { Color(hex: pendulumBobColor2Hex) }
        set { pendulumBobColor2Hex = newValue.toHex  ?? "#ABCDEF" }
    }
    
    var pendulumBobTrail1: Color {
        get { Color(hex: pendulumBobTrail1Hex) }
        set { pendulumBobTrail1Hex = newValue.toHex ?? "#ABCDEF" }
    }
    
    var pendulumBobTrail2: Color {
        get { Color(hex: pendulumBobTrail2Hex) }
        set { pendulumBobTrail2Hex = newValue.toHex ?? "#ABCDEF" }
    }
    
    var firstPendulumBobStringColor: Color {
        get { Color(hex: firstPendulumBobStringColorHex) }
        set { firstPendulumBobStringColorHex = newValue.toHex ?? "#ABCDEF" }
    }
    
    var secondPendulumBobStringColor: Color {
        get { Color(hex: secondPendulumBobStringColorHex) }
        set { secondPendulumBobStringColorHex = newValue.toHex ?? "#ABCDEF" }
    }
    
    init(pendulumBobColor1Hex: String, pendulumBobColor2Hex: String, pendulumBobTrail1Hex: String, pendulumBobTrail2Hex: String, firstPendulumBobStringColorHex: String, secondPendulumBobStringColorHex: String, pendulumBobMass1: Double, pendulumBobMass2: Double, pendulumBobSize1: Double, pendulumBobSize2: Double, pendulumBob1TrailDataMaxLength: Int, pendulumBob2TrailDataMaxLength: Int, gravitationalField: Double, velocityOfBob1: Double, velocityOfBob2: Double, lastPositionOfPendulumBob1X: Double? = nil, lastPositionOfPendulumBob1Y: Double? = nil, lastPositionOfPendulumBob2X: Double? = nil, lastPositionOfPendulumBob2Y: Double? = nil, lastAccelerationOfPendulumBob1: Double, lastAccelerationOfPendulumBob2: Double, lastVelocityOfPendulumBob1: Double, lastVelocityOfPendulumBob2: Double, preferredOriginPositionX: Double, preferredOriginPositionY: Double, firstPendulumBobStringLength: Double, secondPedulumBobStringLength: Double, windowSizeX: Int, windowSizeY: Int) {
        self.pendulumBobColor1Hex = pendulumBobColor1.toHex ?? "#ABCDEF"
        self.pendulumBobColor2Hex = pendulumBobColor2.toHex ?? "#ABCDEF"
        self.pendulumBobTrail1Hex = pendulumBobTrail1.toHex ?? "#ABCDEF"
        self.pendulumBobTrail2Hex = pendulumBobTrail2.toHex ?? "#ABCDEF"
        self.firstPendulumBobStringColorHex = firstPendulumBobStringColor.toHex  ?? "#ABCDEF"
        self.secondPendulumBobStringColorHex = secondPendulumBobStringColor.toHex ?? "#ABCDEF"
        self.pendulumBobMass1 = pendulumBobMass1
        self.pendulumBobMass2 = pendulumBobMass2
        self.pendulumBobSize1 = pendulumBobSize1
        self.pendulumBobSize2 = pendulumBobSize2
        self.pendulumBob1TrailDataMaxLength = pendulumBob1TrailDataMaxLength
        self.pendulumBob2TrailDataMaxLength = pendulumBob2TrailDataMaxLength
        self.gravitationalField = gravitationalField
        self.velocityOfBob1 = velocityOfBob1
        self.velocityOfBob2 = velocityOfBob2
        self.lastPositionOfPendulumBob1X = lastPositionOfPendulumBob1X
        self.lastPositionOfPendulumBob1Y = lastPositionOfPendulumBob1Y
        self.lastPositionOfPendulumBob2X = lastPositionOfPendulumBob2X
        self.lastPositionOfPendulumBob2Y = lastPositionOfPendulumBob2Y
        self.lastAccelerationOfPendulumBob1 = lastAccelerationOfPendulumBob1
        self.lastAccelerationOfPendulumBob2 = lastAccelerationOfPendulumBob2
        self.lastVelocityOfPendulumBob1 = lastVelocityOfPendulumBob1
        self.lastVelocityOfPendulumBob2 = lastVelocityOfPendulumBob2
        self.preferredOriginPositionX = preferredOriginPositionX
        self.preferredOriginPositionY = preferredOriginPositionY
        self.firstPendulumBobStringLength = firstPendulumBobStringLength
        self.secondPedulumBobStringLength = secondPedulumBobStringLength
        self.windowSizeX = windowSizeX
        self.windowSizeY = windowSizeY
    }
}
