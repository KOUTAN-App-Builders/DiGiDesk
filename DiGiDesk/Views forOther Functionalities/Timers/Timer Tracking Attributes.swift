//
//  Timer Tracking Attributes.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/04.
//

import Foundation
import ActivityKit

struct Timer_Tracking_Attributes: ActivityAttributes{
    let timerType: String
    
    public struct ContentState: Codable, Hashable{
        let remainingTime: Int
        
    }
}
