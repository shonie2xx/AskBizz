//
//  Answer.swift
//  JustAskBiz
//
//  Created by Aleksandar Lekov on 22/05/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct Answer: Identifiable, Codable{
    @DocumentID public var id: String? = UUID().uuidString
    
    var userId: String
    var date : Date
    var bodyText: String
    var likes: Int
    
    enum CodingKeys: String, CodingKey{
        case userId
        case date
        case bodyText
        case likes
    }
}
