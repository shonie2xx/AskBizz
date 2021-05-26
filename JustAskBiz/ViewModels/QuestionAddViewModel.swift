////
////  QuestionViewModel.swift
////  JustAskIt
////
////  Created by Aleksandar Lekov on 20/05/2021.
////
//
//import Foundation
//import Firebase
//import FirebaseFirestore
//import FirebaseFirestoreSwift
//
//class QuestionAddViewModel: ObservableObject {
//    
//    //    var userID = Auth.auth().currentUser?.uid
//    
//    @Published var question: Question = Question(userId: "", date: Date(), tags: [""], bodyText: "", totalAnswerLikes: 0, answers: [Answer](),documentId: "")
//    
//    private var db = Firestore.firestore()
//    
//    func addQuestion(question: Question)
//    {
////                do
////                {
////        //            self.question.userId = userID ?? "mamka mu"
////                    let _ = try db.collection("Questions2").addDocument(from: question)
////
////                }
////                catch{
////                    print(error)
////                }
//        var ref: DocumentReference? = nil
//        ref = db.collection("questionsNew").addDocument(data: [
//            "userId": question.userId,
//            "date": question.date,
//            "tags":question.tags,
//            "bodyText":question.bodyText,
//            "totalAnswerLikes":question.totalAnswerLikes,
//            "answers":question.answers,
//            "documentId": question.documentId
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//                self.db.collection("questionsNew").document(ref!.documentID).updateData([
//                    "documentId":ref!.documentID
//                ])
//            }
//        }
//    }
//        
////        var ref: DocumentReference? = nil
////        let newDocumentID = UUID().uuidString
////        ref = db.collection("questionsNew").document(newDocumentID).setData([
////            "userId" : question.userId
////            "date": question.date
////            "tags": question.tags,
////            "bodyText": question.bodyText,
////            "totalAnswerLikes": question.totalAnswerLikes,
////            "answers": question.answers,
////            "ID": newDocumentID
////        ], merge: true) { err in
////            if let err = err {
////                print("Error adding ride: \(err)")
////                completion(nil, err)
////            } else {
////                print("Ride added with ID: \(newDocumentID)")
////                completion(newDocumentID, nil)
////            }
////        }
////        var ref: DocumentReference? = nil
////        ref = db.collection("questionsNew").addDocument(data: question.getQuestionDict() ) { err in
////                if let err = err {
////                    print("Error adding document: \(err)")
////                } else {
////                    self.question.ID = ref!.documentID
////                    print(question.ID) //now you can work with the question and know it's ID
////                }
////            }
////    }
//    
//    
//    func save(bodyText: String, tagsArray: [String]){
//        question.bodyText = bodyText
//        question.tags = tagsArray
//        question.userId = Auth.auth().currentUser!.uid
//        addQuestion(question: question)
//    }
//}
