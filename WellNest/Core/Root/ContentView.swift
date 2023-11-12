//
//  ContentView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if (viewModel.userSession != nil) {
                TabView {
                    HomeView()
                        .tabItem{
                            Image(systemName: "house")
                            Text("Home")
                        }
                    ExerciseView(viewModel: ExerciseViewModel(apiService: APIService()))
                        .tabItem{
                            Image(systemName: "bolt")
                            Text("Exercise")
                        }
                    MealView(viewModel: MealViewModel(apiService: APIService()))
                        .tabItem{
                            Image(systemName: "leaf")
                            Text("Nutrition")
                        }
                    FriendsView()
                        .tabItem{
                            Image(systemName: "person.2.fill")
                            Text("Friends")
                        }
                }
            } else {
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
