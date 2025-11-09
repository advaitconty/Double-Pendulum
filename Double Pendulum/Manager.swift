//
//  Manager.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//


import Foundation
import Combine

class Calculator: ObservableObject {
    @Published var originX: Double
    @Published var originY: Double
    @Published var firstPendulumStringLength: Double
    @Published var secondPendulumStringLength: Double
    @Published var pendulumBobMass1: Double
    @Published var pendulumBobMass2: Double
    @Published var angleOfPendulumBob1: Double
    @Published var angleOfPendulumBob2: Double
    @Published var gravitationConstant: Double
    var pivot1X: Double {
        return Double(self.originX + self.firstPendulumStringLength * sin(self.angleOfPendulumBob1))
    }
    var pivot1Y: Double {
        return Double(self.originY + self.firstPendulumStringLength * cos(self.angleOfPendulumBob1))
    }
    var pivot2X: Double {
        return Double(self.pivot1X + CGFloat(self.secondPendulumStringLength) * CGFloat(sin(self.angleOfPendulumBob2)))
    }
    var pivot2Y: Double {
        return Double(self.pivot1Y + CGFloat(self.secondPendulumStringLength) * CGFloat(cos(self.angleOfPendulumBob2)))
    }
    var delta: Double {
        return self.angleOfPendulumBob1 - self.angleOfPendulumBob2
    }
    
    // Computed properties for the centre of the circle, and their rotations - computed in Refresh
    @Published var centreOfBob1: CGSize
    @Published var centreOfBob2: CGSize
    @Published var rotationOfBob1: Double
    @Published var rotationOfBob2: Double
    
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
        return (self.firstPendulumStringLength / self.secondPendulumStringLength) * self.D1
    }
    
    @Published var timestep: Double = 0.02


    
    init(originX: Double, originY: Double, firstPendulumStringLength: Double, secondPendulumStringLength: Double, pendulumBobMass1: Double, pendulumBobMass2: Double, angleOfPendulumBob1: Double, angleOfPendulumBob2: Double, gravitationConstant: Double, centreOfBob1: CGSize, centreOfBob2: CGSize, rotationOfBob1: Double, rotationOfBob2: Double, velocity1: Double, velocity2: Double, acceleration1: Double, acceleration2: Double, timestep: Double) {
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
        self.timestep = timestep
    }
    
    func refresh() {
        // Basic calculations from the equations provided in teh paper
        self.acceleration1 = (pendulumBobMass2 * firstPendulumStringLength * pow(acceleration1, 2) * sin(delta) * cos(delta) + pendulumBobMass2 * gravitationConstant * sin(rotationOfBob2) * cos(delta) + pendulumBobMass2 * secondPendulumStringLength * pow(acceleration2, 2) * sin(delta) - (pendulumBobMass1 + pendulumBobMass2) * gravitationConstant * sin(rotationOfBob2)) / D1
        self.acceleration2 = (-1 * pendulumBobMass2 * firstPendulumStringLength * pow(velocity1, 2) * sin(delta) * cos(delta) + (pendulumBobMass1 + pendulumBobMass2) * gravitationConstant * sin(angleOfPendulumBob1) * cos(delta) - (pendulumBobMass1 + pendulumBobMass2) * firstPendulumStringLength * pow(velocity1, 2) * sin(delta) - (pendulumBobMass1 + pendulumBobMass2) * gravitationConstant * sin(angleOfPendulumBob2)) / D2
        self.velocity1 += acceleration1 * timestep
        self.velocity2 += acceleration2 * timestep
        self.angleOfPendulumBob1 += self.velocity1 * timestep
        self.angleOfPendulumBob2 += self.velocity2 * timestep
        
        // The fun part - made because the Bob is the center for me and not the actual pivot
        
    }
}
