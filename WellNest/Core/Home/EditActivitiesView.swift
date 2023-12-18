//
//  EditActivityView.swift
//  WellNest
//
//  Created by Joshua Truong on 12/17/23.
//

import SwiftUI

struct EditActivitiesView: View {
    @Environment(\.managedObjectContext) private var managedObjContext
    @Environment(\.dismiss) private var dismiss
    let entities: FetchedResults<ActivityEntity>
    @State var selectedEntity: FetchedResults<ActivityEntity>.Element?
    @State private var value: Float = 0.0
    @State private var showEdit: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(entities, id: \.id) { entity in
                    ActivityCard(entity, showProgress: false)
                        .onTapGesture {
                            selectedEntity = entity
                            value = Float(entity.goal)
                            showEdit.toggle()
                        }
                }
                .listRowSeparator(.hidden)
            }
            .navigationTitle("Activity Goals")
            .listStyle(.plain)
        }
        .sheet(isPresented: $showEdit) {
            VStack {
                CustomSlider(name: selectedEntity?.name ?? "", color: selectedEntity?.color?.uiColor ?? .clear, value: $value, min: 0, max: 300)
                    .padding(.horizontal, 30)
                HStack {
                    Spacer()
                    Button {
                        selectedEntity?.updateGoal(Int(value), context: managedObjContext)
                        dismiss()
                    } label: {
                        Text("Update Goal")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width-32, height: 48)
                    }
                    .background(Color(.systemBlue))
                    .cornerRadius(10)
                    .padding()
                    Spacer()
                }
            }
            .padding()
            .presentationDetents([.height(200)])
            .presentationCornerRadius(12)
        }
    }
}
