//
//  ProfileModalView.swift
//  WellNest
//
//  Created by Joshua Truong on 9/14/23.
//

import SwiftUI

struct ProfileModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isAnimating = false
    @State private var moveButtonRight = false
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Spacer()
                        UserProfileView(userName: "John Doe")
                        Spacer()
                    }
                    SlidingButtonView(toggle: $isAnimating, lhs:"Profile", rhs:"Settings")
                        .frame(width: 300)
                    ScrollView {
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                                    .padding()
                                    
                    }
                    .frame(height: isPresented ? geometry.size.height : geometry.size.height*0.25)
                    Spacer()
                    LikeButtonView()
                }
                .onTapGesture {
                    withAnimation {
                        isPresented.toggle()
                    }
                }
                .background(.ultraThinMaterial)
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
            }
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
