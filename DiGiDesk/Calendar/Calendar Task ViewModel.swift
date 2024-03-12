//
//  Calendar Task ViewModel.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/12.
//

import Foundation

class Calendar_Task_ViewModel: ObservableObject{
    @Published var tasks: [Task] = []
    
    func fetchTasks(){
        if let data = UserDefaults.standard.data(forKey: "tasks"),
           let savedTasks = try? JSONDecoder().decode([Task].self, from: data){
            tasks = savedTasks.sorted(by: {$0.task_Due_Date < $1.task_Due_Date})
        }
    }
    func addTask(_ task: Task) {
        tasks.append(task)
        saveTasks()
    }
    func deleteTask(_ task: Task){
        tasks.removeAll{$0.id == task.id}
        saveTasks()
    }
    func updateTask(_ updatedTask: Task){
        if let index = tasks.firstIndex(where: {$0.id == updatedTask.id}){
            tasks[index] = updatedTask
            saveTasks()
        }
    }
    private func saveTasks(){
        if let encodedData = try? JSONEncoder().encode(tasks){
            UserDefaults.standard.set(encodedData, forKey: "tasks")
        }
    }
}
