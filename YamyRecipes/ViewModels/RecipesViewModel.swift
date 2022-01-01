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
    @Published var selectRecipes = [RecipesModel]()
    
    //->마음에 든 레시피 표시
    @Published var heartRecipes = [RecipesModel]()
   
    func getRecipes() {
        db.collection("recipes").whereField("report", isEqualTo: false).addSnapshotListener { snapshot, error in
            
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
                let writer = data["cook_writer"] as? String ?? ""
                let cookLevel = data["cook_level"] as? String ?? ""
                let cookDetail = data["cook_details"] as? String ?? ""
                let cookImages = data["cook_images"] as? Array ?? [""]
                let report = data["report"] as? Bool ?? false
                let isHeart = data["is_heart"] as? Bool ??  false
 
                return RecipesModel(id: id, cook_name: cookName, cook_tag: cookTag, cook_times: cookTime, cook_indigator: cookIndigator, ratings: ratings, cook_level: cookLevel, cook_details: cookDetail, cook_images: cookImages, cook_writer: writer, is_heart: isHeart, report: report)
                 
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
    //->내일은 태그별로 구현할수 있는거 구현하기 
    func tagRecipes(tag: String){
        db.collection("recipes").whereField("cook_tag", isEqualTo: tag).addSnapshotListener { snapshot, error in
            
            guard let documents = snapshot?.documents else {
                print("데이터를 찾을 수 없습니다.")
                return
            }
            
            self.selectRecipes = documents.map { snap -> RecipesModel in
                let data = snap.data()
                
                let id = snap.documentID
                let cookName = data["cook_name"] as? String ?? ""
                let cookTag = data["cook_tag"] as? String ?? ""
                let cookTime = data["cook_time"] as? String ?? ""
                let cookIndigator = data["cook_indigator"] as? String ?? ""
                let ratings = data["ratings"] as? String ?? ""
                let writer = data["cook_writer"] as? String ?? ""
                let cookLevel = data["cook_level"] as? String ?? ""
                let cookDetail = data["cook_details"] as? String ?? ""
                let cookImages = data["cook_images"] as? Array ?? [""]
                let report = data["report"] as? Bool ?? false
                let isHeart = data["is_heart"] as? Bool ?? false
                
                return RecipesModel(id: id, cook_name: cookName, cook_tag: cookTag, cook_times: cookTime, cook_indigator: cookIndigator, ratings: ratings, cook_level: cookLevel, cook_details: cookDetail, cook_images: cookImages, cook_writer: writer, is_heart: isHeart, report: report)
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
            "ratings": "5",
            "report" : false,
            "is_heart": false
        ]){ err in
            
            if err != nil {
                self.alertMsg = err!.localizedDescription
                self.alert.toggle()
                return
            }
            
            print("글쓰는데 성공!")
            
        }
    }

    //->이미지 수정은 잠시 보류
    
    func editRecipes(recipesId: String, cookName: String, cookdetail: String, cookIndigator: String, cookLevel: String,
                     cookTag: String, cookTime: String){
        
        db.collection("recipes").document(recipesId).updateData(
            [
                "cook_name" : cookName,
                "cook_details": cookdetail,
                "cook_level": cookLevel,
                "cook_tag": cookTag,
                "cook_time": cookTime,
                "cook_indigator": cookIndigator
                
            ]){ error in
                
                if error != nil {
                    print("Error")
                }else {
                    print("성공적으로 내용을 바꿨습니다!")
                }
            }
    }
    
    func deleteRecipes(deleteId: String){
        db.collection("recipes").document(deleteId).delete { error in
            if error != nil {
                print("삭제하는데 문제가 생겼습니다.\(error?.localizedDescription)")
            }else {
                print("레시피 삭제 완료")
            }
        }
    }
    
    //->신고 접수
    func reportRecipes(recipeId: String){
        db.collection("recipes").document(recipeId).updateData([
            "report" : true
        ]){ error in
            if error != nil {
                print("Error")
            }else {
                print("신고 접수 완료 ")
            }
            
        }
    }
    
    func userHeartRecipes(userID: String, cookDetail: String, cookImage: [String], cookIndigator: String, cookLevel: String, cookTag: String
                          ,cookTime: String, cookWriter: String, cookName: String, rating: String, isHeart: Bool){
       
        db.collection("users").document(userID).collection("heart_recipes").document().setData([
            "cook_name":cookName,
            "cook_images" : cookImage,
            "cook_writer": cookWriter,
            "cook_details": cookDetail,
            "cook_indigator": cookIndigator,
            "cook_level": cookLevel,
            "cook_times": cookTime,
            "ratings": rating,
            "cook_tag": cookTag,
            "report": false,
            "is_heart": isHeart
        ])
    }
    
    func deleteHeartRecipes(recipeId: String, userID: String){
        db.collection("users").document(userID).collection("heart_recipes").document(recipeId).delete { error in
            if error != nil {
                print("삭제하는데 문제가 생겼습니다.")
            }else {
                print("삭제 완료")
            }
        }
    }
    
    func getHeartRecipes(userID: String){
        db.collection("users").document(userID).collection("heart_recipes").addSnapshotListener { snapshot, error in
            
            guard let documents = snapshot?.documents else {
                print("데이터를 찾을 수 없습니다.")
                return
            }
            
            self.heartRecipes = documents.map { snap in
                let data = snap.data()
                let id = snap.documentID
                
                let cookName = data["cook_name"] as? String ?? ""
                let cookTag = data["cook_tag"] as? String ?? ""
                let cookTime = data["cook_time"] as? String ?? ""
                let cookIndigator = data["cook_indigator"] as? String ?? ""
                let ratings = data["ratings"] as? String ?? ""
                let writer = data["cook_writer"] as? String ?? ""
                let cookLevel = data["cook_level"] as? String ?? ""
                let cookDetail = data["cook_details"] as? String ?? ""
                let cookImages = data["cook_images"] as? Array ?? [""]
                let report = data["report"] as? Bool ?? false
                let isHeart = data["is_heart"] as? Bool ?? false
                
                return RecipesModel(id: id, cook_name: cookName, cook_tag: cookTag, cook_times: cookTime, cook_indigator: cookIndigator, ratings: ratings, cook_level: cookLevel, cook_details: cookDetail, cook_images: cookImages, cook_writer: writer, is_heart: isHeart, report: report)

            }
        }
    }
    //->이미 있는 레시피 검증 메서드 만들자 ㅅㅂ
    //->이름은 같을수 있어도 디테일은 다를테니까 이름과 디테일로 판단
    func checkHeartRecipes(cookDetail: String){
        
    
    }
}



