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

@MainActor
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

                if let data = snapshot.data() {
                    let activitiesData = data["activities"] as? [String: Any] ?? [:]

                    let activities = activitiesData.compactMap { key, value in
                        try? Firestore.Decoder().decode(FriendActivity.self, from: value)
                    }

                    DispatchQueue.main.async {
                        self.activities = activities
                    }
                }
            }
    }

    func stopListening() {
        listener?.remove()
    }
    
    func sendRequest(email: String, user: User, completion: @escaping (Bool) -> Void) async {
        let users = Firestore.firestore().collection("users")
        do {
            let snapshot = try await users.whereField("email", isEqualTo: email).getDocuments()
            for document in snapshot.documents {
                if var friend = try? document.data(as: User.self) {
                    if (!friend.requests.contains(user.id)) {
                        friend.requests.append(user.id)
                        try users.document(friend.id).setData(from: friend, merge: true)
                        completion(true)
                    }
                }
            }
        } catch {
            completion(false)
        }
    }
    
    func acceptRequest(id: String, user: User) async {
        let users = Firestore.firestore().collection("users")
        
        var updatedUser = user
        updatedUser.requests.removeAll { $0 == id }
        updatedUser.friends.append(id)

        do {
            let userData = try JSONEncoder().encode(updatedUser)
            let userDictionary = try JSONSerialization.jsonObject(with: userData) as? [String: Any]

            try await users.document(user.id).setData(userDictionary ?? [:])
        } catch {
            print(error.localizedDescription)
        }
    }

    func addActivity(user: User, activity: FriendActivity) async {
        var activities = self.activities.reduce(into: [String: Any]()) { result, activity in
            result[activity.name] = try? Firestore.Encoder().encode(activity)
        }
        activities[activity.name] = try? Firestore.Encoder().encode(activity)

        do {
            try await Firestore.firestore().collection("activities").document(user.id).setData(["activities": activities])
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    func deleteActivity(user: User, activityID: String) async {
        var activities = self.activities.reduce(into: [String: Any]()) { result, activity in
            result[activity.name] = try? Firestore.Encoder().encode(activity)
        }
        activities[activityID] = nil

        do {
            try await Firestore.firestore().collection("activities").document(user.id).setData(["activities": activities])
        } catch {
            print("\(error.localizedDescription)")
        }
    }

    func fetchActivities(user: User) async {
        do {
            let snapshot = try await Firestore.firestore().collection("activities").document(user.id).getDocument()
            let data = snapshot.data() ?? [:]
            let activitiesData = data["activities"] as? [String: Any] ?? [:]

            let activities = activitiesData.compactMap { key, value in
                try? Firestore.Decoder().decode(FriendActivity.self, from: value)
            }

            self.activities = activities
        } catch {
            self.activities = []
            print("Error fetching activities: \(error.localizedDescription)")
        }
    }
}
