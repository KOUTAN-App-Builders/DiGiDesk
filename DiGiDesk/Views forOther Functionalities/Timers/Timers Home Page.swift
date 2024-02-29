//
//  Timers Home Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/02/24.
//

import SwiftUI

struct Timers_Home_Page: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
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
