//
//  Calendar Task Model.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/12.
//

import Foundation

struct Task: Identifiable, Codable{
    let id: String
    let task_Name: String
    let task_Due_Date: Date
    let isTaskCompleted: Bool
    
    init(id: String, task_Name: String, task_Due_Date: Date, isTaskCompleted: Bool) {
        self.id = UUID().uuidString
        self.task_Name = task_Name
        self.task_Due_Date = task_Due_Date
        self.isTaskCompleted = isTaskCompleted
    }
}
