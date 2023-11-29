//
//  ActivityList.swift
//  WellNest
//
//  Created by Joshua Truong on 11/28/23.
//

import SwiftUI

struct ActivityListView: View {
    let activities: [ActivityInfo] = [
        ActivityInfo(activity: Steps(), start: 6545, end: 10000),
        ActivityInfo(activity: CaloriesBurned(), start: 6545, end: 10000),
        ActivityInfo(activity: Running(), start: 6545, end: 10000),
        ActivityInfo(activity: WeightLifting(), start: 6545, end: 10000),
        ActivityInfo(activity: Cycling(), start: 6545, end: 10000),
        ActivityInfo(activity: Hiking(), start: 6545, end: 10000),
        ActivityInfo(activity: Water(), start: 6545, end: 10000),
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(activities, id: \.id) { info in
                NavigationLink(destination: ActivityDetailView(info: info)) {
                    ActivityCard(activity: info.activity, start: info.start, end: info.end)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 1)
            
            NavigationLink(destination: ExerciseView(viewModel: ExerciseViewModel(apiService: APIService.shared))) {
                ActivityButton()
                    .aspectRatio(1.0, contentMode: .fit)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct AddActivityView: View {
    var body: some View {
        NavigationStack {
            Text("Hell")
        }
    }
}


#Preview {
    ActivityListView()
}
