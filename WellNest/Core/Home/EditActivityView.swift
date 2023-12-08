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
            TextField("Enter value", text: $input)
                .multilineTextAlignment(.center)
                .font(.title)
                .padding(.horizontal)
                .padding(.top, 12)
                .keyboardType(.numberPad)
                .onChange(of: input) { input = input.filter { "0123456789".contains($0) } }
            
            HStack {
                Spacer()
                Button {
                    Task {
                        RecordEntity().add(name: activity.name, quantity: Int(input) ?? 0, context: managedObjContext)
                        dismiss()
                    }
                } label: {
                    Text("RECORD")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-200, height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                Spacer()
            }

            // Display the entries
            List {
                ForEach(entries) { entry in
                    if let timestamp = entry.timestamp {
                        Text("Timestamp: \(timestamp.formatted()), Input: \(entry.quantity)")
                    }
                }
            }
        }
        .navigationTitle("Record \(activity.name)")
    }
}

extension EditActivityView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !input.isEmpty
    }
}
