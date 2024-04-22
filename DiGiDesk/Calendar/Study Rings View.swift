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
    
    @State var StudyRings: Study_Rings_Data
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundStyle(Color.gray)
            Circle()
                .trim(from: 0.0, to: CGFloat(Double(StudyRings.CurrentStudyTime) / Double(StudyRings.StudyGoals)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundStyle(Color.blue)
                .rotationEffect(Angle(degrees: 270.0))
            VStack{
                Text("\(secondsToHours(StudyRings.CurrentStudyTime)) / \(secondsToHours(StudyRings.StudyGoals)) hours")
                    .font(.headline)
                    .bold()
                NavigationLink {
                    Update_StudyGoals_View(StudyRings: StudyRings)
                } label: {
                    Text("Change Goal Hours")
                        .frame(width: 200, height: 55)
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                }

            }
        }
        .padding(.horizontal)
    }
    private func secondsToHours(_ seconds: Int) -> String{
        let hours = seconds / 3600
        return String(format: "%.1f" , hours)
    }
}

struct Update_StudyGoals_View: View {
    
    @State var StudyRings: Study_Rings_Data
    @State private var updated_Study_Goal_Hours: Int = 0
    @Environment(\.modelContext) var Context
    
    var body: some View {
        VStack{
            if updated_Study_Goal_Hours <= 3600{
                Text("Study Goals: \(secondsToHours(updated_Study_Goal_Hours))hour / day")
                    .font(.title)
            }else{
                Text("StudyGoals: \(secondsToHours(updated_Study_Goal_Hours))hours / day")
            }
            Stepper{
            Text("Update Study Goals")
            }onIncrement:{
                incrementStudyGoalHours()
            }onDecrement:{
                decrementStudyGoalHours()
            }
        }
        .navigationTitle("Update Study Goal Hours")
    }
    func updateRingsData(_ ring: Study_Rings_Data){
        ring.StudyGoals = updated_Study_Goal_Hours
        try? Context.save()
    }
    private func secondsToHours(_ seconds: Int) -> String{
        let hours = seconds / 3600
        return String(format: "%.1f" , hours)
    }
    func incrementStudyGoalHours(){
        updated_Study_Goal_Hours += 3600
        if updated_Study_Goal_Hours >= 86399{
            updated_Study_Goal_Hours = 86399
        }
    }
    func decrementStudyGoalHours(){
        updated_Study_Goal_Hours -= 3600
        if updated_Study_Goal_Hours <= 0{
            updated_Study_Goal_Hours = 0
        }
    }
}

#Preview {
    Study_Rings_View(StudyRings: Study_Rings_Data(date: Date(), StudyGoals: 3600, CurrentStudyTime: 1800))
}
