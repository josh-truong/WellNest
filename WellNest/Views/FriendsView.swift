//
//  MusicView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct FriendsView: View {
    var body: some View {
        NavigationView {
            ScrollView {
            }
            .toolbarNavBar("Friends")
        }
        
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
