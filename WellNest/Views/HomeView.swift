//
//  Home.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ScrollView {

            }
            .navigationTitle("Home")
                .toolbarProfileIcon()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
