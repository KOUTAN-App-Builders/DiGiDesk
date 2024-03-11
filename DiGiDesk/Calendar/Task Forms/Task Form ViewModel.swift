//
//  Task Form ViewModel.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/11.
//

import Foundation

class Task_Form_ViewModel: ObservableObject{
    @Published var date = Date()
    @Published var task_Name: String = ""
    @Published var isTaskCompleted: Bool = false
    var id: String?
    var updating: Bool {id != nil}
    
    init(){}
    
    init(_ task: task){
        date = task.date
        task_Name = task.Task_Name
        isTaskCompleted = task.isTaskCompleted
        id = task.id
    }
    var incomplete: Bool{
        task_Name.isEmpty
    }
}
