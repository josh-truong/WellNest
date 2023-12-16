//
//  EditActivityView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import SwiftUI
import CoreData

struct EditActivityView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest var entries: FetchedResults<RecordEntity>
    @State private var activity: Activity
    @State private var input: String = ""
    
    init(activity: Activity) {
        _activity = State(initialValue: activity)
        let predicate = NSPredicate(format: "name CONTAINS[cd] %@", activity.name)
        let fetchRequest: NSFetchRequest<RecordEntity> = RecordEntity.fetchRequest()
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [ NSSortDescriptor(keyPath: \RecordEntity.timestamp, ascending: false) ]
        _entries = FetchRequest(fetchRequest: fetchRequest)
    }
    
    var body: some View {
        VStack {
            VStack {
                TextField("Enter value", text: $input)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .padding(.horizontal)
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    .keyboardType(.numberPad)
                    .onChange(of: input) { input = input.filter { "0123456789".contains($0) } }
            }
            .background(activity.color.opacity(0.3))

            List {
                ForEach(entries) { entry in
                    if let timestamp = entry.timestamp {
                        HStack {
                            Text("\(timestamp.formatted())")
                            Spacer()
                            Text("\(entry.quantity) \(activity.unit)")
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .navigationTitle("Record \(activity.name)")
        .toolbar {
            ToolbarItem {
                Button("add", action: {
                    RecordEntity().add(name: activity.name, quantity: Int(input) ?? 0, context: managedObjContext)
                    dismiss()
                })
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
            }
        }
    }
}

extension EditActivityView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !input.isEmpty
    }
}
