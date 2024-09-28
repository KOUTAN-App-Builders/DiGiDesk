//
//  Study Ring Background Creator.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/04/09.
//

import SwiftUI
import SwiftData
import BackgroundTasks

// Previous Approach
/*
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
    BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.DiGiDesk.refresh", using: nil) { task in
        handleAppRefresh(task: task as! BGAppRefreshTask)
    }
    return true
}

func scheduleDailyAppRefresh(){
    let refreshRequest = BGAppRefreshTaskRequest(identifier: "com.DiGiDesk.refresh")
    var dateComponents = DateComponents()
    dateComponents.hour = 0
    dateComponents.minute = 0
    if let nextRefreshDate = Calendar.current.nextDate(after: Date(), matching: dateComponents, matchingPolicy: .nextTime){
        refreshRequest.earliestBeginDate = nextRefreshDate
    }else{
        print("Error Generating New Ring.")
    }
    
    do{
        try BGTaskScheduler.shared.submit(refreshRequest)
    }catch{
        print("Failed to schedule background task. Error Description: \(error)")
    }
}

func handleAppRefresh(task: BGAppRefreshTask){
    @Environment(\.modelContext) var Context
    let NewRing = Study_Rings_Data(date: Date(), StudyGoals: 10800, CurrentStudyTime: 0)
    Context.insert(NewRing)
    
    task.setTaskCompleted(success: true)
}

func applicationDidEnterBackground(_ application: UIApplication){
    scheduleDailyAppRefresh()
}
*/


//Second Approach
func scheduleStudyRingUpdate(){
    let request = BGAppRefreshTaskRequest(identifier: "com.DiGiDesk.updateStudyRings")
    request.earliestBeginDate = Calendar.current.startOfDay(for: Date().addingTimeInterval(60 * 60 * 24))
    do{
        try BGTaskScheduler.shared.submit(request)
    }catch{
        print("Could not schedule study ring update. Error Description: \(error)")
    }
}

func handleStudyRingUpdate(task: BGAppRefreshTask){
    
    task.expirationHandler = {
        print("Task expired before completion.")
    }
    
    // Scheduling the next study ring
    scheduleStudyRingUpdate()
    
    // Performing the Ring Generation
    generateStudyRings()
    
    //Completing the Task
    task.setTaskCompleted(success: true)
}

func generateStudyRings(){
    let NewRing = Study_Rings_Data(date: Date(), StudyGoals: 10800, CurrentStudyTime: 0)
    @Environment(\.modelContext) var Context
    let descriptor = FetchDescriptor<Study_Rings_Data>()
    let count = (try? Context.fetchCount(descriptor)) ?? 0
    
    if count == 0{
        Context.insert(NewRing)
    }
}
