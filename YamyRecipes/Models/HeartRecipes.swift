//
//  HeartRecipes.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/18.
//

import Foundation

struct HeartRecipes: Identifiable {
    
    var id = UUID().uuidString
    var love_recipes: RecipesModel
    var quantity: Int
}
