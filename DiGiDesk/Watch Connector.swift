//
//  Watch Connector.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/09.
//

import Foundation
import WatchConnectivity

class Watch_Connector: NSObject, WCSessionDelegate{
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            <#code#>
        }
        
        func sessionDidBecomeInactive(_ session: WCSession) {
            <#code#>
        }
        
        func sessionDidDeactivate(_ session: WCSession) {
            <#code#>
        }
}
