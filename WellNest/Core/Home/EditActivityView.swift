//
//  EditActivityView.swift
//  WellNest
//
//  Created by Joshua Truong on 11/30/23.
//

import SwiftUI
import CoreData

struct Entry: Codable, Identifiable {
    var id = UUID()
    var timestamp: Date
    var input: Int
}

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
            TextField("Enter value", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)

            Button {
                RecordEntity().add(name: activity.name, quantity: Int(input) ?? 0, context: managedObjContext)
                dismiss()
            } label: {
                Text("Record")
            }

            // Display the entries
            List(entries) { entry in
                if let timestamp = entry.timestamp {
                    Text("Timestamp: \(timestamp.formatted()), Input: \(entry.quantity)")
                } else {
                    Text("Invalid Timestamp")
                }
            }
        }
    }
}
