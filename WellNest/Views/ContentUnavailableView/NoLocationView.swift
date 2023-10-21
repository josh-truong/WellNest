//
//  NoLocationView.swift
//  WellNest
//
//  Created by Joshua Truong on 10/17/23.
//

import SwiftUI

struct NoLocationView: View {
    var body: some View {
        ContentUnavailableView(label: {
            Label {
                Text("Location")
                    .font(.title)
                    .foregroundColor(.primary)
            } icon: {
                Image(systemName: "location.slash.fill")
                    .font(.system(size: 100))
            }
        }, description: {
            Text("Location access required")
                .bold()
        }, actions: {
            Button("Enable Permission") {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
        })
    }
}

#Preview {
    NoLocationView()
}
