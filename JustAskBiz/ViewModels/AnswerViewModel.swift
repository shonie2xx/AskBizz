//
//  AnswerViewModel.swift
//  JustAskBiz
//
//  Created by Aleksandar Lekov on 25/05/2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class AnswerViewModel: ObservableObject{
    
    @Published var answers = [Answer]()
    
    private var db = Firestore.firestore()
    
    @Published var answer: Answer = Answer(userId: "", date: Date(), bodyText: "", likes: 0)
    
    func fetchData(qDocId: String)
    {
        db.collection("questionFinal").document(qDocId).collection("answers").addSnapshotListener{(querySnapshot, Error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            self.answers = documents.map{ ( queryDocumentSnapshot) -> Answer in
                let data = queryDocumentSnapshot.data()
                
                let userId = data["userId"] as? String
                let date = data["Date"] as? Date
                let bodyText = data["bodyText"] as? String
                let likes = data["likes"] as? Int
                
                return Answer(userId: userId!, date: date ?? Date(), bodyText: bodyText!, likes: likes!)
            }
        }
    }
    
    func addAnswer(qDocId:String, answer: Answer)
    {
        db.collection("questionFinal").document(qDocId).collection("answers")
            .addDocument(data: [
                "userId": answer.userId,
                "date": answer.date,
                "bodyText":answer.bodyText,
                "likes":answer.likes
            ]){err in
                if let err = err{
                    print("Error adding document: \(err)")
                }else{
                    print("Document added successfuly")
                }
            }
    }
    
    func saveAnswer(qDocId: String,bodyText: String)
    {
        answer.bodyText = bodyText
        answer.userId = Auth.auth().currentUser!.uid
        answer.date = Date()
        answer.likes = 0
        addAnswer(qDocId: qDocId, answer: answer)
    }
    
    func getAnswers(qDocId: String) -> [Answer] {
        fetchData(qDocId: qDocId)
        return answers
    }
}
