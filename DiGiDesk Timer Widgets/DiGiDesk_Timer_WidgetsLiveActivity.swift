//
//  DiGiDesk_Timer_WidgetsLiveActivity.swift
//  DiGiDesk Timer Widgets
//
//  Created by 加納塙大 Editor on 2024/03/05.
//

import ActivityKit
import WidgetKit
import SwiftUI

enum TimerType: Codable{
    case Normal
    case Pomodoro
    case Repetition
    case Test_Sim
}

struct DiGiDesk_Timer_WidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var initialTime: Int
        var remainingTime: Int
        var currentState: String?
    }
    // Fixed non-changing properties about your activity go here!
    var timerType: TimerType
}

struct Timer_LiveActivity_View: View {
    
    let context: ActivityViewContext<DiGiDesk_Timer_WidgetsAttributes>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text(timerTypeText(context.attributes.timerType))
                    .font(.headline)
                Spacer()
                if context.state.currentState == nil{
                    //UI for timer types which "Concentration" or "Break" time is not defined or required.
                }else{
                    Text(context.state.currentState!)
                }
            }
            ProgressView(value: Double(context.state.remainingTime) / Double(context.state.initialTime))
                .padding(.horizontal, 20)
            Text(secondsToMinutesAndSeconds(context.state.remainingTime))
                .font(.subheadline)
                .padding(.horizontal)
        }
        .foregroundStyle(Color.orange)
        .padding(.vertical)
    }
    func secondsToMinutesAndSeconds(_ seconds: Int) -> String{
        let hours = seconds / 3600
        let remainingMinutes = seconds % 3600 / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, remainingMinutes, remainingSeconds)
    }
    func timerTypeText(_ timerType: TimerType) -> String{
        switch timerType {
        case .Normal:
            return "Normal Timer"
        case .Pomodoro:
            return "Pomodoro Timer"
        case .Repetition:
            return "Repetition Timer"
        case .Test_Sim:
            return "Test Simulation Timer"
        }
    }
}

struct DiGiDesk_Timer_WidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DiGiDesk_Timer_WidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Timer_LiveActivity_View(context: context)
            }
            .activityBackgroundTint(Color.black)
            .activitySystemActionForegroundColor(Color.orange)
            
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text(timerTypeText(context.attributes.timerType))
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if context.state.currentState == nil{
                        //UI for timers without "Focus" and "Break" modes.
                    }else{
                        Text(context.state.currentState!)
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .center, spacing: 10){
                        ProgressView(value: Double(context.state.remainingTime) / Double(context.state.initialTime))
                        // more content
                        Text("remaining time: \(secondsToMinutesAndSeconds(context.state.remainingTime))")
                    }
                }
            } compactLeading: {
                ProgressView(value: Double(context.state.remainingTime) / Double(context.state.initialTime))
                    .progressViewStyle(.circular)
            } compactTrailing: {
                Text(secondsToMinutesAndSeconds(context.state.remainingTime))
            } minimal: {
                ProgressView(value: Double(context.state.remainingTime) / Double(context.state.initialTime))
                    .progressViewStyle(.circular)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
    func secondsToMinutesAndSeconds(_ seconds: Int) -> String{
        let hours = seconds / 3600
        let remainingMinutes = seconds % 3600 / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, remainingMinutes, remainingSeconds)
    }
    func timerTypeText(_ timerType: TimerType) -> String{
        switch timerType {
        case .Normal:
            return "Normal Timer"
        case .Pomodoro:
            return "Pomodoro Timer"
        case .Repetition:
            return "Repetition Timer"
        case .Test_Sim:
            return "Test Simulation Timer"
        }
    }
}
/*
 extension DiGiDesk_Timer_WidgetsAttributes {
 fileprivate static var preview: DiGiDesk_Timer_WidgetsAttributes {
 DiGiDesk_Timer_WidgetsAttributes(TimerType: "World")
 }
 }
 
 extension DiGiDesk_Timer_WidgetsAttributes.ContentState {
 fileprivate static var smiley: DiGiDesk_Timer_WidgetsAttributes.ContentState {
 DiGiDesk_Timer_WidgetsAttributes.ContentState(from: "😀" as! Decoder)
 }
 
 fileprivate static var starEyes: DiGiDesk_Timer_WidgetsAttributes.ContentState {
 DiGiDesk_Timer_WidgetsAttributes.ContentState(emoji: "🤩")
 }
 }
 
 #Preview("Notification", as: .content, using: DiGiDesk_Timer_WidgetsAttributes.preview) {
 DiGiDesk_Timer_WidgetsLiveActivity()
 } contentStates: {
 DiGiDesk_Timer_WidgetsAttributes.ContentState.smiley
 DiGiDesk_Timer_WidgetsAttributes.ContentState.starEyes
 }
 
 */
