//
//  DataItems.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import Foundation
import SwiftUI

struct UserData: Codable {
    var pendulumBobColor1: Color = Color.red
    var pendulumBobColor2: Color = Color.green
    var pendulumBobMass1: Double = 10.0
    var pendulumBobMass2: Double = 10.0
    var gravitationalField: Double = 9.8
    var velocityOfBob1: Double = 0
    var velocityOfBob2: Double = 0
    var firstPendulumBobStringColor: Color = Color.cyan
    var secondPendulumBobStringColor: Color = Color.orange
    var lastPositionOfPendulumBob1: CGSize?
    var lastPositionOfPendulumBob2: CGSize?
    var firstPendulumBobStringLength: Double = 30
    var secondPedulumBobStringLength: Double = 30
    var windowSize: CGSize = CGSize(width: 600, height: 600)
}
