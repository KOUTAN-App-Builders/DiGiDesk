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
                    Repeatation_Timer_SetUp_Page()
                } label: {
                    Text("Infinite Repetation Timer")
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

struct Normal_Timer_SetUp_Page: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct Pomodoro_Timer_SetUp_Page: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct Repeatation_Timer_SetUp_Page: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

struct Test_Sim_Timer_SetUp_Page: View {
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

#Preview {
    Timers_Home_Page()
}
