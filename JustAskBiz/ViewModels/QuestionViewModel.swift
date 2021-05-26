//
//  QuestionViewModel.swift
//  JustAskBiz
//
//  Created by Aleksandar Lekov on 24/05/2021.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class QuestionViewModel:ObservableObject {
    
    @Published var questions = [Question]()
    
   
    @Published var question: Question = Question(userId: "", date: Date(), tags: [""], bodyText: "", totalAnswerLikes: 0, documentId: "")
   
//    @Published var answer: Answer = Answer(userId: "", date: Date(), bodyText: "", likes: 0)
    
    private var db = Firestore.firestore()
    
    func fetchData(){
        //get all questions
        db.collection("questionFinal").addSnapshotListener { ( querySnapshot, Error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.questions = documents.map{ ( queryDocumentSnapshot) -> Question in
                let data = queryDocumentSnapshot.data()
                
                let userId = data["userId"] as? String
                let bodyText = data["bodyText"] as? String
                let tags = data["tags"] as? [String]
                let date = data["date"] as? Date
                let totalAnswerLikes = data["totalAnswerLikes"] as? Int
                let documentId = data["documentId"] as? String
                return Question(userId: userId!, date: date!, tags: tags!, bodyText: bodyText!, totalAnswerLikes: totalAnswerLikes!,documentId: documentId ?? "null")
            }
        }
    }
    
    func addQuestion(question: Question)
    {
           
        var ref: DocumentReference? = nil
        ref = db.collection("questionFinal").addDocument(data: [
            "userId": question.userId,
            "date": question.date,
            "tags":question.tags,
            "bodyText":question.bodyText,
            "totalAnswerLikes":question.totalAnswerLikes,
            "documentId": question.documentId
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.db.collection("questionFinal").document(ref!.documentID).updateData([
                    "documentId":ref!.documentID
                ])
            }
        }
        
    }
    
   
    func getQuestionsByTag(tagsArray:[String])
    {
        for item in tagsArray {
            db.collection("questionFinal").whereField("tags",arrayContains:item).addSnapshotListener{ (querySnapshot, Error) in
                guard let documents = querySnapshot?.documents else{
                    print("Not found")
                    return
                }
                self.questions = documents.map{ (queryDocumentSnapshot) -> Question in
                    let data = queryDocumentSnapshot.data()
                    
                    let userId = data["userId"] as? String
                    let bodyText = data["bodyText"] as? String
                    let tags = data["tags"] as? [String]
                    let date = data["date"] as! Timestamp
                    let totalAnswerLikes = data["totalAnswerLikes"] as? Int
                    let documentId = data["documentId"] as? String
                    
                    return Question(userId: userId!, date: date.dateValue(), tags: tags!, bodyText: bodyText!, totalAnswerLikes: totalAnswerLikes!, documentId: documentId ?? "null")
                }
            }
        }
    }

    
    
    func saveNewQuestion(bodyText: String, tagsArray: [String]){
        question.bodyText = bodyText
        question.tags = tagsArray
        question.userId = Auth.auth().currentUser!.uid
    
        addQuestion(question: question)
    }


    
    
    
}
