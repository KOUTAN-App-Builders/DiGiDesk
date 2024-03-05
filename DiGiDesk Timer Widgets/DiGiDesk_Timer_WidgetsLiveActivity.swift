//
//  DiGiDesk_Timer_WidgetsLiveActivity.swift
//  DiGiDesk Timer Widgets
//
//  Created by 加納塙大 Editor on 2024/03/05.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct DiGiDesk_Timer_WidgetsAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var initialTime: Int
        var remainingTime: Int
        var currentState: String
    }

    // Fixed non-changing properties about your activity go here!
    var TimerType: String
}

struct DiGiDesk_Timer_WidgetsLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: DiGiDesk_Timer_WidgetsAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text(context.attributes.TimerType)
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("Trailing")
            } minimal: {
                Text("minimal")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
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
