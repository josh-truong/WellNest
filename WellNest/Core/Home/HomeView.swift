//
//  Home.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @StateObject var vm = ActivityViewModel()
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                PermActivityView(vm: vm)
                ActivityListView(vm: vm)
            }
            .navigationTitle("Activity List")
            .profile()
            .padding()
        }
    }
}
