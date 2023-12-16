//
//  StopwatchView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/10/23.
//

import SwiftUI

struct StopwatchView: View {
    @EnvironmentObject var chrono: ChronoViewModel
    
    var body: some View {
        VStack {
            Spacer()
            Text(chrono.model.elapsed.toStringPadded())
                .font(.system(size: 50))
            Spacer()
        }
    }
}
