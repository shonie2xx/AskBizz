//
//  User.swift
//  JustAskBizz
//
//  Created by Aleksandar Lekov on 22/05/2021.
//

import Foundation
import FirebaseFirestoreSwift

struct User : Identifiable, Codable {
    @DocumentID var id : String? = UUID().uuidString
    var email: String
    var name: String
    var followers: Int
    var likes: Int
    var title: String
    var about : String
    var industry: String
    var profileImageUrl : String?
    
    enum CodingKeys: String, CodingKey{
        case email
        case name
        case followers
        case likes
        case title
        case about
        case industry
        case profileImageUrl
    }
}
