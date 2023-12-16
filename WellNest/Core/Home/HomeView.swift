//
//  Home.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var chrono: ChronoViewModel
    @StateObject var vm = ActivityViewModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                PermActivityView(vm: vm)
                
                if !chrono.isRunning {
                    ActivityListView(vm: vm)
                } else {
                    TimerCard()
                }
            }
            .navigationTitle("Activity List")
            .profile()
            .padding()
        }
    }
}
