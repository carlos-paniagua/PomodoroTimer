//
//  PomodoroTimerApp.swift
//  PomodoroTimer
//
//  Created by Carlos Paniagua on 2023/11/13.
//

import SwiftUI

@main
struct PomodoroTimerApp: App {
    //MARK; Since WE\ere doing Background fetching Initializing Here
    @StateObject var pomodoroModel: PomodoroModel = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
        }
    }
}
