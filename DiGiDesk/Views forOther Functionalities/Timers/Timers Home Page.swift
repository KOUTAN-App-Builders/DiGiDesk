//
//  Timers Home Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/02/24.
//

import SwiftUI
import SwiftData

struct Timers_Home_Page: View {
    
    @Query private var StudyRings: [Study_Rings_Data]
    @State private var viewModel = Calendar_Task_ViewModel()
    @Environment(\.modelContext) var Context
    
    init(){
        _StudyRings = Query(
            filter: Study_Rings_Data.predicate(searchDate: Date())
        )
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            if StudyRings.count == 1{
                ForEach(StudyRings){ ring in
                    NavigationLink {
                        Normal_Timer_SetUp_Page()
                    } label: {
                        HStack{
                            Image(systemName: "timer")
                                .padding(.trailing)
                            VStack(alignment: .leading){
                                Text("Ordinary Timer")
                                    .font(.headline)
                                    .bold()
                                Text("Creates an unrepeated ordinary timer.")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding(.vertical)
                    Divider()
                    NavigationLink {
                        Pomodoro_Timer_SetUp_Page()
                    } label: {
                        HStack{
                            Image(systemName: "brain.head.profile")
                                .padding(.trailing)
                            VStack(alignment: .leading){
                                Text("Pomodoro Timer")
                                    .font(.headline)
                                    .bold()
                                Text("Creates a Pomodoro Session.")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding(.vertical)
                    Divider()
                    NavigationLink {
                        Repetition_Timer_SetUp_Page()
                    } label: {
                        HStack{
                            Image(systemName: "repeat")
                                .padding(.trailing)
                            VStack(alignment: .leading){
                                Text("Infinite Repetition Timer")
                                    .font(.headline)
                                Text("Creates a timer with repetition.")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding(.vertical)
                    Divider()
                    NavigationLink {
                        Test_Sim_Timer_SetUp_Page()
                    } label: {
                        HStack{
                            Image(systemName: "pencil.and.list.clipboard")
                                .padding(.trailing)
                            VStack(alignment: .leading){
                                Text("Test Simulation Timer")
                                    .font(.headline)
                                    .bold()
                                Text("Creates a timer to simulate real life exams.")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding(.vertical)
                    Divider()
                    Study_Rings_View(StudyRings: ring)
                }
            }
            if StudyRings.count == 0{
                NavigationLink {
                    Normal_Timer_SetUp_Page()
                } label: {
                    HStack{
                        Image(systemName: "timer")
                            .padding(.trailing)
                        VStack(alignment: .leading){
                            Text("Ordinary Timer")
                                .font(.headline)
                                .bold()
                            Text("Creates an unrepeated ordinary timer.")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.vertical)
                Divider()
                NavigationLink {
                    Pomodoro_Timer_SetUp_Page()
                } label: {
                    HStack{
                        Image(systemName: "brain.head.profile")
                            .padding(.trailing)
                        VStack(alignment: .leading){
                            Text("Pomodoro Timer")
                                .font(.headline)
                                .bold()
                            Text("Creates a Pomodoro Session.")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.vertical)
                Divider()
                NavigationLink {
                    Repetition_Timer_SetUp_Page()
                } label: {
                    HStack{
                        Image(systemName: "repeat")
                            .padding(.trailing)
                        VStack(alignment: .leading){
                            Text("Infinite Repetition Timer")
                                .font(.headline)
                            Text("Creates a timer with repetition.")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.vertical)
                Divider()
                NavigationLink {
                    Test_Sim_Timer_SetUp_Page()
                } label: {
                    HStack{
                        Image(systemName: "pencil.and.list.clipboard")
                            .padding(.trailing)
                        VStack(alignment: .leading){
                            Text("Test Simulation Timer")
                                .font(.headline)
                                .bold()
                            Text("Creates a timer to simulate real life exams.")
                                .font(.subheadline)
                        }
                    }
                }
                Divider()
                Text("Error Generating Rings")
                    .font(.title)
                Text("Auto creation of study rings is not possible now.")
                    .font(.headline)
                Text("You can manually create a ring below, but study hours will not be added even when you study with the timer. -> Coming in Future Updates")
                    .font(.subheadline)
                Button(action: {addRings()}, label: {
                    Text("Create Study Ring")
                })
            }
            /*if StudyRings.count != 0 | 1{
                NavigationLink {
                    Normal_Timer_SetUp_Page()
                } label: {
                    HStack{
                        Image(systemName: "timer")
                            .padding(.trailing)
                        VStack(alignment: .leading){
                            Text("Ordinary Timer")
                                .font(.headline)
                                .bold()
                            Text("Creates an unrepeated ordinary timer.")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.vertical)
                Divider()
                NavigationLink {
                    Pomodoro_Timer_SetUp_Page()
                } label: {
                    HStack{
                        Image(systemName: "brain.head.profile")
                            .padding(.trailing)
                        VStack(alignment: .leading){
                            Text("Pomodoro Timer")
                                .font(.headline)
                                .bold()
                            Text("Creates a Pomodoro Session.")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.vertical)
                Divider()
                NavigationLink {
                    Repetition_Timer_SetUp_Page()
                } label: {
                    HStack{
                        Image(systemName: "repeat")
                            .padding(.trailing)
                        VStack(alignment: .leading){
                            Text("Infinite Repetition Timer")
                                .font(.headline)
                            Text("Creates a timer with repetition.")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.vertical)
                Divider()
                NavigationLink {
                    Test_Sim_Timer_SetUp_Page()
                } label: {
                    HStack{
                        Image(systemName: "pencil.and.list.clipboard")
                            .padding(.trailing)
                        VStack(alignment: .leading){
                            Text("Test Simulation Timer")
                                .font(.headline)
                                .bold()
                            Text("Creates a timer to simulate real life exams.")
                                .font(.subheadline)
                        }
                    }
                }
                .padding(.vertical)
                Divider()
                Text("Error Creating Rings")
                    .font(.title)
                Text("An error occured and there are more than two rings for today.")
                    .font(.headline)
                Text("I'd appreciate it if you can report this error on my GitHub Issue page which is linked below.")
                    .font(.subheadline)
                Link("GitHub Issue Report Page", destination: URL(string: "https://github.com/KOUTAN-App-Builders/DiGiDesk")!)
            }*/
        }
        .padding(.leading, 30)
        .navigationTitle("Timer Type")
    }
    func addRings(){
        let newRing = Study_Rings_Data(date: Date(), StudyGoals: 10800, CurrentStudyTime: 0)
        Context.insert(newRing)
    }
}

#Preview {
    NavigationView{
        Timers_Home_Page()
    }
}
