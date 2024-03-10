//
//  Study Rings View.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/03/10.
//

import SwiftUI
import SwiftData

@Model
class Study_Rings_Data: Identifiable{
    var date: Date
    var StudyGoals: Int
    var CurrentStudyHours: Int
    
    init(date: Date, StudyGoals: Int, CurrentStudyHours: Int) {
        self.date = date
        self.StudyGoals = StudyGoals
        self.CurrentStudyHours = CurrentStudyHours
    }
}

struct Study_Rings_View: View {
    
    @Query private var StudyRings: Study_Rings_Data
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 20.0)
            .opacity(0.3)
            .foregroundStyle(Color.gray)
        Circle()
            .trim(from: 0.0, to: CGFloat(Double(StudyRings.CurrentStudyHours) / Double(StudyRings.StudyGoals)))
            .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
            .foregroundStyle(Color.blue)
            .rotationEffect(Angle(degrees: 270.0))
    }
}

#Preview {
    Study_Rings_View()
}
