//
//  Calendar Task Manager.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/11.
//

import Foundation

@MainActor
class Calendar_Tasks: ObservableObject{
    @Published var tasks = [task]()
    @Published var preview: Bool
    
    init(preview: Bool = false) {
        self.preview = preview
        fetchTasks()
    }
    func fetchTasks(){
        if preview{
            tasks = task.sampleTasks
        }else{
            
        }
    }
    func deleteTasks(_ task: task){
        if let index = tasks.firstIndex(where: {$0.id == task.id}){
            tasks.remove(at: index)
        }
    }
    func addTasks(_ task: task){
        tasks.append(task)
    }
    func update(_ task: task){
        if let index = tasks.firstIndex(where: {$0.id == task.id}){
            tasks[index].date = task.date
            tasks[index].Task_Name = task.Task_Name
        }
    }
}

struct task: Identifiable{
    var id: String
    var date: Date
    var Task_Name: String
    var isTaskCompleted: Bool
    
    init(id: String, date: Date, Task_Name: String, isTaskCompleted: Bool) {
        self.id = UUID().uuidString
        self.date = date
        self.Task_Name = Task_Name
        self.isTaskCompleted = isTaskCompleted
    }
    static var sampleTasks: [task]{
        return[
            task(id: UUID().uuidString, date: Date().diff(numDays: 0), Task_Name: "Task 1", isTaskCompleted: false),
            task(id: UUID().uuidString, date: Date().diff(numDays: 1), Task_Name: "Task 2", isTaskCompleted: false),
            task(id: UUID().uuidString, date: Date().diff(numDays: 2), Task_Name: "Task 3", isTaskCompleted: false),
            task(id: UUID().uuidString, date: Date().diff(numDays: 3), Task_Name: "Task 4", isTaskCompleted: false),
            task(id: UUID().uuidString, date: Date().diff(numDays: 4), Task_Name: "Task 5", isTaskCompleted: false)
        ]
    }
}

extension Date {
    func diff(numDays: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: numDays, to: self)!
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}
