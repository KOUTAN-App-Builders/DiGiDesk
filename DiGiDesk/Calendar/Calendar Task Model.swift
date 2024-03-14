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
}
