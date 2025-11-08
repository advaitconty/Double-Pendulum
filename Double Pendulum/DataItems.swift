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
    var firstPendulumBobStringColor: Color = Color.cyan
    var secondPendulumBobStringColor: Color = Color.orange
    var lastPositionOfPendulumBob1: CGSize?
    var lastPositionOfPendulumBob2: CGSize?
    var firstPendulumBobStringLength: Int = 30
    var secondPedulumBobStringLength: Int = 30
    var windowSize: CGSize = CGSize(width: 600, height: 600)
}
