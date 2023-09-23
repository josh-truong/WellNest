//
//  ContentView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Home")
                }
             
            WorkoutView(viewModel: ExerciseViewModel(apiService: APIService()))
                .tabItem{
                    Image(systemName: "bolt")
                    Text("Workout")
                }
            MealView()
                .tabItem{
                    Image(systemName: "leaf")
                    Text("Nutrition")
                }
            MusicView()
                .tabItem{
                    Image(systemName: "music.note")
                    Text("Music")
                }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
