//
//  ProfileModalView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct ProfileModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile")
                    
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: closeModal) {
                        Text("Cancel")
                            .font(.title2)
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .font(.title2)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: closeModal) {
                        Text("Done")
                            .font(.title2)
                    }
                }
            }
            .padding()
        }
    }
    
    func closeModal() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct ProfileModalView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileModalView()
    }
}
