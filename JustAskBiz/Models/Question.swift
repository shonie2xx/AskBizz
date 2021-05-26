//
//  Question.swift
//  JustAskBizz
//
//  Created by Aleksandar Lekov on 22/05/2021.
//

import Foundation
import FirebaseFirestoreSwift

public struct Question: Identifiable, Codable {
 
    @DocumentID public var id: String? = UUID().uuidString
    var userId: String
    var date: Date
    var tags: [String]
    var bodyText: String
    var totalAnswerLikes: Int
    var documentId : String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case bodyText
        case tags
        case date
        case totalAnswerLikes
        case documentId
    }
}
