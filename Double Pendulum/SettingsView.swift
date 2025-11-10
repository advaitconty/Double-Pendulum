//
//  SettingsView.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI
import CompactSlider

struct SettingsView: View {
    @Binding var userData: UserData
    @Binding var timestep: Double
    @Binding var stepsPerFrame: Double
    var body: some View {
        VStack {
            HStack {
                Text("Simulation Settings")
                    .fontWidth(.expanded)
                Spacer()
            }
            Divider()
            HStack {
                VStack {
                    HStack {
                        Text("Pendulum Bob 1")
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    HStack {
                        Text("Bob Color")
                            .fontWidth(.condensed)
                        Spacer()
                        ColorPicker("", selection: $userData.pendulumBobColor1)
                    }
                    
                    HStack {
                        Text("String Color")
                            .fontWidth(.condensed)
                        Spacer()
                        ColorPicker("", selection: $userData.firstPendulumBobStringColor)
                    }
                    HStack {
                        Text("Pendulum Trail Color")
                            .fontWidth(.condensed)
                        Spacer()
                        ColorPicker("", selection: $userData.pendulumBobTrail1)
                    }
                    HStack {
                        Text("Pendulum Size (Diamater in pixels)")
                            .fontWidth(.condensed)
                        Spacer()
                        TextField("Diameter (px)", value: $userData.pendulumBobSize1, format: .number)
                            .fontWidth(.compressed)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 100)
                    }
                    
                    HStack {
                        Text("Pendulum String Size (Length in pixels)")
                            .fontWidth(.condensed)
                        Spacer()
                        TextField("Diameter (px)", value: $userData.firstPendulumBobStringLength, format: .number)
                            .fontWidth(.compressed)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 100)
                    }
                }
                .padding()
                
                Divider()
                    .frame(maxHeight: 100)
                VStack {
                    HStack {
                        Text("Pendulum Bob 2")
                            .fontWidth(.expanded)
                        Spacer()
                    }
                    HStack {
                        Text("Bob Color")
                            .fontWidth(.condensed)
                        Spacer()
                        ColorPicker("", selection: $userData.pendulumBobColor2)
                    }
                    
                    HStack {
                        Text("String Color")
                            .fontWidth(.condensed)
                        Spacer()
                        ColorPicker("", selection: $userData.secondPendulumBobStringColor)
                    }
                    HStack {
                        Text("Pendulum Trail Color")
                            .fontWidth(.condensed)
                        Spacer()
                        ColorPicker("", selection: $userData.pendulumBobTrail2)
                    }
                    HStack {
                        Text("Pendulum Size (Diamater in pixels)")
                            .fontWidth(.condensed)
                        Spacer()
                        TextField("Diameter (px)", value: $userData.pendulumBobSize2, format: .number)
                            .fontWidth(.compressed)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 100)
                    }
                    
                    HStack {
                        Text("Pendulum String Size (Length in pixels)")
                            .fontWidth(.condensed)
                        Spacer()
                        TextField("Diameter (px)", value: $userData.secondPedulumBobStringLength, format: .number)
                            .fontWidth(.compressed)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: 100)
                    }
                }
                .padding()
            }
            Divider()
            HStack {
                Text("Timestep (\(String(format: "%.3f", timestep)))\n(controls the stability of this chaotic system)")
                    .fontWidth(.condensed)
                    .italic()
                Spacer()
                CompactSlider(value: $timestep, in: 0.01...0.1, step: 0.005)
                    .compactSliderStyle(default: .horizontal())
                    .compactSliderOptions(.enabledHapticFeedback)
                    .compactSliderHandleStyle(.roundedRectangle())
                    .frame(width: 200, height: 20)
            }
            HStack {
                Text("Steps per frame (\(stepsPerFrame)fps)\nAffects the speed of the simulation")
                    .fontWidth(.condensed)
                    .italic()
                Spacer()
                CompactSlider(value: $stepsPerFrame, in: 1...200, step: 1)
                    .compactSliderStyle(default: .horizontal())
                    .compactSliderOptions(.enabledHapticFeedback)
                    .compactSliderHandleStyle(.roundedRectangle())
                    .frame(width: 200, height: 20)
            }
        }
        .padding()
    }
}
