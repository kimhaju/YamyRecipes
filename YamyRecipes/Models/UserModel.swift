//
//  UserModel.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import Foundation

struct UserModel: Encodable, Decodable {
    var uid: String
    var email: String
    var profileImageUrl: String
    var username: String
    var searchName: [String]
}
