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
                    HeartCellView(recipes: item, user: user)
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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                WebImage(url: URL(string: recipes?.cook_images[0] ?? "")).resizable().frame(width: 100, height: 100)
                
                VStack{
                    Text(recipes?.cook_name ?? "아직 맘에 든 레시피가 없습니다.")
                    Text(recipes?.cook_details ?? "").lineLimit(2)
                }
                Button(action: {
                    self.show.toggle()
                }){
                    Image(systemName: "arrow.right")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(14)
                }.background(Color("butterfly"))
                    .clipShape(Circle())
            }
        }
    }
}

//struct HeartRecipesView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeartRecipesView()
//    }
//}
