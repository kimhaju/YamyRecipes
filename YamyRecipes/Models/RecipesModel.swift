//
//  RecipesModel.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import Foundation

struct RecipesModel: Identifiable {
    var id : String
    //->음식 이름,요리 분류(국물, 양식, 한식, 베이커리 등등),조리시간,재료, 평가, 조리법, 이미지들
    var cook_name: String
    var cook_tag: Int
    var cook_times: Int
    var cook_indigators: String
    var ratings: String
    var cook_level: Int
    var cook_details: String
    var cook_images = Array(repeating: Data(count: 0), count: 6)
    var writer: String
}
