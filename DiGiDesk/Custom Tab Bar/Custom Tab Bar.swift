//
//  Custom Tab Bar.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/01/18.
//

import SwiftUI
enum Tabs: Int{
    case bookshelf = 0
    case calendar = 1
    case timers = 2
    case flashCards = 3
    case examData = 4
    
}

struct Custom_Tab_Bar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack(alignment: .center){
            Spacer()
            Button(action: {selectedTab = .bookshelf}, label: {
                VStack{
                    if selectedTab == .bookshelf{
                        Image(systemName: "books.vertical.fill")
                            .frame(width: 24 , height: 24)
                    }else{
                        Image(systemName: "books.vertical")
                            .frame(width: 24 , height: 24)
                    }
                    Text("Books")
                        .lineLimit(1)
                }
                .padding()
            })
            Spacer()
            Button(action: {selectedTab = .calendar}, label: {
                VStack{
                    if selectedTab == .calendar{
                        Image(systemName: "calendar.circle.fill")
                            .frame(width: 24 , height: 24)
                    }else{
                        Image(systemName: "calendar.circle")
                            .frame(width: 24 , height: 24)
                    }
                    Text("Calendar")
                }
                .padding()
            })
            Spacer()
            Button(action: {selectedTab = .timers}, label: {
                VStack{
                    if selectedTab == .timers{
                        VStack{
                            Image(systemName: "timer.circle.fill")
                                .frame(width: 24 , height: 24)
                            Text("Timer")
                        }
                    }else{
                        VStack{
                            Image(systemName: "timer.circle")
                                .frame(width: 24 , height: 24)
                            Text("Timer")
                        }
                    }
                }
            })
            Spacer()
            Button(action: {selectedTab = .flashCards}, label: {
                VStack{
                    if selectedTab == .flashCards{
                        VStack{
                            Image(systemName: "square.and.pencil.circle.fill")
                                .frame(width: 24,height: 24)
                            Text("Cards")
                        }
                    }else{
                        VStack{
                            Image(systemName: "square.and.pencil.circle")
                                .frame(width: 24, height: 24)
                            Text("Cards")
                        }
                    }
                }
            })
            Spacer()
            Button(action: {selectedTab = .examData}, label: {
                VStack{
                    if selectedTab == .examData{
                        Image(systemName: "doc.text.fill")
                            .frame(width: 24, height: 24)
                    }else{
                        Image(systemName: "doc.text")
                            .frame(width: 24, height: 24)
                    }
                    Text("Exams")
                }
            })
            Spacer()
        }
    }
}

#Preview {
    Custom_Tab_Bar(selectedTab: .constant(.bookshelf))
}
