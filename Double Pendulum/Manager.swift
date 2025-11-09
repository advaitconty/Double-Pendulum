//
//  Manager.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//


import Foundation
import Combine

class Calculator: ObservableObject {
    @Published var originX: Float
    @Published var originY: Float
    @Published var firstPendulumStringLength: Float
    @Published var secondPendulumStringLength: Float
    @Published var pendulumBobMass1: Float
    @Published var pendulumBobMass2: Float
    @Published var angleOfPendulumBob1: Float
    @Published var angleOfPendulumBob2: Float
    @Published var gravitationConstant: Float
    var pivot1X: CGFloat {
        return CGFloat(self.originX + self.firstPendulumStringLength * sin(self.angleOfPendulumBob1))
    }
    var pivot1Y: CGFloat {
        return CGFloat(self.originY + self.firstPendulumStringLength * cos(self.angleOfPendulumBob1))
    }
    var pivot2X: CGFloat {
        return CGFloat(self.pivot1X + CGFloat(self.secondPendulumStringLength) * CGFloat(sin(self.angleOfPendulumBob2)))
    }
    var pivot2Y: CGFloat {
        return CGFloat(self.pivot1Y + CGFloat(self.secondPendulumStringLength) * CGFloat(cos(self.angleOfPendulumBob2)))
    }
    var delta: Float {
        return self.angleOfPendulumBob1 - self.angleOfPendulumBob2
    }
    
    // Computed properties for the centre of the circle, and their rotations - computed in Refresh
    @Published var centreOfBob1: CGSize
    @Published var centreOfBob2: CGSize
    @Published var rotationOfBob1: Float
    @Published var rotationOfBob2: Float
    
    // Acceleration and velocity stuff
    var velocity1: Float = 0
    var velocity2: Float = 0
    var acceleration1: Float = 0
    var acceleration2: Float = 0

    
    init(originX: Float, originY: Float, firstPendulumStringLength: Float, secondPendulumStringLength: Float, pendulumBobMass1: Float, pendulumBobMass2: Float, angleOfPendulumBob1: Float, angleOfPendulumBob2: Float, gravitationConstant: Float = 9.8, centreOfBob1: CGSize, centreOfBob2: CGSize, rotationOfBob1: Float = 90, rotationOfBob2: Float = 90, velocity1: Float, velocity2: Float, acceleration1: Float, acceleration2: Float) {
        self.originX = originX
        self.originY = originY
        self.firstPendulumStringLength = firstPendulumStringLength
        self.secondPendulumStringLength = secondPendulumStringLength
        self.pendulumBobMass1 = pendulumBobMass1
        self.pendulumBobMass2 = pendulumBobMass2
        self.angleOfPendulumBob1 = angleOfPendulumBob1
        self.angleOfPendulumBob2 = angleOfPendulumBob2
        self.gravitationConstant = gravitationConstant
        self.centreOfBob1 = centreOfBob1
        self.centreOfBob2 = centreOfBob2
        self.rotationOfBob1 = rotationOfBob1
        self.rotationOfBob2 = rotationOfBob2
        self.velocity1 = velocity1
        self.velocity2 = velocity2
        self.acceleration1 = acceleration1
        self.acceleration2 = acceleration2
    }
    
    func refresh() {
        self.velocity1 = pendulumBobMass2 * firstPendulumStringLength * acceleration1^2 * sin(delta) * cos(delta) + pendulumBobMass2 * gravitationConstant * sin(rotationOfBob2) * cos(delta) + pendulumBobMass2 * secondPendulumStringLength * acceleration2^2 * sin(delta) - (pendulumBobMass1 + pendulumBobMass2) * gravitationConstant * sin(rotationOfBob2)
    }
}
