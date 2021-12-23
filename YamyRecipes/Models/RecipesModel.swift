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
    var cook_tag: String
    var cook_times: String
    var cook_indigator: String
    var ratings: String
    var cook_level: String
    var cook_details: String
    var cook_images : [String]
    var cook_writer: String
    
    //->아이템 모델
    var isAdded: Bool = false
}

var cookTags = ["한식", "중식", "양식", "일식", "베이커리", "간식"]
var cookTimes = ["10분", "20분", "30분", "40분", "50분", "1시간"]
var cookLevels = ["쉬움", "보통", "어려움"]

var selectTags = ["한식", "중식", "양식", "일식", "베이커리", "간식", "전체"]
