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
#if os(iOS)
        VStack {
            if selectedTab == .bookshelf{
                Book_Shelf_Page()
            }
            if selectedTab == .calendar{
                CalendarView()
            }
            if selectedTab == .timers{
                Timers_Home_Page()
            }
            if selectedTab == .flashCards{
                Flash_Card_Home_Page()
            }
            Spacer()
            Custom_Tab_Bar(selectedTab: $selectedTab)
                .padding(.top)
                .ignoresSafeArea(edges: .bottom)
        }
        .padding()
#endif
    }
}

#Preview {
    ContentView()
}
