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
    @Published var trails1: [CGPoint] = []
    @Published var trails2: [CGPoint] = []
    var maxTrailData1: Int = 100
    var maxTrailData2: Int = 100
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
    
    
    
    init() {
        self.originX = 50.0
        self.originY = 50.0
        self.firstPendulumStringLength = 120.0
        self.secondPendulumStringLength = 120.0
        self.pendulumBobMass1 = 50.0
        self.pendulumBobMass2 = 50.0
        self.angleOfPendulumBob1 = (Double.pi / 2)
        self.angleOfPendulumBob2 = Double.pi / 2
        self.gravitationConstant = 9.81
        self.velocity1 = 0.0
        self.velocity2 = 0.0
        self.acceleration1 = 0.0
        self.acceleration2 = 0.0
        self.timestep = 0.02
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
                              (pendulumBobMass1 + pendulumBobMass2) * gravitationConstant * sin(angleOfPendulumBob2)) / D2
        
        self.velocity1 += acceleration1 * timestep
        self.velocity2 += acceleration2 * timestep
        self.angleOfPendulumBob1 += self.velocity1 * timestep
        self.angleOfPendulumBob2 += self.velocity2 * timestep
        
        self.pivot1X = Double(self.originX + self.firstPendulumStringLength * sin(self.angleOfPendulumBob1))
        self.pivot1Y = Double(self.originY + self.firstPendulumStringLength * cos(self.angleOfPendulumBob1))
        self.pivot2X = Double(self.pivot1X + Double(self.secondPendulumStringLength) * Double(sin(self.angleOfPendulumBob2)))
        self.pivot2Y = Double(self.pivot1Y + Double(self.secondPendulumStringLength) * Double(cos(self.angleOfPendulumBob2)))
        
        trails1.append(CGPoint(x: pivot1X, y: pivot1Y))
        trails2.append(CGPoint(x: pivot2X, y: pivot2Y))
        if trails1.count > maxTrailData1 {
            trails1.removeFirst()
        }
        if trails2.count > maxTrailData2 {
            trails2.removeFirst()
        }
    }
}
