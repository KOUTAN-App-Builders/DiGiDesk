//
//  Study Rings View.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/13.
//

import SwiftUI
import SwiftData

@Model
class Study_Rings_Data: Identifiable{
    var date: Date
    var StudyGoals: Int
    var CurrentStudyTime: Int
    
    init(date: Date, StudyGoals: Int, CurrentStudyTime: Int) {
        self.date = date
        self.StudyGoals = StudyGoals
        self.CurrentStudyTime = CurrentStudyTime
    }
}

extension Study_Rings_Data{
    static func predicate(searchDate: Date) -> Predicate<Study_Rings_Data>{
        let calendar = Calendar.autoupdatingCurrent
        let startDate = calendar.startOfDay(for: searchDate)
        let endDate = calendar.date(byAdding: .init(day: 1), to: startDate) ?? startDate
        return #Predicate<Study_Rings_Data>{ ring in
            ring.date > startDate && ring.date < endDate
        }
    }
}

struct Study_Rings_View: View {
    
    @Query private var StudyRings: [Study_Rings_Data]
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundStyle(Color.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(Double() / Double()))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
        }
        .padding(.horizontal)
    }
}

#Preview {
    Study_Rings_View()
}
