//
//  RestActiveView.swift
//  PomodoroTimer
//
//  Created by Carlos Paniagua on 2023/11/14.
//

import SwiftUI


struct RestActiveView: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    @State private var isFirstButtonVisible2 = true
    @State private var showingAlert2 = false
    @State private var isAlert2: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                GeometryReader{proxy in
                    VStack(spacing: 15){
                        Text("休憩")
                        Text("\(pomodoroModel.setCount)")
                        //MARK: TImer Ring
                        ZStack{
                            Circle()
                                .trim(from:0,to: pomodoroModel.progress2)
                                .stroke(Color("White").opacity(0.7),lineWidth:8)
                            
                            HStack(spacing: 0){
                                Text(pomodoroModel.timerStringValue2)
                                    .font(.system(size: 50,weight: .light))
                                    .rotationEffect(.init(degrees: 90))
                                    .animation(.none, value: pomodoroModel.progress2)
                            }
                        }
                        .padding(60)
                        .frame(height: proxy.size.width)
                        .rotationEffect(.init(degrees: -90))
                        .animation(.easeInOut,value: pomodoroModel.progress2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                        
                        
                        .navigationBarHidden(true)
                        
                        VStack{
                            if isFirstButtonVisible2 {
                                Button{
                                    isFirstButtonVisible2.toggle()
                                    pomodoroModel.pauseTimer2()
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
                                        isFirstButtonVisible2 = true
                                        pomodoroModel.resumeTimer2()
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
                                        self.showingAlert2 = true
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
                                .alert(isPresented: $showingAlert2) {
                                    Alert(title: Text(""),
                                          message: Text("ポモドーロタイマーを中断しますか？"),
                                          primaryButton: .cancel(Text("続ける")),    // キャンセル用
                                          secondaryButton: .destructive(Text("中断"),
                                                                        action: {
                                        isAlert2 = true;
                                        pomodoroModel.isStarted2 = false;
                                        pomodoroModel.stopTimer2();
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
                Color("Blue")
                    .ignoresSafeArea()
            }
            .preferredColorScheme(.dark)
            .navigationDestination(isPresented: $isAlert2) {Home()}
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $pomodoroModel.isFinished2) {TimerActiveView()}
            .navigationBarHidden(true)
            .onAppear {
                // RestActiveView が表示されたときに新しいタイマーを開始
                print("onAppear Rest")
                pomodoroModel.timerRestart2()
                pomodoroModel.startTimer2()
            }
            .onReceive(Timer.publish(every: 1, on: .current, in: .common).autoconnect()) {
                _ in
                if pomodoroModel.isStarted2{
                    if !pomodoroModel.isFinished2{
                        pomodoroModel.updateTimer2()
                    }
                }
            }
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
