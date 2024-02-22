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
    case other = 2
}

struct Custom_Tab_Bar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack(alignment: .center){
            Button(action: {selectedTab = .bookshelf}, label: {
                VStack{
                    if selectedTab == .bookshelf{
                        Image(systemName: "books.vertical.fill")
                            .frame(width: 24 , height: 24)
                    }else{
                        Image(systemName: "books.vertical")
                            .frame(width: 24 , height: 24)
                    }
                    Text("Bookshelf")
                }
                .padding()
            })
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
            Button(action: {selectedTab = .other}, label: {
                VStack{
                    if selectedTab == .other{
                        Menu{
                            NavigationLink {
                                List_of_Exam_URLs()
                            } label: {
                                Text("Exam URL List")
                            }
                        }label:{
                            VStack{
                                Image(systemName: "ellipsis.circle.fill")
                                    .frame(width: 24 , height: 24)
                                Text("Other")
                            }
                        }
                    }else{
                        VStack{
                            Image(systemName: "ellipsis.circle")
                                .frame(width: 24 , height: 24)
                            Text("Other")
                        }
                    }
                    
                }
                .padding()
            })
        }
        .padding(.top)
    }
}

#Preview {
    Custom_Tab_Bar(selectedTab: .constant(.bookshelf))
}
