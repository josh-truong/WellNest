//
//  ActivityList.swift
//  WellNest
//
//  Created by Joshua Truong on 11/28/23.
//

import SwiftUI
import SwiftData

struct ActivityListView: View {
    @StateObject var vm = ActivityViewModel()
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            Button("Delete", action: { vm.clearActives() })
            ActivityCard(activity: Weight(), start: 360, end: 200, showProgress: false)
            ActivityCard(activity: Calories(), start: 0, end: 1000, showProgress: false)
            ActivityCard(activity: Water(), start: 0, end: 8, showProgress: false)
            
            LazyVGrid(columns: columns) {
                ForEach(vm.activeActivities, id: \.id) { info in
                    NavigationLink(destination: TimerView(info: info)) {
                        ActivityCard(activity: info.activity, start: info.start, end: info.end)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 1)
                
                NavigationLink(destination: MyActivityView(vm: vm)) {
                    ActivityButton()
                        .aspectRatio(1.0, contentMode: .fit)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .onAppear() {
            vm.preload()
            vm.getActiveActivities()
            vm.getInactiveActivities()
        }
    }
}
