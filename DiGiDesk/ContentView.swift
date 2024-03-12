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
        /*TabView{
            Book_Shelf_Page()
                .tabItem {
                    Label("Books", systemImage: "books.vertical")
                }
            EmptyView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
            Timers_Home_Page()
                .tabItem {
                    Label("Timers", systemImage: "timer")
                }
            List_of_Exam_URLs()
                .tabItem {
                    Label("Exam Data", systemImage: "square.and.pencil")
                }
        }*/
        VStack {
            if selectedTab == .bookshelf{
                Book_Shelf_Page()
            }
            if selectedTab == .calendar{
                Calendar_Page()
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
    }
}

#Preview {
    NavigationView{
        ContentView()
    }
}
