//
//  Create Calendar Task View.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/13.
//

import SwiftUI
import SwiftData

struct Create_Calendar_Task_View: View {
    
    @State private var New_Task_Name: String = ""
    @State private var New_Task_DueDate: Date = Date()
    
    @Environment(\.modelContext) var Context
    @Environment(\.dismiss) var Dismiss
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Task Name", text: $New_Task_Name)
                    .frame(height: 55)
                    .background(Color.black.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                DatePicker(selection: $New_Task_DueDate, displayedComponents: .date) {
                    Text("Task Due Date")
                }
                Button(action: {Add_New_Task(); Dismiss()}, label: {
                    Text("Add Task")
                        .frame(width: 200, height: 55)
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                })
            }
        }
        .navigationTitle("Add New Task")
        .padding()
    }
    func Add_New_Task(){
        let newTask = Task_Data(id: UUID().uuidString, task_Name: New_Task_Name, task_Due_Date: New_Task_DueDate, isTaskCompleted: false)
        Context.insert(newTask)
    }
}

#Preview {
    NavigationStack{
        Create_Calendar_Task_View()
    }
}
