//
//  Manager.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//


import Foundation
import Combine

class Calculator: ObservableObject {
    var originX: Double
    var originY: Double
    @Published var firstPendulumStringLength: Double
    @Published var secondPendulumStringLength: Double
    @Published var pendulumBobMass1: Double
    @Published var pendulumBobMass2: Double
    @Published var angleOfPendulumBob1: Double
    @Published var angleOfPendulumBob2: Double
    @Published var gravitationConstant: Double
    var pivot1X: Double = 0
    var pivot1Y: Double = 0
    var pivot2X: Double = 0
    var pivot2Y: Double = 0
    var delta: Double {
        return self.angleOfPendulumBob1 - self.angleOfPendulumBob2
    }
    
    // Acceleration and velocity stuff
    var velocity1: Double = 0
    var velocity2: Double = 0
    var acceleration1: Double = 0
    var acceleration2: Double = 0
    
    // Computed values of D1/D2
    var D1: Double {
        return (self.pendulumBobMass1 + self.pendulumBobMass2) * self.firstPendulumStringLength - self.pendulumBobMass2 * self.firstPendulumStringLength * pow(cos(delta), 2)
    }
    var D2: Double {
        return (self.secondPendulumStringLength / self.firstPendulumStringLength) * self.D1
    }
    
    @Published var timestep: Double = 0.02
    
    
    
    init(originX: Double, originY: Double, firstPendulumStringLength: Double, secondPendulumStringLength: Double, pendulumBobMass1: Double, pendulumBobMass2: Double, angleOfPendulumBob1: Double, angleOfPendulumBob2: Double, gravitationConstant: Double, velocity1: Double, velocity2: Double, acceleration1: Double, acceleration2: Double, timestep: Double) {
        self.originX = originX
        self.originY = originY
        self.firstPendulumStringLength = firstPendulumStringLength
        self.secondPendulumStringLength = secondPendulumStringLength
        self.pendulumBobMass1 = pendulumBobMass1
        self.pendulumBobMass2 = pendulumBobMass2
        self.angleOfPendulumBob1 = angleOfPendulumBob1
        self.angleOfPendulumBob2 = angleOfPendulumBob2
        self.gravitationConstant = gravitationConstant
        self.velocity1 = velocity1
        self.velocity2 = velocity2
        self.acceleration1 = acceleration1
        self.acceleration2 = acceleration2
        self.timestep = timestep
    }
    
    func refresh() {
        // Basic calculations from the equations provided in teh paper
        self.acceleration1 = (pendulumBobMass2 * firstPendulumStringLength * pow(velocity1, 2) * sin(delta) * cos(delta) +
                              pendulumBobMass2 * gravitationConstant * sin(angleOfPendulumBob2) * cos(delta) +
                              pendulumBobMass2 * secondPendulumStringLength * pow(velocity2, 2) * sin(delta) -
                              (pendulumBobMass1 + pendulumBobMass2) * gravitationConstant * sin(angleOfPendulumBob1)) / D1
        self.acceleration2 = ((-1 * pendulumBobMass2 * secondPendulumStringLength * pow(velocity2, 2) * sin(delta) * cos(delta)) +
                              (pendulumBobMass1 + pendulumBobMass2) * gravitationConstant * sin(angleOfPendulumBob1) * cos(delta) -
                              (pendulumBobMass1 + pendulumBobMass2) * firstPendulumStringLength * pow(velocity1, 2) * sin(delta) -
                              (pendulumBobMass1 + pendulumBobMass2) * gravitationConstant * sin(angleOfPendulumBob2) ) / D2
        self.velocity1 += acceleration1 * timestep
        self.velocity2 += acceleration2 * timestep
        self.angleOfPendulumBob1 += self.velocity1 * timestep
        self.angleOfPendulumBob2 += self.velocity2 * timestep
        
        self.pivot1X = Double(self.originX + self.firstPendulumStringLength * sin(self.angleOfPendulumBob1))
        self.pivot1Y = Double(self.originY + self.firstPendulumStringLength * cos(self.angleOfPendulumBob1))
        self.pivot2X = Double(self.pivot1X + Double(self.secondPendulumStringLength) * Double(sin(self.angleOfPendulumBob2)))
        self.pivot2Y = Double(self.pivot1Y + Double(self.secondPendulumStringLength) * Double(cos(self.angleOfPendulumBob2)))
    }
}
