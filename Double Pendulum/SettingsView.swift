//
//  SettingsView.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var userData: UserData
    var body: some View {
        VStack {
            HStack {
                Text("Pendulum Settings")
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
                        ColorPicker("", selection: $userData.pendulumBobColor1)
                    }
                    
                    HStack {
                        Text("String Color")
                            .fontWidth(.condensed)
                        Spacer()
                        ColorPicker("", selection: $userData.firstPendulumBobStringColor)
                    }
                }
                .padding()
            }
            Divider()
            VStack {
                HStack {
                    Text("Window Settings")
                        .fontWidth(.expanded)
                    Spacer()
                }
                HStack {
                    Text("Window Size")
                        .fontWidth(.condensed)
                    Spacer()
                    TextField("Width", value: Binding(
                        get: { Double(userData.windowSize.width) },
                        set: { userData.windowSize.width = CGFloat($0) }
                    ), format: .number)
                    .fontWidth(.compressed)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 100)
                    Text("x")
                        .fontWidth(.compressed)
                    TextField("Height", value: Binding(
                        get: { Double(userData.windowSize.height) },
                        set: { userData.windowSize.height = CGFloat($0) }
                    ), format: .number)
                    .fontWidth(.compressed)
                    .textFieldStyle(.roundedBorder)
                    .frame(maxWidth: 100)
                }
            }
        }
        .padding()
    }
}

#Preview {
    SettingsView(userData: .constant(UserData(pendulumBobColor1: .accentColor, pendulumBobColor2: .black, firstPendulumBobStringColor: .blue, secondPendulumBobStringColor: .brown, lastPositionOfPendulumBob1: nil, lastPositionOfPendulumBob2: nil, firstPendulumBobStringLength: 5, secondPedulumBobStringLength: 30, windowSize: CGSize(width: 500, height: 500))))
}
