// FirebaseManager.swift
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct FriendActivity: Identifiable, Encodable, Decodable {
    var id: Int { return UUID().hashValue }
    var name: String = ""
    var image: String = ""
    var start: Int = 0
    var end: Int = 0
    var unit: String = ""
}

class FirebaseManager: ObservableObject {
    private var db = Firestore.firestore()
    @Published var activities: [FriendActivity] = []

    private var listener: ListenerRegistration?

    func startListening(user: User) {
        listener = Firestore.firestore().collection("activities").document(user.id)
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    print("Error fetching snapshot: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                if let activity = try? snapshot.data(as: FriendActivity.self) {
                    if let index = self.activities.firstIndex(where: { $0.id == activity.id }) {
                        self.activities[index] = activity
                    } else {
                        self.activities.append(activity)
                    }
                }
            }
    }

    func stopListening() {
        listener?.remove()
    }

    func addActivity(user: User, activity: FriendActivity) async {
        if let activity = activity.toDictionary {
            do {
                try await Firestore.firestore().collection("activities").document(user.id).setData(activity)
            } catch {
                print("\(error.localizedDescription)")
            }
        }
    }

    func deleteActivity(user: User, activityID: String) async {
        try? await Firestore.firestore().collection("activities").document(user.id).delete()
    }

    func fetchActivities(user: User) async {
        do {
            let snapshot = try await Firestore.firestore().collection("activities").document(user.id).getDocument()
            let activity = try snapshot.data(as: FriendActivity.self)
            self.activities = [activity]
        } catch {
            self.activities = []
            print("Error fetching activities: \(error.localizedDescription)")
        }
    }
}
