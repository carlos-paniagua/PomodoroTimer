//
//  TimerActiveView.swift
//  PomodoroTimer
//
//  Created by Carlos Paniagua on 2023/11/13.
//

import SwiftUI

struct TimerActiveView: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    @State private var isFirstButtonVisible = true
    @State private var showingAlert = false
    @State private var isAlert = false
    
    var body: some View {
        NavigationStack{
            VStack{
                GeometryReader{proxy in
                    VStack(spacing: 15){
                        Text("作業")
                        Text("\(pomodoroModel.setCount)")
                        
                        //MARK: TImer Ring
                        ZStack{
                            Circle()
                                .trim(from:0,to: pomodoroModel.progress)
                                .stroke(Color("White").opacity(0.7),lineWidth:8)
                            
                            HStack(spacing: 0){
                                Text(pomodoroModel.timerStringValue)
                                    .font(.system(size: 50,weight: .light))
                                    .rotationEffect(.init(degrees: 90))
                                    .animation(.none, value: pomodoroModel.progress)
                            }
                        }
                        .padding(60)
                        .frame(height: proxy.size.width)
                        .rotationEffect(.init(degrees: -90))
                        .animation(.easeInOut,value: pomodoroModel.progress)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
                        VStack{
                            if isFirstButtonVisible {
                                Button{
                                    isFirstButtonVisible.toggle()
                                    pomodoroModel.pauseTimer()
                                }label:{
                                    Image(systemName: "pause")
                                        .font(.largeTitle.bold())
                                        .foregroundColor(.white)
                                        .frame(width: 120, height: 120)
                                        .background{
                                            Circle()
                                                .stroke(Color("White").opacity(0.7),lineWidth:2)
                                        }
                                }
                            }else{
                                HStack {
                                    Button{
                                        isFirstButtonVisible = true
                                        pomodoroModel.resumeTimer()
                                    }label:{
                                        Image(systemName: "play.fill")
                                            .font(.largeTitle.bold())
                                            .foregroundColor(.white)
                                            .frame(width: 120, height: 120)
                                            .background{
                                                Circle()
                                                    .foregroundColor(Color("Green"))
                                            }
                                    }
                                    .padding()
                                    
                                    Button {
                                        self.showingAlert = true
                                    }label:{
                                        Image(systemName: "xmark")
                                            .font(.largeTitle.bold())
                                            .foregroundColor(.white)
                                            .frame(width: 120, height: 120)
                                            .background{
                                                Circle()
                                                    .fill(Color("BG"))  // Use 'fill' instead of 'foregroundColor' for filling the circle
                                                    .overlay(
                                                        Circle()
                                                            .stroke(Color("White").opacity(0.7), lineWidth: 2)
                                                    )
                                            }
                                    }
                                }
                                .alert(isPresented: $showingAlert) {
                                    Alert(title: Text(""),
                                          message: Text("ポモドーロタイマーを中断しますか？"),
                                          primaryButton: .cancel(Text("続ける")),    // キャンセル用
                                          secondaryButton: .destructive(Text("中断"),
                                                                        action: {
                                        isAlert = true;
                                        pomodoroModel.isStarted = false;
                                        pomodoroModel.stopTimer();
                                        pomodoroModel.timerRestart();
                                        pomodoroModel.timerRestart2();
                                    }))
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                }
            }
            .padding()
            .background{
                Color("BG")
                    .ignoresSafeArea()
            }
            .navigationDestination(isPresented: $isAlert) {Home()}
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $pomodoroModel.isFinished) {RestActiveView()}
            .navigationBarHidden(true)
            .onAppear {
                // RestActiveView が表示されたときに新しいタイマーを開始
                print("onAppear Timer")
                pomodoroModel.timerRestart()
                pomodoroModel.startTimer()
                pomodoroModel.setCount -= 1
                if pomodoroModel.setCount == 0{
                    isAlert = true
                }
            }
            .onReceive(Timer.publish(every: 1, on: .current, in: .common).autoconnect()) {
                _ in
                if pomodoroModel.isStarted{
                    if !pomodoroModel.isFinished{
                        pomodoroModel.updateTimer()
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
        .navigationBarBackButtonHidden(true)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(PomodoroModel())
//    }
//}
