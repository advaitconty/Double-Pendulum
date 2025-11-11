//
//  Double_PendulumApp.swift
//  Double Pendulum
//
//  Created by Milind Contractor on 8/11/25.
//

import SwiftUI
import SwiftData

@main
struct Double_PendulumApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: UserData.self)
        }
    }
}
