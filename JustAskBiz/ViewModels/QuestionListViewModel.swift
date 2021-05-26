////
////  QuestionListViewModel.swift
////  JustAskBiz
////
////  Created by Aleksandar Lekov on 23/05/2021.
////
//
//import Foundation
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class QuestionListViewModel: ObservableObject {
//    @Published var questions = [Question]()
//    
//    private var db = Firestore.firestore()
//    
//    func fetchData() {
//        db.collection("questionsNew").addSnapshotListener { ( querySnapshot, Error) in
//            guard let documents = querySnapshot?.documents else {
//                print("No documents")
//                return
//            }
//            
//            self.questions = documents.map{ ( queryDocumentSnapshot) -> Question in
//                let data = queryDocumentSnapshot.data()
//                
//                
//               
//                let userId = data["userId"] as? String
//                let bodyText = data["bodyText"] as? String
//                let tags = data["tags"] as? [String]
//                let date = data["date"] as? Date
//                let totalAnswerLikes = data["totalAnswerLikes"] as? Int
//                let answers = data["answers"] as? [Answer]
//                let documentId = data["documentId"] as? String
//                return Question(userId: userId!, date: date!, tags: tags!, bodyText: bodyText!, totalAnswerLikes: totalAnswerLikes!, answers: answers!,documentId: documentId!)
//            }
//        }
//    }
//    
//    func getQuestionsByTag(tagsArray:[String])
//    {
//        for item in tagsArray {
//            db.collection("questionsNew").whereField("tags",arrayContains:item).addSnapshotListener{ (querySnapshot, Error) in
//                guard let documents = querySnapshot?.documents else{
//                    print("Not found")
//                    return
//                }
//                self.questions = documents.map{ (queryDocumentSnapshot) -> Question in
//                    let data = queryDocumentSnapshot.data()
//                    
//                    let userId = data["userId"] as? String
//                    let bodyText = data["bodyText"] as? String
//                    let tags = data["tags"] as? [String]
//                    let date = data["date"] as! Timestamp
//                    let totalAnswerLikes = data["totalAnswerLikes"] as? Int
//                    let answers = data["answers"] as? [Answer] ?? [Answer]()
//                    let documentId = data["documentId"] as? String
//                    return Question(userId: userId!, date: date.dateValue(), tags: tags!, bodyText: bodyText!, totalAnswerLikes: totalAnswerLikes!, answers: answers,documentId: documentId ?? "NULL")
//                }
//            }
//        }
//    }
//    
//}
