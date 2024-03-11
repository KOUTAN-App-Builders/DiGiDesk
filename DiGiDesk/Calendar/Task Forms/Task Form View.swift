//
//  Task Form Viiew.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/11.
//

import SwiftUI

struct Task_Form_View: View {
    
    @EnvironmentObject var TaskManager: Calendar_Tasks
    @StateObject var viewModel: Task_Form_ViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    DatePicker(selection: $viewModel.date){
                        Text("Select Goal Date")
                    }
                    TextField("What to Do", text: $viewModel.task_Name, axis: .vertical)
                        .focused($focus, equals: true)
                }
            }
        }
    }
}

#Preview {
    Task_Form_View(viewModel: Task_Form_ViewModel())
        .environmentObject(Calendar_Tasks())
}
