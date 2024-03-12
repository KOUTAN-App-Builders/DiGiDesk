//
//  Calendar Task List View.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/12.
//

import SwiftUI

struct Calendar_Task_List_View: View {
    
    @ObservedObject var viewModel: Calendar_Task_ViewModel
    
    var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
    
    var body: some View {
        List{
            ForEach(viewModel.tasks){ task in
                HStack{
                    Button(action: {}, label: {
                        Image(systemName: task.isTaskCompleted ? "checkmark.circle" : "circle")
                    })
                    VStack{
                        Text(task.task_Name)
                            .font(.headline)
                        Text("Due: \(task.task_Due_Date, formatter: dateFormatter)")
                    }
                    NavigationLink {
                        Update_Calendar_Task_View()
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .onDelete(perform: { indexSet in
                viewModel.deleteTask(viewModel.tasks[indexSet.first!])
            })
        }
        .navigationTitle("Task List")
        .onAppear{
            viewModel.fetchTasks()
        }
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
}

#Preview {
    NavigationView{
        Calendar_Task_List_View(viewModel: Calendar_Task_ViewModel())
    }
}
