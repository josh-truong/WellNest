//
//  TimerCard.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import SwiftUI

struct TimerCard: View {
    @EnvironmentObject var chrono: ChronoViewModel
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            HStack {
                VStack {
                    HStack {
                        Text(chrono.entity?.activity.name ?? "")
                        Spacer()
                    }
                    HStack {
                        Image(systemName: chrono.entity?.image ?? "")
                            .foregroundStyle(chrono.entity?.color?.uiColor ?? .clear)
                        Text(chrono.model.elapsed.toStringPadded())
                            .font(.system(size: 35))
                        Spacer()
                    }
                    HStack {
                        Text("Started at \(chrono.model.started.toStringCivilian())")
                        Spacer()
                    }
                }
                Spacer()
                HStack {
                    switch(chrono.displayMode) {
                    case .setup, .start, .resume:
                        Button {
                            chrono.start()
                        } label: {
                            Image(systemName: "play")
                                .font(.system(size: 30))
                                .foregroundStyle(.black)
                        }
                        .padding()
                    case .pause:
                        Button {
                            chrono.pause()
                        } label: {
                            Image(systemName: "pause")
                                .font(.system(size: 30))
                                .foregroundStyle(.black)
                        }
                        .padding()
                    case .finish:
                        EmptyView()
                    }
                    Button {
                        chrono.finish()
                    } label: {
                        Image(systemName: "stop")
                            .font(.system(size: 30))
                            .foregroundStyle(.black)
                    }
                }
                .padding()
            }
            .padding()
        }
    }
}

#Preview {
    TimerCard()
}
