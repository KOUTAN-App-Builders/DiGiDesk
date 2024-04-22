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
            if UIDevice.current.userInterfaceIdiom == .phone{
                if selectedTab == .bookshelf{
                    Book_Shelf_Page()
                }
                if selectedTab == .calendar{
                    Task_Calendar_List_Combined_Page()
                }
                if selectedTab == .timers{
                    Timers_Home_Page()
                }
                if selectedTab == .flashCards{
                    Flash_Card_Home_Page()
                }
                if selectedTab == .examData{
                    List_of_Exam_URLs()
                }
                Spacer()
                Custom_Tab_Bar(selectedTab: $selectedTab)
                    .ignoresSafeArea(edges: .bottom)
            }else{
                    List{
                        NavigationLink {
                            Book_Shelf_Page()
                        } label: {
                            Label("Book Shelf", systemImage: "books.vertical")
                        }
                        NavigationLink {
                            Task_Calendar_List_Combined_Page()
                        } label: {
                            Label("Calendar", systemImage: "calendar.circle")
                        }
                        NavigationLink {
                            Timers_Home_Page()
                        } label: {
                            Label("Timer", systemImage: "timer.circle")
                        }
                        NavigationLink {
                            Flash_Card_Home_Page()
                        } label: {
                            Label("Flash Cards", systemImage: "square.and.pencil.circle")
                        }
                        NavigationLink {
                            List_of_Exam_URLs()
                        } label: {
                            Label("Exam Links", systemImage: "doc.text")
                        }
                    }
                    .listStyle(.sidebar)
                    .navigationTitle("DiGiDesk")
            }
        }
        .padding()
    }
}

#Preview {
    NavigationView{
        ContentView()
    }
}
