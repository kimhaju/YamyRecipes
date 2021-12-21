//
//  MsgModel.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/16.
//

import SwiftUI
import FirebaseFirestoreSwift

struct MsgModel: Codable, Identifiable, Hashable {

    @DocumentID var id: String?
    var msg : String
    var user: String
    var timeStamp: Date
  

    enum CodingKeys: String, CodingKey {
        case id
        case msg
        case user
        case timeStamp
        

    }
}
