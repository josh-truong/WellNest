//
//  MusicView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct MusicView: View {
    var body: some View {
        NavigationView {
            Text("Workout music")
                .navigationTitle("Music")
        }
        
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView()
    }
}
