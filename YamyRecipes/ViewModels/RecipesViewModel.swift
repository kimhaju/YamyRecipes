//
//  RecipesViewModel.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import Foundation
import Firebase
import SwiftUI

class RecipesViewModel: ObservableObject {
    
    //->음식 이름,요리 분류(국물, 양식, 한식, 베이커리 등등),조리시간,재료, 평가, 조리법, 이미지들
    @Published var cook_name = ""
    @Published var cook_indigator = ""
    @Published var cook_details = ""
    @Published var cook_images = Array(repeating: Data(count: 0), count: 4)
    @Published var writer = ""
    
    @Published var isLoading = false
    @Published var alert = false
    @Published var alertMsg = ""
    
    @Published var searchRecipes = ""
    
    
    //->이미지 피커 
    @Published var picker = false
    
    private var db = Firestore.firestore()
    @Published var recipes = [RecipesModel]()
    @Published var filteredRecipes = [RecipesModel]()
   
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
            self.filteredRecipes = self.recipes
        }
    }
    
    func filterRecipes() {
        withAnimation(.linear){
            self.filteredRecipes = self.recipes.filter{
                return $0.cook_name.lowercased().contains(self.searchRecipes.lowercased())
            }
        }
    }
    
    func uploadPosting(userId: String, cookTag: String, cookTimes: String, cookLevel: String){
        
        let storage = Storage.storage().reference()
        let ref = storage.child("cookImage").child(UUID().uuidString)
        
        var urls : [String] = []
        
        isLoading.toggle()
        
        for index in cook_images.indices {
            
            ref.child("img\(index)").putData(cook_images[index], metadata: nil){ _, err in
                
                if err != nil {
                    self.alertMsg = err!.localizedDescription
                    self.alert.toggle()
                    self.isLoading.toggle()
                    return
                }
                
                ref.child("img\(index)").downloadURL { url, _ in
                    guard let imageUrl = url else { return }
                    
                    urls.append("\(imageUrl)")
                    
                    if urls.count == self.cook_images.count {
                        self.uploadImagePosting(urls: urls, userId: userId, cookTag: cookTag, cookTimes: cookTimes, cookLevel: cookLevel)
                    }
                }
            }
        }
    }
    
    func uploadImagePosting(urls: [String], userId: String, cookTag: String, cookTimes: String, cookLevel: String){
        
        db.collection("recipes").document().setData([
            "cook_details" : self.cook_details,
            "cook_images" : urls,
            "cook_indigator" : self.cook_indigator,
            "cook_level" : cookLevel,
            "cook_tag": cookTag,
            "cook_times": cookTimes,
            "cook_writer": userId,
            "cook_name": self.cook_name,
            "cook_ratings": "5"
        ]){ err in
            
            if err != nil {
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            print("글쓰는데 성공!")
            
        }
    }
}
