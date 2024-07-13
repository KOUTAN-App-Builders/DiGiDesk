//
//  Daily Task Sheet View.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/23.
//

import SwiftUI
import SwiftData

struct Daily_Task_Sheet_View: View {
    
    //@Binding var isBottomSheetPresented: Bool
    @Query private var TaskData: [Task_Data]
    @Query private var StudyRings: [Study_Rings_Data]
    @Environment(\.modelContext) private var Context
    @State private var selectedTaskCompletionState: Bool = false
    @State private var isNavigationActive: Bool = false
    @State private var viewModel = Calendar_Task_ViewModel()
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    init(searchDate: Date){
        _TaskData = Query(
            filter: Task_Data.predicate(searchDate: searchDate),
            sort: \Task_Data.task_Due_Date,
            order: .forward
        )
        _StudyRings = Query(
            filter: Study_Rings_Data.predicate(searchDate: searchDate)
        )
    }
    
    var body: some View {
        ScrollView{
            if StudyRings.isEmpty{
                VStack{
                    Text("Rings aren't created.")
                        .font(.title)
                    Text("Create one by studying using the timer!")
                        .font(.caption)
                }
                .padding(.vertical)
            }else{
                ForEach(StudyRings){ ring in
                    Study_Rings_View(StudyRings: ring)
                }
                .padding(.vertical)
            }
            Divider()
                .padding(.vertical)
            if TaskData.isEmpty{
                VStack{
                    Spacer()
                    Text("No tasks for \(viewModel.searchDate, formatter: dateFormatter)")
                        .font(.headline)
                    NavigationLink {
                        Create_Calendar_Task_View()
                    } label: {
                        Text("Add New Task")
                            .frame(width: 200, height: 55)
                            .background(Color.blue)
                            .foregroundStyle(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                    }
                    Spacer()
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
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle("Tasks for: \(viewModel.searchDate)")
        
        /*
         .toolbar{
         ToolbarItem(placement: .topBarLeading) {
         Button(action: {isBottomSheetPresented.toggle()}, label: {
         Text("Cancel")
         })
         }
         }*/
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
        Daily_Task_Sheet_View(searchDate: Calendar_Task_ViewModel().searchDate)
    }
}
