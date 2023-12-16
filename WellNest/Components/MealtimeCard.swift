//
//  MealtimeCard.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import SwiftUI

struct MealtimeCard: View {
    let type: MealtimeProtocol
    let info: MealtimeNutrientModel
    let action: () -> Void
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            
            VStack {
                HStack {
                    Image(systemName: type.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundStyle(type.color)
                    VStack(alignment: .leading) {
                        Text(type.name.rawValue)
                            .title()
                        Text("Goal: \(info.goal) calories")
                            .subtitle()
                    }
                    Spacer()
                    Button(action: { action() }, label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.blue)
                    })
                }
                Divider()
                HStack(alignment: .center) {
                    VStack{
                        Text("Calories")
                            .subtitle()
                        Text("\(info.calories)")
                            .title()
                    }
                    Spacer()
                    VStack {
                        Text("Protein")
                            .subtitle()
                        Text(info.protein.formattedString)
                            .title()
                    }
                    Spacer()
                    VStack {
                        Text("Carbs")
                            .subtitle()
                        Text(info.carbs.formattedString)
                            .title()
                    }
                    Spacer()
                    VStack {
                        Text("Fat")
                            .subtitle()
                        Text(info.fat.formattedString)
                            .title()
                    }
                    .padding(.trailing, 10)
                }
                .padding(.top, 5)
            }
            .padding()
        }
    }
}
