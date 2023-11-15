//
//  WorkoutCategory.swift
//  WellNest
//
//  Created by Joshua Truong on 9/21/23.
//

import SwiftUI

struct ExerciseCategoryView: View {
    @ObservedObject var exerciseVM: ExerciseViewModel
    @ObservedObject var exerciseCategoryVM: ExerciseCategoryViewModel
    @ObservedObject var notificationViewModel = PushNotificationService()
    
    var label: String
    var exercises: [WgerExerciseDetail]
    
    @State private var showExerciseModal = false
    @State private var showNotificationModal = false
    @State private var confirm = false
    @State private var notificationTime = Date()
    
    var body: some View {
        DisclosureGroup(label) {
            ForEach(exercises) { exercise in
                HStack {
                    Button(action: {
                        exerciseCategoryVM.selectedExercise = exercise
                        showExerciseModal = true
                    }) {
                        Text(exercise.name)
                            .foregroundStyle(.black)
                    }

                    Spacer()
                    
                    Button(action: {
                        exerciseCategoryVM.selectedExercise = exercise
                        showNotificationModal = true
                    }) {
                        Image(systemName: "bell")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
        .sheet(isPresented: $showExerciseModal) {
            ExerciseDetailView(viewModel: exerciseCategoryVM)
        }
        .sheet(isPresented: $showNotificationModal) {
            VStack {
                Text("Notification Permission Status:")
                    .font(.title)

                if notificationViewModel.isPermissionGranted {
                    Text("Permission Granted")
                        .foregroundColor(.green)
                } else {
                    Text("Permission Denied")
                        .foregroundColor(.red)
                }

                DatePicker("Select Notification Time", selection: $notificationTime, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
                
                Button("Schedule Notification") {
                    notificationViewModel.scheduleNotification(
                        title: "\(exerciseCategoryVM.selectedExercise.category) Workout Reminder",
                        body: exerciseCategoryVM.selectedExercise.name,
                        time: notificationTime
                    )
                    confirm = true
                }
                
                if confirm {
                    Text("Will notify at \(notificationTime)")
                        .foregroundColor(.green)
                }
            }
        }
    }
}



struct ExerciseCategory_Previews: PreviewProvider {
    @ObservedObject static var exerciseVM = ExerciseViewModel(apiService: APIService.shared)
    @ObservedObject static var exerciseCategoryVM = ExerciseCategoryViewModel(apiService: APIService.shared)
    private static let exercise: WgerExerciseDetail = WgerExerciseData().getWgerExerciseDetail()
    
    static var previews: some View {
        exerciseCategoryVM.selectedExercise = exercise
        return ExerciseCategoryView(exerciseVM: exerciseVM, exerciseCategoryVM: exerciseCategoryVM, label: "Chest", exercises: [exercise])
    }
}
