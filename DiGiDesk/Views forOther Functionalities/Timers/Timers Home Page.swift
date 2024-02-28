//
//  Timers Home Page.swift
//  DiGiDesk
//
//  Created by 加納塙大 Editor on 2024/02/24.
//

import SwiftUI

struct Timers_Home_Page: View {
    var body: some View {
        ScrollView{
            Section("Timer Type") {
                NavigationLink {
                    Normal_Timer_SetUp_Page()
                } label: {
                    Text("Ordinary Timer")
                }
                NavigationLink {
                    Pomodoro_Timer_SetUp_Page()
                } label: {
                    Text("Pomodoro Timer")
                }
                NavigationLink {
                    Repetition_Timer_SetUp_Page()
                } label: {
                    Text("Infinite Repetition Timer")
                }
                NavigationLink {
                    Test_Sim_Timer_SetUp_Page()
                } label: {
                    Text("Test Simulation Timer")
                }
            }
        }
    }
}

#Preview {
    NavigationView{
        Timers_Home_Page()
    }
}
