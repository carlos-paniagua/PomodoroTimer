//
//  Home.swift
//  PomodoroTimer
//
//  Created by Carlos Paniagua on 2023/11/13.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var pomodoroModel: PomodoroModel
    @State private var isSettingsVisible = false // 追加
    @State private var isRecordVisible = false // 追加
    @State private var isVibrationOn = false
    @State private var playbutton = false
    @State private var aquarium = false
    
    var body: some View {
        NavigationStack{
            VStack{
                GeometryReader{proxy in
                    VStack(spacing: 15){
                        //MARK: TImer Ring
                        ZStack{
                            Circle()
                                .trim(from:0,to: pomodoroModel.progress)
                                .stroke(Color("White").opacity(0.7),lineWidth:2)
                            
                            HStack(spacing: 0){
                                VStack(spacing: 0){
//                                    Image(systemName: "cup.and.saucer.fill")
//                                        .font(.largeTitle.bold())
//                                        .rotationEffect(.init(degrees: 90))
//                                        .foregroundColor(.white)
//                                        .frame(width: 60, height: 60)
                                    Text(pomodoroModel.timerStringValue2)
                                        .font(.system(size: 20,weight: .light))
                                        .rotationEffect(.init(degrees: 90))
                                        .animation(.none, value: pomodoroModel.progress2)
                                }

                                
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
                        
                        HStack(spacing: 20){
                            //MARK: 記録画面
                            Button{
                                withAnimation {
                                    isRecordVisible.toggle()
                                }
                            }label:{
                                Image(systemName: "trophy.fill")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background{
                                        Circle()
                                            .stroke(Color("White").opacity(0.7),lineWidth:2)
                                    }
                            }
                            
                            //MARK: タイマースタートボタン
                            Button{
                                if (pomodoroModel.workSeconds == 0 && pomodoroModel.workMinutes == 0) || (pomodoroModel.restSeconds == 0 && pomodoroModel.restMinutes == 0) || (pomodoroModel.setCount == 0){
                                }
                                else{
                                    playbutton = true
                                    print(pomodoroModel.workSeconds, terminator: "")
                                    print("TIMER", terminator: "")
                                    print(" ", terminator: "")
                                    print(pomodoroModel.restSeconds, terminator: "")
                                    print("REST")
                                    print(" ", terminator: "")
                                    print(pomodoroModel.setCount, terminator: "")
                                    print("REST")
                                    pomodoroModel.setCount += 1
                                }
                            }label:{
                                Image(systemName: "play.fill")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                                    .frame(width: 120, height: 120)
                                    .background{
                                        Circle()
                                            .stroke(Color("White").opacity(0.7),lineWidth:2)
                                    }
                            }
                            .navigationDestination(isPresented: $playbutton) {TimerActiveView()}
                            .navigationBarHidden(true)
                            //MARK: 設定画面
                            Button{
                                withAnimation {
                                    isSettingsVisible.toggle()
                                }
                            }label:{
                                Image(systemName: "gearshape.fill")
                                    .font(.largeTitle.bold())
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background{
                                        Circle()
                                            .stroke(Color("White").opacity(0.7),lineWidth:2)
                                    }
                            }
                        }
                        
                        Button {
                            aquarium = true
                        } label: {
                            Capsule()
                                .fill(Color("White"))
                                .frame(width: 200, height: 60)
                                .overlay(
                                    HStack {
                                        Image(systemName: "drop.fill")
                                            .font(.largeTitle.bold())
                                            .foregroundColor(.black)
                                        
                                        Text("アクアリウム")
                                            .foregroundColor(.black)
                                    }
                                )
                        }
                        .navigationDestination(isPresented: $aquarium) {Aquarium()}
                        .navigationBarHidden(true)
                    }
                    .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .center)
                }
            }
            .padding()
            .background{
                Color("Blue")
                    .ignoresSafeArea()
            }
            .preferredColorScheme(.dark)
            
            //設定画面詳細
            .sheet(isPresented: $isRecordVisible) {
                VStack{
                    Text("記録")
                        .foregroundColor(.white)
                        .padding()
                    HStack {
                        VStack{
                            Text("クリオネ")
                            Circle()
                            Text("0")
                        }
                        VStack{
                            Text("チンアナゴ")
                            Circle()
                            Text("0")
                        }
                        VStack{
                            Text("?????")
                            Circle()
                            Text("0")
                        }
                    }
                    .foregroundColor(.white)
                    
                    VStack {
                        // Header
                        HStack {
                            Text("Today")
                            Spacer()
                            Text("Total")
                        }
                        .padding()
                        .background(Color("Aquarium"))
                        .foregroundColor(.white)
                        
                        // Content
                        HStack {
                            Text("6h50min")
                            Spacer()
                            Text("618h")
                        }
                        .padding()
                        .background(Color("Aquarium"))
                        .foregroundColor(.white)
                        
                        // Divider
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white)
                    }
                    //                Spacer()
                }
                .padding()
                .background(Color("Aquarium"))
                .foregroundColor(.white)
                .presentationDetents([.large, .height(400), .fraction(0.5)])
            }
            
            //記録画面
            .sheet(isPresented: $isSettingsVisible) {
                VStack {
                    Text("設定")
                        .foregroundColor(.white)
                        .padding()
                    
                    HStack {
                        Text("セット回数")
                        Spacer()
                        Picker("セット回数", selection: $pomodoroModel.setCount) {
                            ForEach(0 ..< 61) {
                                Text("\($0)")
                            }
                        }
                        .foregroundColor(.white)
                    }
                    
                    HStack {
                        Text("作業時間(分)")
                        Spacer()
                        Picker("作業時間", selection: $pomodoroModel.workSeconds) {
                            ForEach(0 ..< 61) {
                                Text("\($0)")
                            }
                        }
                        .foregroundColor(.white)
                        .onChange(of: pomodoroModel.workSeconds) { _ in
                            // Pickerの選択値が変更されたら、タイマーの表示を更新する
                            pomodoroModel.setTimer()
                        }
                    }
                    
                    HStack {
                        Text("休憩時間(分)")
                        Spacer()
                        Picker("休憩時間", selection: $pomodoroModel.restSeconds) {
                            ForEach(0 ..< 61) {
                                Text("\($0)")
                            }
                        }
                        .foregroundColor(.white)
                        .onChange(of: pomodoroModel.restSeconds) { _ in
                            // Pickerの選択値が変更されたら、タイマーの表示を更新する
                            pomodoroModel.setTimer2()
                        }
                    }
                    
                    HStack {
                        Text("バイブレーション")
                        Spacer()
                        Toggle(isOn: $isVibrationOn) {}
                    }
                    Spacer()
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .presentationDetents([.large, .height(400), .fraction(0.5)])
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // RestActiveView が表示されたときに新しいタイマーを開始
            print("onAppear HOME")
            pomodoroModel.timerRestart()
            pomodoroModel.timerRestart2()
            print(pomodoroModel.workSeconds,terminator: "")
            print(pomodoroModel.restSeconds)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PomodoroModel())
    }
}

