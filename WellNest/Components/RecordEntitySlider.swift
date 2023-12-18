//
//  EditActivitySlider.swift
//  WellNest
//
//  Created by Joshua Truong on 12/17/23.
//

import SwiftUI

struct RecordEntitySlider: View {
    @Environment(\.managedObjectContext) private var managedObjContext
    @Environment(\.dismiss) private var dismiss
    @State private var value: Float = 0
    @State private var editMode: Bool = false
    let activity: Activity
    let min: Float
    let max: Float
    
    var body: some View {
        VStack {
            HStack {
                Button("edit", action: { editMode.toggle() })
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
            .padding(.top)
            
            CustomSlider(name: activity.name, color: activity.color, value: $value, min: min, max: max)
                .padding(.horizontal, 30)
            
            HStack {
                Spacer()
                Button {
                    if editMode {
                        setGoal(activity, value: Int(value))
                    } else {
                        RecordEntity().add(name: activity.name, quantity: Int(value), context: managedObjContext)
                    }
                    dismiss()
                } label: {
                    Text(editMode ? "Update Goal" : "Record")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width-32, height: 48)
                }
                .background(Color(.systemBlue))
                .cornerRadius(10)
                .padding()
                Spacer()
            }
        }
    }
    
    
    func getGoal(_ activity: Activity) -> Int {
        if UserDefaults.standard.object(forKey: activity.name) == nil {
            setGoal(activity, value: activity.goal)
        }
        return UserDefaults.standard.integer(forKey: activity.name)
    }

    func setGoal(_ activity: Activity, value: Int) {
        UserDefaults.standard.set(value, forKey: activity.name)
    }
}
