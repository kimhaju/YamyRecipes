//
//  HeartRecipes.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import SwiftUI
import SDWebImageSwiftUI

struct HeartRecipesView: View {
    
    @EnvironmentObject var recipesModel : RecipesViewModel
    @Namespace var animation
    @State var show = false
    @State private var tag : String = "전체"
    var user: UserModel?
    
    var body: some View {
        ScrollView {
            VStack{
                ForEach(self.recipesModel.heartRecipes){ item in
                    HeartCellView(recipes: item, user: user).environmentObject(RecipesViewModel())
                }
            }
        }.onAppear {
            self.recipesModel.getHeartRecipes(userID: user?.uid ?? "")
        }
    }
}

struct HeartCellView: View {
    var recipes : RecipesModel?
    @State var show = false
    @Namespace var animation
    var user: UserModel?
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            
            HStack{
                Button(action: {self.show.toggle()}){
                    WebImage(url: URL(string: recipes?.cook_images[0] ?? "")).resizable().frame(width: 100, height: 100).cornerRadius(10, corners: [.topLeft, .bottomLeft]).border(width: 1, edges: [.trailing], color: Color("mint"))
                }
                VStack{
                    HStack{
                        Text(recipes?.cook_name ?? "아직 맘에 든 레시피가 없습니다.").fontWeight(.heavy).font(.system(size: 20))
                        Image(systemName: "heart.fill").resizable().frame(width: 20, height: 20).foregroundColor(Color("mint"))
                    }
                    
                    Text(recipes?.cook_details ?? "").lineLimit(2).font(.footnote)
                }
                Button(action: {
                    recipesViewModel.deleteHeartRecipes(recipeId: recipes?.id ?? "", userID: user?.uid ?? "")
                }){
                    Image(systemName: "trash")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(14)
                        
                }.background(Color("mint"))
                    .clipShape(Circle())
            }
        }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("mint"), lineWidth: 4))
        .navigationTitle("\(user?.username ?? "")의 관심 레시피")
            .sheet(isPresented: self.$show){
                RecipesDetailView(recipes: recipes, show: $show, animation: animation, user: user).environmentObject(RecipesViewModel())
        }
    }
}
