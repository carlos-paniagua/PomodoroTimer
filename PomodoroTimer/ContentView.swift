//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Carlos Paniagua on 2023/11/13.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    
    var body: some View {
        Home().environmentObject(PomodoroModel())
//        TimerActiveView().environmentObject(PomodoroModel())
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
