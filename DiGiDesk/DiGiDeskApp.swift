//
//  DiGiDeskApp.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/17.
//

import SwiftUI
import SwiftData

@main
struct DiGiDeskApp: App {
    
    //@StateObject var calendarTasks = Calendar_Tasks(preview: true)
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    //.environmentObject(calendarTasks)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .modelContainer(for: Book_Data_Model.self)
    }
}
