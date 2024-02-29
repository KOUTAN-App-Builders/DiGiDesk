//
//  Normal Timer SetUp Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/02/28.
//

import SwiftUI

struct Normal_Timer_SetUp_Page: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    @State var currentDate: Date = Date()
    // Current Date
    /*
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    @State var count: Int = 10
    @State var finishedText: String? = nil
    
    var body: some View {
        ZStack{
            VStack{
                Text(finishedText ?? "\(count)")
            }
        }
        .onReceive(timer, perform: { _ in
            if count <= 1{
                finishedText = "Done"
            }else{
                count -= 1
            }
        })
    }
}

#Preview {
    Normal_Timer_SetUp_Page()
}
