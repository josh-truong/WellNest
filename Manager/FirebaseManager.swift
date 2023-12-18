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
    @Published var activities: [String: [FriendActivity]] = [:]
    @Published var currentUser: User = .init()
    @Published var requests: [User] = []
    
    private var db = Firestore.firestore()
    private var activityListener: ListenerRegistration?
    private var userListener: ListenerRegistration?
    
    func getUserRequests() async {
        do {
            guard let user = try await findUserById(Auth.auth().currentUser?.uid ?? "") else { return }
            for fid in user.requests {
                do {
                    guard let friend = try await findUserById(fid) else { continue }
                    requests.append(friend)
                }
                catch { print("[DEBUG] \(error.localizedDescription)") }
            }
        } catch { print("[DEBUG] \(error.localizedDescription)") }
    }

    func startListening() {
        guard let user = Auth.auth().currentUser else { return }
        
        activityListener = Firestore.firestore().collection("activities").document(user.uid)
            .addSnapshotListener { snapshot, error in
//                guard let snapshot = snapshot else {
//                    print("Error fetching snapshot: \(error?.localizedDescription ?? "Unknown error")")
//                    return
//                }
//
//                if let data = snapshot.data() {
//                    let activitiesData = data["activities"] as? [[String: Any]] ?? []
//
//                    let activities = activitiesData.compactMap { activityData in
//                        do {
//                            return try Firestore.Decoder().decode(FriendActivity.self, from: activityData)
//                        } catch {
//                            print("Error decoding activity: \(error.localizedDescription)")
//                            return nil
//                        }
//                    }
//
//                    DispatchQueue.main.async {
//                        self.activities[self.currentUser.fullname] = activities
//                    }
//                }
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
    
    func findUserById(_ id: String) async throws -> User? {
        let document = Firestore.firestore().collection("users").document(id)

        do {
            let snapshot = try await document.getDocument()
            if let data = snapshot.data() {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: JSONSerialization.data(withJSONObject: data))
                return user
            } else {
                return nil
            }
        } catch {
            print("Error fetching document: \(error.localizedDescription)")
            throw error
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
    
    func acceptRequest(fid: String) async {
        print("Add friend")
        let users = Firestore.firestore().collection("users")
        
        do {
            if currentUser.friends.contains(fid) { return }
            currentUser.requests.removeAll { $0 == fid }
            currentUser.friends.append(fid)
            
            guard var friendUser = try await findUserById(fid) else { return }
            friendUser.friends.append(currentUser.id)
            
            try await users.document(currentUser.id).setData(currentUser.toJson())
            try await users.document(friendUser.id).setData(friendUser.toJson())
            await getUserRequests()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func declineRequest(fid: String) async {
        print("decline friend")
        let users = Firestore.firestore().collection("users")
        
        do {
            var currentUser = currentUser
            currentUser.requests.removeAll { $0 == fid }
            let updatedData: [String: Any] = ["requests": currentUser.requests]
            try await users.document(currentUser.id).updateData(updatedData)
            await getUserRequests()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addActivities(_ activities: [FriendActivity]) async {
        guard let user = Auth.auth().currentUser else { return }

        var activitiesData = [String: Any]()

        for activity in activities {
            do {
                let encodedActivity = try Firestore.Encoder().encode(activity)
                activitiesData[activity.name] = encodedActivity
            } catch {
                print("Error encoding activity: \(error.localizedDescription)")
            }
        }

        do {
            let documentData = ["activities": activitiesData]
            let userDocument = Firestore.firestore().collection("activities").document(user.uid)
            try await userDocument.setData(documentData)
        } catch {
            print("Error setting data in Firestore: \(error.localizedDescription)")
        }
    }

    func fetchActivities() async {
        do {
            guard let user = try await findUserById(Auth.auth().currentUser?.uid ?? "") else { return }
            for fid in user.friends {
                guard let friend = try await findUserById(fid) else { return }
                let snapshot = try await Firestore.firestore().collection("activities").document(fid).getDocument()
                let data = snapshot.data() ?? [:]
                let activitiesData = data["activities"] as? [String: Any] ?? [:]
                let activities = activitiesData.compactMap { key, value in
                    try? Firestore.Decoder().decode(FriendActivity.self, from: value)
                }

                self.activities[friend.fullname] = activities
            }
        } catch {
            self.activities = [:]
            print("Error fetching activities: \(error.localizedDescription)")
        }
    }
}
