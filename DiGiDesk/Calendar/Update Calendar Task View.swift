//
//  Update Calendar Task View.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/13.
//

import SwiftUI
import SwiftData

struct Update_Calendar_Task_View: View {
    
    @State private var updated_Task_Name: String = ""
    @State private var updated_Task_DueDate: Date = Date()
    
    var SelectedTask: Task_Data
    @Environment(\.modelContext) var Context
    @Environment(\.dismiss) var Dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("New Task Name", text: $updated_Task_Name)
                    .frame(height: 55)
                    .background(Color.black.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                DatePicker("New Due Date for the Task", selection: $updated_Task_DueDate, displayedComponents: .date)
                Button(action: {updateTask(SelectedTask); Dismiss()}, label: {
                    Text("Update Task")
                        .frame(width: 200, height: 55)
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                })
                Button(action: {deleteTask(SelectedTask); Dismiss()}, label: {
                    Text("Delete Task")
                        .frame(width: 200, height: 55)
                        .background(Color.black.opacity(0.05))
                        .foregroundStyle(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                })
                .padding()
            }
        }
    }
    func updateTask(_ task: Task_Data){
        task.task_Name = updated_Task_Name
        task.task_Due_Date = updated_Task_DueDate
        
        try? Context.save()
    }
    func deleteTask(_ task: Task_Data){
        Context.delete(task)
    }
}
