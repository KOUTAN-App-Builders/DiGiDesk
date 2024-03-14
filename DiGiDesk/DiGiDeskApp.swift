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
    /*
    var Container: ModelContainer
    
    init(){
        do{
            let config1 = ModelConfiguration(for: Book_Data_Model.self)
            let config2 = ModelConfiguration(for: Study_Rings_Data.self)
            let config3 = ModelConfiguration(for: Exam_Data.self)
            let config4 = ModelConfiguration(for: Flash_Card_Data.self)
            
            Container = try ModelContainer(for: Book_Data_Model.self, Study_Rings_Data.self, Exam_Data.self, Flash_Card_Data.self , configurations: config1, config2, config3, config4)
        }catch{
            fatalError("Failed to configure SwiftData container.")
        }
    }*/
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
        .modelContainer(for: [Book_Data_Model.self, Study_Rings_Data.self, Exam_Data.self, Flash_Card_Data.self, Task_Data.self])
    }
}
