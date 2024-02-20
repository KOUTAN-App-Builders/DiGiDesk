//
//  ContentView.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/17.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedTab: Tabs = .bookshelf
    
    var body: some View {
        VStack {
            if selectedTab == .bookshelf{
                Book_Shelf_Page()
            }
            if selectedTab == .calendar{
                CalendarView()
            }
            Custom_Tab_Bar(selectedTab: $selectedTab)
                .padding(.top)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
