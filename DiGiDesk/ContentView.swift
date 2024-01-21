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
                Calendar_Page()
            }
            Custom_Tab_Bar(selectedTab: $selectedTab)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
