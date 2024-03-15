//
//  Calendar Task List View.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/12.
//

import SwiftUI
import SwiftData

struct Calendar_Task_List_View: View {
    
    @Query private var TaskData: [Task_Data]
    @Environment(\.modelContext) var Context
    
    @State private var selectedTaskCompletionState: Bool = false
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        List{
            ForEach(TaskData){ task in
                HStack{
                    Button{
                        selectedTaskCompletionState = task.isTaskCompleted
                        selectedTaskCompletionState.toggle()
                        updateTaskCompletion(task)
                    } label: {
                        Image(systemName: task.isTaskCompleted ? "checkmark.circle" : "circle")
                    }
                    VStack{
                        Text(task.task_Name)
                            .font(.headline)
                        Text("Due Date: \(task.task_Due_Date, formatter: dateFormatter)")
                            .font(.subheadline)
                    }
                    Spacer()
                    NavigationLink {
                        Update_Calendar_Task_View(SelectedTask: task)
                    } label: {
                        Image(systemName: "info.circle")
                            .foregroundStyle(Color.blue)
                            .padding(.leading)
                    }
                    .swipeActions{
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            Context.delete(task)
                        }
                    }
                }
            }
        }
        .navigationTitle("Task List")
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                EditButton()
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    Create_Calendar_Task_View()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    func updateTaskCompletion(_ task: Task_Data){
        task.isTaskCompleted = selectedTaskCompletionState
        
        try? Context.save()
    }
}

#Preview {
    NavigationView{
        Calendar_Task_List_View()
    }
}
