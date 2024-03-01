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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            ProgressView(value: Double(RemainingFocusTime) / Double(InitialFocusTime))
                .progressViewStyle(CircularProgressViewStyle())
            VStack{
                Text(secondsToMinutesAndSeconds(RemainingFocusTime))
                    .font(.largeTitle)
                    .padding()
                Button(action: {isTimerRunning.toggle()}, label: {
                    Text(isTimerRunning ? "Pause" : "Start")
                        .padding()
                        .foregroundStyle(Color.white)
                        .background(isTimerRunning ? Color.red : Color.green)
                        .clipShape(Circle())
                })
                .padding()
            }
            .onReceive(timer){ _ in
                if isTimerRunning{
                    if RemainingFocusTime > 0{
                        RemainingFocusTime -= 1
                    }else{
                        isTimerRunning = false
                    }
                }
            }
        }
    }
    private func secondsToMinutesAndSeconds(_ seconds: Int) -> String{
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
}

#Preview {
    Pomodoro_Timer_SetUp_Page()
}
