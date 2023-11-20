//
//  PomodoroModel.swift
//  PomodoroTimer
//
//  Created by Carlos Paniagua on 2023/11/13.
//

import SwiftUI

class PomodoroModel: NSObject, ObservableObject{
    //MARK: Timer Properties
    @Published var progress: CGFloat = 1
    @Published var timerStringValue: String = "00:00"
    @Published var isStarted = false
    @Published var addNewTimer = false
    @Published var isPaused = false
    
    @Published var progress2: CGFloat = 1
    @Published var timerStringValue2: String = "00:00"
    @Published var isStarted2 = false
    @Published var addNewTimer2 = false
    @Published var isPaused2 = false
    
    @Published var workMinutes: Int = 0
    @Published var workSeconds: Int = 0
    
    @Published var restMinutes: Int = 0
    @Published var restSeconds: Int = 0
    
    //MARK: total seconds
    @Published var totalSeconds: Int = 0
    @Published var totalSeconds2: Int = 0
    @Published var staticTotalSeconds: Int = 0
    @Published var staticTotalSeconds2: Int = 0
    
    //MARK: Post Timer Properties
    @Published var isFinished: Bool = false
    @Published var isFinished2: Bool  = false
    
    @Published var setCount: Int = 0
    
    //    @Published var workHours: Int = 0
    @Published var bufworkMinutes: Int = 0
    @Published var bufworkSeconds: Int = 0
    
//   @Published var resthours: Int = 0
    @Published var bufrestMinutes: Int = 0
    @Published var bufrestSeconds: Int = 0
    
    override init() {
        super.init()
        // 初期値を設定
        workSeconds = 5
        restSeconds = 5
        setTimer()
        setTimer2()
    }
    
//   ---------------------------------------------------------
    func savetime1(){
        bufworkMinutes = workMinutes
        bufworkSeconds = workSeconds
        print("TIMER saved to buf")
    }
    
    func savetime2(){
        bufrestMinutes = restMinutes
        bufrestSeconds = restSeconds
        print("REST saved to buf")
    }
    
//   ---------------------------------------------------------
    
    func timerRestart(){
        workMinutes = bufworkMinutes
        workSeconds = bufworkSeconds
        timerStringValue = "\(workMinutes >= 10 ? "\(workMinutes)":"0\(workMinutes)"):\(workSeconds >= 10 ? "\(workSeconds)":"0\(workSeconds)")"
        isStarted = true
        isFinished = false
        progress = 1
        print("TIMER re set")
    }
    
    func timerRestart2(){
        restMinutes = bufrestMinutes
        restSeconds = bufrestSeconds
        timerStringValue2 = "\(restMinutes >= 10 ? "\(restMinutes)":"0\(restMinutes)"):\(restSeconds >= 10 ? "\(restSeconds)":"0\(restSeconds)")"
        isStarted2 = true
        isFinished2 = false
        progress2 = 1
        print("REST re set")
    }
//   ---------------------------------------------------------

    func setTimer(){
        // タイマーの初期値を設定する
        savetime1()
        //MARK: setting string time value
        timerStringValue = "\(workMinutes >= 10 ? "\(workMinutes)":"0\(workMinutes)"):\(workSeconds >= 10 ? "\(workSeconds)":"0\(workSeconds)")"
        
        print("TIMER set")
    }
    
    func startTimer(){
        withAnimation(.easeInOut(duration: 0.25)){
            isStarted = true
            isPaused = false
        }
        
        //MARK: setting string time value
        timerStringValue = "\(workMinutes >= 10 ? "\(workMinutes)":"0\(workMinutes)"):\(workSeconds >= 10 ? "\(workSeconds)":"0\(workSeconds)")"
        
        //MARK: calculating total seconds for timer animation
        totalSeconds = (workMinutes * 60) + workSeconds
        staticTotalSeconds = totalSeconds

        print("TIMER start")
    }

    func pauseTimer() {
            withAnimation(.easeInOut(duration: 0.25)){
                isPaused = true
            }
        print("TIMER paused")
        }

    func resumeTimer() {
        withAnimation(.easeInOut(duration: 0.25)){
            isPaused = false
        }
        print("TIMER resumed")
    }
    
    func stopTimer(){
        withAnimation(.easeInOut(duration: 0.25)){
            workMinutes = 0
            workSeconds = 0
            progress = 1
            isFinished = false
        }
        totalSeconds = 0
        staticTotalSeconds = 0
        
        print("TIMER stoped")
    }
    
    func updateTimer(){
        guard !isPaused else {
            return
        }
        
        totalSeconds -= 1
        progress = CGFloat(totalSeconds)/CGFloat(staticTotalSeconds)
        progress = (progress < 0 ? 0 : progress)
        workMinutes = (totalSeconds / 60) % 60
        workSeconds = (totalSeconds % 60)
        timerStringValue = "\(workMinutes >= 10 ? "\(workMinutes)":"0\(workMinutes)"):\(workSeconds >= 10 ? "\(workSeconds)":"0\(workSeconds)")"
        if workSeconds == 0 && workMinutes == 0 && totalSeconds == 0{
            isFinished = true
        }
        print(timerStringValue, terminator: "")
        print("TIMER", terminator: "")
    }
    
//   ---------------------------------------------------------
    func setTimer2(){
        // タイマーの初期値を設定する
        savetime2()
        //MARK: setting string time value
        timerStringValue2 = "\(restMinutes >= 10 ? "\(restMinutes)":"0\(restMinutes)"):\(restSeconds >= 10 ? "\(restSeconds)":"0\(restSeconds)")"
        
        print("REST set")
    }
    
    func startTimer2(){
        withAnimation(.easeInOut(duration: 0.25)){
            isStarted2 = true
            isPaused2 = false
        }
        
        //MARK: setting string time value
        timerStringValue2 = "\(restMinutes >= 10 ? "\(restMinutes)":"0\(restMinutes)"):\(restSeconds >= 10 ? "\(restSeconds)":"0\(restSeconds)")"
    
        //MARK: calculating total seconds for timer animation
        totalSeconds2 = (restMinutes * 60) + restSeconds
        staticTotalSeconds2 = totalSeconds2
        print("REST start")
    }
    
    func pauseTimer2() {
            withAnimation(.easeInOut(duration: 0.25)){
                isPaused2 = true
            }
        print("REST paused")
        }

    func resumeTimer2() {
        withAnimation(.easeInOut(duration: 0.25)){
            isPaused2 = false
        }
        print("REST resumed")
    }
    
    func stopTimer2(){
        withAnimation(.easeInOut(duration: 0.25)){
            restMinutes = 0
            restSeconds = 0
            progress2 = 1
            isFinished2 = false
        }
        totalSeconds2 = 0
        staticTotalSeconds2 = 0
//        timerStringValue2 = "00:00"
        
        print("REST stopped")
    }
    
    func updateTimer2(){
        guard !isPaused2 else {
            return
        }
        
        totalSeconds2 -= 1
        progress2 = CGFloat(totalSeconds2)/CGFloat(staticTotalSeconds2)
        progress2 = (progress2 < 0 ? 0 : progress2)
        restMinutes = (totalSeconds2 / 60) % 60
        restSeconds = (totalSeconds2 % 60)
        
        timerStringValue2 = "\(restMinutes >= 10 ? "\(restMinutes)":"0\(restMinutes)"):\(restSeconds >= 10 ? "\(restSeconds)":"0\(restSeconds)")"
        if restSeconds == 0 && restMinutes == 0 && totalSeconds2 == 0{
            isFinished2 = true
        }
        print(timerStringValue2,terminator: "")
        print("REST", terminator: "")
    }
}
