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
            }else{
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
                Text("Error Loading Rings")
                    .font(.title)
                Text("An error occured regarding the generation & load for the Study Rings for today.")
                    .font(.headline)
                Text("I'd appreciate it if you can report this error on my GitHub Issue page which is linked below.")
                    .font(.subheadline)
                Link("GitHub Issue Report Page", destination: URL(string: "https://github.com/KOUTAN-App-Builders/DiGiDesk")!)
            }
        }
        .padding(.leading, 30)
        .navigationTitle("Timer Type")
    }
}

#Preview {
    NavigationView{
        Timers_Home_Page()
    }
}
