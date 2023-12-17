//
//  MealtimeCard.swift
//  WellNest
//
//  Created by Joshua Truong on 12/16/23.
//

import SwiftUI

struct MealtimeCard<Content: View>: View {
    @Environment(\.managedObjectContext) private var managedObjContext
    let type: MealtimeProtocol
    @Binding var info: MealtimeNutrientModel
    let destination: Content
    @State private var showMore: Bool = false
    
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
                    NavigationLink(destination: destination, label: {
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
                }
                .onTapGesture(count: 1) { 
                    withAnimation {
                        if !info.entities.isEmpty {
                            showMore.toggle()
                        }
                    }
                }
                .padding(.top, 5)
                
                if showMore {
                    VStack {
                        Divider()
                        ForEach(info.entities, id: \.self) { entity in
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(entity.name ?? "")
                                        .lineLimit(2)
                                        .truncationMode(.tail)
                                        .bold()
                                    Text("\(entity.energy)") +
                                    Text(" kcal").foregroundStyle(.red)
                                }
                                Spacer()
                                Button("", systemImage: "minus.circle", role: .destructive, action: { withAnimation { info.delete(entity, context: managedObjContext) } })
                            }
                            VStack {
                                
                                HStack {
                                    
                                    Spacer()
                                    Text(entity.timestamp ?? Date(), style: .time)
                                        .foregroundStyle(.gray)
                                        .italic()
                                }
                            }
                        }
                    }
                    .onChange(of: info.entities) { _, _ in withAnimation { showMore = !info.entities.isEmpty } }
                    .onDisappear() { showMore = false }
                    .onTapGesture(count: 2) { withAnimation { showMore.toggle() } }
                    .padding(.top, 5)
                }
            }
            .padding()
        }
    }
}

extension MealtimeCard {
    
}
