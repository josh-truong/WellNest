//
//  ProfileIconView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct ProfileIconView: View {
    @State private var enableProfileModal = false
    var body: some View {
        Button(action: {
            enableProfileModal = true
        }) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray)
                .clipShape(Circle())
                .frame(width:40, height:40)
        }
        .sheet(isPresented: $enableProfileModal) {
            ProfileSettingView()
                .background(.ultraThinMaterial)
        }
        .padding()
        
    }
}

struct ProfileIconView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileIconView()
    }
}
