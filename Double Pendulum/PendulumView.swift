//
//  PendulumView.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI
import Combine

struct PendulumView: View {
    @Binding var userData: UserData
    @State var width: Double = 500
    @ObservedObject var calculator: Calculator
    @Environment(\.colorScheme) var colorScheme
    @Binding var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @Binding var timestep: Double
    @State var originPivotDragOffset: CGSize = CGSize(width: 0, height: 0)
    @Binding var stepsPerFrame: Double
    
    private func midpoint(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
        CGPoint(x: (a.x + b.x) / 2, y: (a.y + b.y) / 2)
    }
    
    private func createTrailPath(from points: [CGPoint]) -> Path {
        var path = Path()
        guard let first = points.first else { return path }
        
        path.move(to: first)
        for i in 1..<points.count {
            let mid = midpoint(points[i - 1], points[i])
            path.addQuadCurve(to: mid, control: points[i-1])
        }
        if let last = points.last {
            path.addLine(to: last)
        }
        return path
    }
    
    var body: some View {
        ZStack {
            Canvas { context, size in
                if !calculator.trails1.isEmpty,
                   let first1 = calculator.trails1.first,
                   let last1 = calculator.trails1.last {
                    let path1 = createTrailPath(from: calculator.trails1)
                    let gradient1 = Gradient(colors: [
                        userData.pendulumBobColor1,
                        userData.pendulumBobColor1,
                        userData.pendulumBobColor1
                    ])
                    context.stroke(
                        path1,
                        with: .linearGradient(gradient1,
                                              startPoint: first1,
                                              endPoint: last1),
                        style: StrokeStyle(lineWidth: 3, lineCap: .round)
                    )
                }
                
                if !calculator.trails2.isEmpty,
                   let first2 = calculator.trails2.first,
                   let last2 = calculator.trails2.last {
                    let path2 = createTrailPath(from: calculator.trails2)
                    let gradient2 = Gradient(colors: [
                        userData.pendulumBobColor2,
                        userData.pendulumBobColor2,
                        userData.pendulumBobColor2
                    ])
                    context.stroke(
                        path2,
                        with: .linearGradient(gradient2,
                                              startPoint: first2,
                                              endPoint: last2),
                        style: StrokeStyle(lineWidth: 3, lineCap: .round)
                    )
                }
            }
            
            Path { path in
                path.move(to: CGPoint(x: calculator.originX, y: calculator.originY))
                path.addLine(to: CGPoint(x: calculator.pivot1X, y: calculator.pivot1Y))
            }
            .stroke(userData.firstPendulumBobStringColor)
            Path { path in
                path.move(to: CGPoint(x: calculator.pivot1X, y: calculator.pivot1Y))
                path.addLine(to: CGPoint(x: calculator.pivot2X, y: calculator.pivot2Y))
            }
            .stroke(userData.secondPendulumBobStringColor)
            .onAppear {
                calculator.refresh()
            }
            Circle()
                .frame(width: 10)
                .position(x: calculator.originX + originPivotDragOffset.width, y: calculator.originY + originPivotDragOffset.height)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            calculator.originX = value.location.x
                            calculator.originY = value.location.y
                            calculator.trails1.removeAll(keepingCapacity: true)
                            calculator.trails2.removeAll(keepingCapacity: true)
                        }
                )
            Circle()
                .frame(width: userData.pendulumBobSize1)
                .position(x: calculator.pivot1X, y: calculator.pivot1Y)
                .foregroundStyle(userData.pendulumBobColor1)
            Circle()
                .frame(width: userData.pendulumBobSize2)
                .position(x: calculator.pivot2X, y: calculator.pivot2Y)
                .foregroundStyle(userData.pendulumBobColor2)
        }
        .frame(width: userData.windowSize.width, height: userData.windowSize.height)
        .onReceive(timer) { _ in
            if !calculator.paused {
                for _ in 0..<Int(stepsPerFrame) {
                    calculator.refresh()
                }
            }
        }
    }
}

