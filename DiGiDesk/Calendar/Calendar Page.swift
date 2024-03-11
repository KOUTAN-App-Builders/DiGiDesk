//
//  Calendar Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/18.
//

import SwiftUI

struct CalendarView: View {
    
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
                .padding(.leading)
            }
            if isListViewSelected == false{
                
            }else{
                
            }
        }
    }
}
#Preview {
    CalendarView()
        .environmentObject(Calendar_Tasks(preview: true))
}
