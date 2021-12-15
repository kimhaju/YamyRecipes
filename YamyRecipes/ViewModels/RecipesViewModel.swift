//
//  RecipesViewModel.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import Foundation
import Firebase

class RecipesViewModel: ObservableObject {
    
    //->음식 이름,요리 분류(국물, 양식, 한식, 베이커리 등등),조리시간,재료, 평가, 조리법, 이미지들
    @Published var cook_name = ""
    @Published var cook_tag = ""
    @Published var cook_times = ""
    @Published var cook_indigators = ""
    
    @Published var cook_level = ""
    @Published var cook_details = ""
    @Published var cook_images = Array(repeating: Data(count: 0), count: 4)
    @Published var writer = ""
    
    //->이미지 피커 
    @Published var picker = false
    
    private var db = Firestore.firestore()
    @Published var recipes = [RecipesModel]()
   
    func getRecipes() {
        db.collection("recipes").addSnapshotListener { snapshot, error in
            
            guard let documents = snapshot?.documents else {
                print("데이터를 찾을수 없습니다.")
                return
            }
            self.recipes = documents.map{ snap -> RecipesModel in
                let data = snap.data()
                
                let id = snap.documentID
                let cookName = data["cook_name"] as? String ?? ""
                let cookTag = data["cook_tag"] as? String ?? ""
                let cookTime = data["cook_time"] as? String ?? ""
                let cookIndigator = data["cook_indigator"] as? String ?? ""
                let ratings = data["ratings"] as? String ?? ""
                let writer = data["writer"] as? String ?? ""
                let cookLevel = data["cook_level"] as? String ?? ""
                let cookDetail = data["cook_details"] as? String ?? ""
                let cookImages = data["cook_images"] as? Array ?? [""]
                
                return RecipesModel(id: id, cook_name: cookName, cook_tag: cookTag, cook_times: cookTime, cook_indigator: cookIndigator, ratings: ratings, cook_level: cookLevel, cook_details: cookDetail, cook_images: cookImages, writer: writer)
                 
            }
        }
    }
}
