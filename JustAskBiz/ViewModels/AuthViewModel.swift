//
//  LoginViewModel.swift
//  JustAskBizz
//
//  Created by Aleksandar Lekov on 21/05/2021.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject{
    
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
        @Published var signedIn = false
    
        var isSignedIn: Bool {
            return auth.currentUser != nil
        }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email,
                    password: password) {[weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            // success
            // Open new view
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signUp(name: String , email: String, password: String, about : String, title : String) {
        auth.createUser(withEmail: email,
                        password: password) { result, error in
            guard result != nil, error == nil else {
                return
            }
            // success
            //create user document in firestore
            self.createFirestoreUser(email: email, name: name, about : about , title: title)
            self.signIn(email: email, password: password)
            
        }
    }
    
    func createFirestoreUser(email:String,name:String , about : String, title : String)
    {
        let uuid : String = auth.currentUser?.uid ?? ""
        let user: User = User(email: email, name: name, followers: 0, likes: 0, title: title ,  about: about, industry: "", profileImageUrl: "")
        
        let docRef  : DocumentReference = db.collection("Users2").document(uuid)
        
        do {
            try docRef.setData(from : user) // Save user
        } catch let error {
            print("Error writing city to Firestore: \(error)")
        }
        
    }
    
    func signOut(){
            try? auth.signOut()
            
            self.signedIn = false
        }

}
