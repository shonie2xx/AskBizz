//
//  ProfileViewModel.swift
//  JustAskBiz
//
//  Created by Daniel Vaswani on 22/05/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    @Published var profile: User = User(email:"", name:"", followers:0, likes:0, title:"",about: "",industry: "", profileImageUrl: "")
    let database = Firestore.firestore()
    
    func fetchData(userId: String) {
        guard (Auth.auth().currentUser?.uid) != nil else {
            print("User not found")
            return
        }
        
        let refDoc = database.collection("Users2").document(userId)
        refDoc.getDocument{ (document, err) in
            let result = Result {
                
                try document?.data(as: User.self)
                
            }
            switch result {
            case .success(let user):
                if let user = user {
                    let email = user.email
                    let name = user.name
                    let followers = user.followers
                    let likes = user.likes
                    let title = user.title
                    let about = user.about
                    let industry = user.industry
                    let profileImageUrl = user.profileImageUrl
                    
                    
                    self.profile = User (email: email, name: name, followers: followers, likes: likes, title: title, about: about, industry: industry, profileImageUrl: profileImageUrl)
                    print("User : \(user)")
                } else {
                    print("Document does not exist")
                }
            case .failure(let error):
                print("Error decoding user: \(error)")
            }
        }
    }
    
    func updateProfile(id : String , name: String, title: String, about: String) {
        guard (Auth.auth().currentUser?.uid) != nil else {
            print("User not found")
            return
        }
        print(id)
        let refDoc = database.collection("Users2").document(id)
        
        refDoc.getDocument{ (document, err) in
            let user = Result {
                try document?.data(as: User.self)
            }
            switch user {
                case .success(let user):
                    if let user = user {
                        print("User: \(user)")
                    } else {
                        // A nil value was successfully initialized from the DocumentSnapshot,
                        // or the DocumentSnapshot was nil.
                        print("Document does not exist")
                    }
                case .failure(let error):
                    // A `City` value could not be initialized from the DocumentSnapshot.
                    print("Error decoding city: \(error)")
                }
        }
        
        database.document(id)
            .updateData([
            "name" : name,
            "title" : title,
            "about" : about,
        ]) { (err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }else {
                print("Update data Success")
            }
        }
    }
    
    
}
