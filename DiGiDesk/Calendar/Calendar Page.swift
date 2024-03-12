//
//  Calendar Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/12.
//

import SwiftUI

struct Calendar_Page: View {
    var body: some View {
        VStack{
            Calendar_View(interval: DateInterval(start: .distantPast, end: .distantFuture))
        }
        .navigationTitle("Calendar Page")
    }
}

struct Calendar_View: UIViewRepresentable{
    
    let interval: DateInterval
    
    func makeUIView(context: Context) -> UICalendarView {
        let view = UICalendarView()
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        return view
    }
    
    func updateUIView(_ uiView: UICalendarView, context: Context) {
        
    }
    
    
}

#Preview {
    NavigationView{
        Calendar_Page()
    }
}
