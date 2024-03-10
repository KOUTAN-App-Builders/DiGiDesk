//
//  Normal Timer SetUp Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/02/28.
//

import SwiftUI

struct Normal_Timer_SetUp_Page: View {
    
    @State private var initialTime: Int = 1500
    @State private var timeRemaining: Int = 1500
    @State private var StudiedTime: Int = 1500
    @State private var timerRunning: Bool = false
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @Environment(\.modelContext) var Context
    // Current Date
    /*
     var dateFormatter: DateFormatter{
     let formatter = DateFormatter()
     formatter.timeStyle = .medium
     return formatter
     }
     */
    //Additional Text
    /*
     @State var count: Int = 10
     @State var finishedText: String? = nil
     */
    
    var body: some View {
        VStack{
            ZStack{
                ProgressView(value: Double(timeRemaining) / Double((initialTime)))
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                VStack{
                    Text(secondsToMinutesAndSeconds(timeRemaining))
                        .font(.largeTitle)
                        .padding()
                    HStack{
                        Button(action: {timerRunning.toggle()}, label: {
                            Text(timerRunning ? "Pause" : "Start")
                                .padding()
                                .foregroundStyle(Color.white)
                                .background(timerRunning ? Color.red : Color.green)
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
                Text("Adjust by Minute")
            }onIncrement: {
                incrementMinutes()
            }onDecrement: {
                decrementMinutes()
            }
            Stepper(value: $initialTime, in: 0...86399) {
                Text("Adjust by Second")
            }
        }
        .navigationTitle("Ordinary Timer")
        .padding(.horizontal)
        .onReceive(timer) { _ in
            if timerRunning{
                if timeRemaining > 0{
                    timeRemaining -= 1
                }
            }else{
                StudiedTime = initialTime - timeRemaining
                timerRunning = false
                timeRemaining = initialTime
            }
        }
    }
    private func secondsToMinutesAndSeconds(_ seconds: Int) -> String{
        let hours = seconds / 3600
        let remainingMinutes = seconds % 3600 / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, remainingMinutes, remainingSeconds)
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
    func updateStudiedTime(_ item: Study_Rings_Data){
        item.CurrentStudyHours += StudiedTime
        try? Context.save()
    }
}

struct CircularProgressViewStyle: ProgressViewStyle{
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 10)
                .opacity(0.3)
                .padding()
            Circle()
                .trim(from: 0.0, to: CGFloat(configuration.fractionCompleted ?? 0.0))
                .stroke(Color.green, lineWidth: 10)
                .rotationEffect(Angle(degrees: -90))
                .aspectRatio(1, contentMode: .fit)
                .padding()
        }
    }
}

#Preview {
    NavigationView{
        Normal_Timer_SetUp_Page()
    }
}
