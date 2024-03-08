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
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .modelContainer(for: Book_Data_Model.self)
    }
}
