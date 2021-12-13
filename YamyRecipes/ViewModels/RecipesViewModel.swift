//
//  RecipesViewModel.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import Foundation
import Firebase

class RecipesViewModel: NSObject, ObservableObject {
    
    //->음식 이름,요리 분류(국물, 양식, 한식, 베이커리 등등),조리시간,재료, 평가, 조리법, 이미지들
    @Published var cook_name = ""
    @Published var cook_tag = ""
    @Published var cook_times = ""
    @Published var cook_indigators = ""
    @Published var ratings = ""
    @Published var cook_level = ""
    @Published var cook_details = ""
    @Published var cook_images = Array(repeating: Data(count: 0), count: 4)
    @Published var writer = ""
    
    
    //->이미지 피커 
    @Published var picker = false
    
    func uploadingPosting(urls : [String]){
        
    }
    
}
