//
//  Calendar Task Model.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/12.
//

import Foundation
import SwiftData

@Model
class Task_Data: Identifiable{
    let id: String
    var task_Name: String
    var task_Due_Date: Date
    var isTaskCompleted: Bool
    
    init(id: String, task_Name: String, task_Due_Date: Date, isTaskCompleted: Bool) {
        self.id = UUID().uuidString
        self.task_Name = task_Name
        self.task_Due_Date = task_Due_Date
        self.isTaskCompleted = isTaskCompleted
    }
    
    static var sampleTasks: [Task_Data]{
        return[
            Task_Data(id: UUID().uuidString, task_Name: "Task 1", task_Due_Date: Date(), isTaskCompleted: false),
            Task_Data(id: UUID().uuidString, task_Name: "Task 2", task_Due_Date: Date(), isTaskCompleted: false),
            Task_Data(id: UUID().uuidString, task_Name: "Task 3", task_Due_Date: Date(), isTaskCompleted: false),
            Task_Data(id: UUID().uuidString, task_Name: "Task 4", task_Due_Date: Date(), isTaskCompleted: false)
        ]
    }
}

extension Task_Data{
    static func predicate(searchDate: Date) -> Predicate<Task_Data>{
        let calendar = Calendar.autoupdatingCurrent
        let startDate = calendar.startOfDay(for: searchDate)
        let endDate = calendar.date(byAdding: .init(day: 1), to: startDate) ?? startDate
        return #Predicate<Task_Data>{ task in
            task.task_Due_Date > startDate && task.task_Due_Date < endDate
        }
    }
}
