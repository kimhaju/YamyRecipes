//
//  HeartRecipes.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/18.
//

import Foundation

struct HeartRecipes: Identifiable {
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
    var is_heart: Bool
    
    //->신고시스템 삐용삐용
    var report: Bool
}
