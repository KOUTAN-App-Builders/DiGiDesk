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
    @State private var isUpdateViewSelected: Bool = false
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        ScrollView{
            if TaskData.isEmpty{
                VStack{
                    Text("There are no tasks")
                        .font(.largeTitle)
                    Text("You can add new tasks by clicking the button below.")
                        .font(.headline)
                    NavigationLink {
                        Create_Calendar_Task_View()
                    } label: {
                        Text("Add New Task")
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                }
            }else{
                ForEach(TaskData){ task in
                    Divider()
                    HStack{
                        Button{
                            selectedTaskCompletionState = task.isTaskCompleted
                            selectedTaskCompletionState.toggle()
                            updateTaskCompletion(task)
                        } label: {
                            Image(systemName: task.isTaskCompleted ? "checkmark.circle" : "circle")
                        }
                        VStack(alignment: .leading){
                            Text(task.task_Name)
                                .font(.headline)
                            Text("Due Date: \(task.task_Due_Date, formatter: dateFormatter)")
                                .font(.subheadline)
                                .lineLimit(1)
                                .padding(.leading, 10)
                        }
                        Spacer()
                        NavigationLink {
                            Update_Calendar_Task_View(SelectedTask: task)
                        } label: {
                            Image(systemName: "info.circle")
                                .foregroundStyle(Color.blue)
                                .padding(.leading)
                        }
                    }
                    .padding(.vertical)
                    .swipeActions{
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            deleteTask(task)
                        }
                    }
                    .padding(.horizontal, 20)
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
    func deleteTask(_ task: Task_Data){
        Context.delete(task)
    }
}

#Preview {
    NavigationStack{
        Task_Calendar_List_Combined_Page()
    }
}
