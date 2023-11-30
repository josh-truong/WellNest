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
    @StateObject var ingredientVM = IngredientViewModel()
    
    var body: some View {
        Group {
            if (viewModel.userSession != nil) {
                TabView(selection: .constant(1)) {
                    IngredientsView()
                        .tabItem{
                            Image(systemName: "leaf")
                            Text("Nutrition")
                        }
                        .tag(0)
                    HomeView()
                        .tabItem{
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(1)
                    FriendsView()
                        .tabItem{
                            Image(systemName: "person.2.fill")
                            Text("Friends")
                        }
                        .tag(2)
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
