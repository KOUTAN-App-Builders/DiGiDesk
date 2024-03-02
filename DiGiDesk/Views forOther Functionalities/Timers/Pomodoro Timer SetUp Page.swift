//
//  Pomodoro Timer SetUp Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/02/28.
//

import SwiftUI

struct Pomodoro_Timer_SetUp_Page: View {
    
    @State private var InitialFocusTime: Int = 1500
    @State private var RemainingFocusTime: Int = 1500
    @State private var InitialIntervalTime: Int = 300
    @State private var RemainingIntervalTime: Int = 300
    @State private var isTimerRunning: Bool = false
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            ZStack{
                ProgressView(value: Double(RemainingFocusTime) / Double(InitialFocusTime))
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                VStack{
                    Text(secondsToMinutesAndSeconds(RemainingFocusTime))
                        .font(.largeTitle)
                        .padding()
                    HStack{
                        Button(action: {isTimerRunning.toggle()}, label: {
                            Text(isTimerRunning ? "Pause" : "Start")
                                .padding()
                                .foregroundStyle(Color.white)
                                .background(isTimerRunning ? Color.red : Color.green)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        })
                        Button(action: {RemainingFocusTime = InitialFocusTime}, label: {
                            Image(systemName: "arrow.counterclockwise")
                                .frame(width: 30, height: 30)
                                .background(Color.green)
                                .foregroundStyle(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding()
                        })
                    }
                }
            }
            Divider()
            Text("Timer Settings")
                .font(.largeTitle)
                .bold()
            Text("Focus Time: \(secondsToMinutesAndSeconds(InitialFocusTime))")
                .font(.headline)
            Stepper{
                Text("Adjust by Hour")
            }onIncrement: {
                incrementFocusTimeByHour()
            }onDecrement: {
                decrementFocusTimeByHour()
            }
            Stepper{
                Text("Adjust by Minute")
            }onIncrement: {
                incrementFocusTimeByMinute()
            }onDecrement: {
                decrementFocusTimeByMinute()
            }
            Stepper(value: $InitialFocusTime, in: 0...86399) {
                Text("Adjust by Second")
            }
            Text("Interval Time: \(secondsToMinutesAndSeconds(InitialIntervalTime))")
                .font(.headline)
            Stepper{
                Text("Adjust by Hour")
            }onIncrement: {
                incrementIntervalTimeByHour()
            }onDecrement: {
                decrementIntervalTimeByHour()
            }
            Stepper{
                Text("Adjust by Minute")
            }onIncrement: {
                incrementIntervalTimeByMinute()
            }onDecrement: {
                decrementIntervalTimeByMinute()
            }
            Stepper(value: $InitialIntervalTime, in: 0...86399) {
                Text("Adjust by Second")
            }
        }
        .navigationTitle("Pomodoro Timer")
        .padding(.horizontal)
        .onReceive(timer){ _ in
            if isTimerRunning{
                if RemainingFocusTime > 0{
                    RemainingFocusTime -= 1
                }else{
                    if RemainingIntervalTime > 0{
                        RemainingIntervalTime -= 1
                    }else{
                        RemainingFocusTime = InitialFocusTime
                    }
                }
            }else{
                isTimerRunning = false
                RemainingFocusTime = InitialFocusTime
            }
        }
    }
    private func secondsToMinutesAndSeconds(_ seconds: Int) -> String{
        let hours = seconds / 3600
        let remainingMinutes = seconds % 3600 / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d:%02d" , hours, remainingMinutes, remainingSeconds)
    }
    func incrementFocusTimeByHour(){
        InitialFocusTime += 3600
        if InitialFocusTime >= 86399{
            InitialFocusTime = 86399
        }
    }
    func incrementFocusTimeByMinute(){
        InitialFocusTime += 60
        if InitialFocusTime >= 86399{
            InitialFocusTime = 86399
        }
    }
    func decrementFocusTimeByHour(){
        InitialFocusTime -= 3600
        if InitialFocusTime <= 0{
            InitialFocusTime = 0
        }
    }
    func decrementFocusTimeByMinute(){
        InitialFocusTime -= 60
        if InitialFocusTime <= 0{
            InitialFocusTime = 0
        }
    }
    func incrementIntervalTimeByHour(){
        InitialIntervalTime += 3600
        if InitialIntervalTime >= 86399{
            InitialIntervalTime = 86399
        }
    }
    func incrementIntervalTimeByMinute(){
        InitialIntervalTime += 60
        if InitialIntervalTime >= 86399{
            InitialIntervalTime = 86399
        }
    }
    func decrementIntervalTimeByHour(){
        InitialIntervalTime -= 3600
        if InitialIntervalTime <= 0{
            InitialIntervalTime = 0
        }
    }
    func decrementIntervalTimeByMinute(){
        InitialIntervalTime -= 60
        if InitialIntervalTime <= 0{
            InitialIntervalTime = 0
        }
    }
}

#Preview {
    NavigationView{
        Pomodoro_Timer_SetUp_Page()
    }
}
