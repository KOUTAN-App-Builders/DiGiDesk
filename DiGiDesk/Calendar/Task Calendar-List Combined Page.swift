//
//  Task Calendar-List Combined Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/13.
//

import SwiftUI

struct Task_Calendar_List_Combined_Page: View {
    
    @State private var isListViewSelected: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {isListViewSelected = false}, label: {
                    Image(systemName: isListViewSelected ? "calendar.circle" : "calendar.circle.fill")
                })
                Button(action: {isListViewSelected = true}, label: {
                    Image(systemName: isListViewSelected ? "list.bullet.rectangle.fill" : "list.bullet.rectangle")
                })
            }
            .padding(.leading)
            if isListViewSelected == false{
                Calendar_Page()
            }else{
                Calendar_Task_List_View()
            }
        }
    }
}

#Preview {
    NavigationView{
        Task_Calendar_List_Combined_Page()
    }
}
