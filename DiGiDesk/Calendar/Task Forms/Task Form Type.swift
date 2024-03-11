//
//  Task Form Type.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/11.
//

import SwiftUI

enum Task_Form_Type: Identifiable, View{
    case new
    case update(task)
    
    var id: String{
        switch self{
        case .new:
            return "new"
        case.update:
            return "update"
        }
    }
    var body: some View{
        switch self{
        case .new:
            return Task_Form_View(viewModel: Task_Form_ViewModel())
        case .update(let task):
            return Task_Form_View(viewModel: Task_Form_ViewModel(task))
        }
    }
}
