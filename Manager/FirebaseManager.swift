// FirebaseManager.swift
import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

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
    @Published var activities: [FriendActivity] = []
    @Published var currentUser: User = .init()
    
    private var db = Firestore.firestore()
    private var activityListener: ListenerRegistration?
    private var userListener: ListenerRegistration?

    func startListening() {
        guard let user = Auth.auth().currentUser else { return }
        
        activityListener = Firestore.firestore().collection("activities").document(user.uid)
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
        
        userListener = Firestore.firestore().collection("users").document(user.uid)
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    print("Error fetching snapshot: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let data = try snapshot.data(as: User.self)
                    DispatchQueue.main.async {
                        self.currentUser = data
                    }
                } catch {
                    print("Error decoding activity data: \(error.localizedDescription)")
                }
            }
    }

    func stopListening() {
        activityListener?.remove()
    }
    
    func findUserByEmail(_ email: String) async -> User? {
        let users = Firestore.firestore().collection("users")

        do {
            let snapshot = try await users.whereField("email", isEqualTo: email).getDocuments()

            for document in snapshot.documents {
                if let user = try? document.data(as: User.self) {
                    return user
                }
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func sendRequest(email: String) async {
        let users = Firestore.firestore().collection("users")
        do {
            if var friend = await findUserByEmail(email) {
                if (!friend.requests.contains(currentUser.id) && !friend.friends.contains(currentUser.id)) {
                    friend.requests.append(currentUser.id)
                    try users.document(friend.id).setData(from: friend, merge: true)
                }
            }
        } catch {
            print("Friend request failed! \(error.localizedDescription)")
        }
    }
    
    func acceptRequest(id: String) async {
        let users = Firestore.firestore().collection("users")
        
        var updatedUser = currentUser
        updatedUser.requests.removeAll { $0 == id }
        updatedUser.friends.append(id)

        do {
            let userData = try JSONEncoder().encode(updatedUser)
            let userDictionary = try JSONSerialization.jsonObject(with: userData) as? [String: Any]
            
            if !currentUser.friends.contains(id) {
                try await users.document(currentUser.id).setData(userDictionary ?? [:])
            }
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

    func fetchActivities() async {
        do {
            let snapshot = try await Firestore.firestore().collection("activities").document(currentUser.id).getDocument()
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
