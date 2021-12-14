//
//  RecipeSearchView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import SwiftUI

struct RecipeSearchView: View {
    @EnvironmentObject var recipesModel : RecipesViewModel
    @Namespace var animation
    @State var show = false
    
    var body: some View {
        VStack{
            
        }
    }
}

struct CellView: View {
    
    var recipesModel : RecipesModel?
    @State var show = false
    @Namespace var animation
    
    
    var body : some View {
        VStack{
            Text("\(recipesModel?.cook_name ?? "레시피가 없습니다")")
        }
    }
}

//struct RecipeSearchView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        RecipeSearchView(recipesModel: RecipesModel)
//    }
//}
