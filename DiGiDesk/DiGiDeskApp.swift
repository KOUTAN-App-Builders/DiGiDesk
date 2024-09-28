//
//  DiGiDeskApp.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/17.
//

import SwiftUI
import SwiftData
import BackgroundTasks
import ActivityKit

@main
struct DiGiDeskApp: App {
    @Environment(\.scenePhase) var scenePhase
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
    /*init(){
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.KOUTAN-App-Builders.DiGiDesk.timers", using: nil) { [weak self] task in
            self?.handleBackgroundTask(task: task as! BGAppRefreshTask)
        }
    }*/
    
    init(){
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.DiGiDesk.updateStudyRings", using: nil){ task in
            handleStudyRingUpdate(task: task as! BGAppRefreshTask)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .onChange(of: scenePhase){
                        if scenePhase == .background{
                            scheduleStudyRingUpdate()
                        }
                    }
                    /*.onAppear{
                        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.DiGiDesk.updateStudyRings", using: nil){ task in
                            handleStudyRingUpdate(task: task as! BGAppRefreshTask)
                        }
                    }*/
                    /*.onAppear{
                        scheduleNextBackgroundTask()
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)){ _ in
                        scheduleNextBackgroundTask()
                    }*/
            }
        }
        .modelContainer(for: [Book_Data_Model.self, Study_Rings_Data.self, Exam_Data.self, Flash_Card_Data.self, Task_Data.self])
    }
    /*func handleBackgroundTask(task: BGAppRefreshTask){
        scheduleNextBackgroundTask()
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        queue.addOperation {
            self.updateTimersInBackground()
            task.setTaskCompleted(success: true)
        }
        task.expirationHandler = {
            queue.cancelAllOperations()
        }
    }
    func scheduleNextBackgroundTask(){
        let request = BGAppRefreshTaskRequest(identifier: "com.KOUTAN-App-Builders.DiGiDesk.timers")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 15*60)
        do{
            try BGTaskScheduler.shared.submit(request)
        }catch{
            print("Could not schedule app refresh: \(error)")
        }
    }
    func updateTimersInBackground(){
        
    }*/
}
