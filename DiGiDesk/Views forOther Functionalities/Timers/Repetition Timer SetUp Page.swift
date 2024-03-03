//
//  Repetition Timer SetUp Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/02/28.
//

import SwiftUI

struct Repetition_Timer_SetUp_Page: View {
    
    @State private var initialTime: Int = 1500
    @State private var timeRemaining: Int = 1500
    @State private var isTimerRunning: Bool = false
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack{
            ZStack{
                ProgressView(value: Double(timeRemaining) / Double(initialTime))
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                VStack{
                    Text(secondsToMinutesAndSeconds(timeRemaining))
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
                        Button(action: {timeRemaining = initialTime}, label: {
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
            Text("Configured Time Length: \(secondsToMinutesAndSeconds(initialTime))")
                .font(.headline)
            Stepper{
                Text("Adjust by Hour")
            }onIncrement: {
                incrementHours()
            }onDecrement: {
                decrementHours()
            }
            Stepper{
                Text("Adjust by Minutes")
            }onIncrement: {
                incrementMinutes()
            }onDecrement: {
                decrementMinutes()
            }
            Stepper(value: $initialTime, in: 0...86399) {
                Text("Adjust by Second")
            }
        }
        .navigationTitle("Repetition Timer")
        .padding(.horizontal)
        .onReceive(timer) { _ in
            if isTimerRunning{
                if timeRemaining > 0{
                    timeRemaining -= 1
                }else{
                    timeRemaining = initialTime
                }
            }else{
                isTimerRunning = false
                timeRemaining = initialTime
            }
        }
    }
    private func secondsToMinutesAndSeconds(_ seconds: Int) -> String{
        let hours = seconds / 3600
        let remainingMinutes = seconds % 3600 / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours , remainingMinutes , remainingSeconds)
    }
    func incrementHours(){
        initialTime += 3600
        if initialTime >= 86399{
            initialTime = 86399
        }
    }
    func incrementMinutes(){
        initialTime += 60
        if initialTime >= 86399{
            initialTime = 86399
        }
    }
    func decrementHours(){
        initialTime -= 3600
        if initialTime <= 0{
            initialTime = 0
        }
    }
    func decrementMinutes(){
        initialTime -= 60
        if initialTime <= 0{
            initialTime = 0
        }
    }
}

#Preview {
    NavigationView{
        Repetition_Timer_SetUp_Page()
    }
}
