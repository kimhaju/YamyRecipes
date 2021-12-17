//
//  RecipeSearchView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import SwiftUI
import SDWebImageSwiftUI

// MARK: - 본체
struct RecipeSearchView: View {
    @EnvironmentObject var recipesModel : RecipesViewModel
    @Namespace var animation
    @State var show = false
    @State private var tag : String = "한식"
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Image(systemName: "magnifyingglass").foregroundColor(Color(UIColor.systemIndigo)).padding()
                    TextField("메뉴를 검색하세요", text: $recipesModel.searchRecipes)
                    
                    if recipesModel.searchRecipes != "" {
                        Button(action: {}, label: {
                            Image(systemName: "plus").resizable().frame(width: 10, height: 10).padding()
                        })
                    }
                    Divider().frame(height: 24)
                }.foregroundColor(Color.secondary.opacity(0.5)).background(Color.gray.opacity(0.1)).cornerRadius(80).shadow(radius: 1).padding()
                
                HStack(spacing: 10){
                    Text("태그 선택: ").fontWeight(.bold)
                    ForEach(cookTags, id: \.self){ selectTag in
                        Button(action: {tag = selectTag}){
                            Text("\(selectTag)")
                                .fontWeight(.bold)
                                .foregroundColor(tag == selectTag ? Color.white : Color("butterfly"))
                                .padding(.vertical,10)
                                .background(Color("rightBlue").opacity(tag == selectTag ? 1 : 0.07))
                                .cornerRadius(4)
                        }
                    }
                }
            }

            VStack(spacing: 15){
                ForEach(self.recipesModel.filteredRecipes){ item in
                   RecipesCellView(recipes: item)
                }
            }
            .navigationBarTitle("레시피 검색하기")
        }.onAppear(){
            self.recipesModel.getRecipes()
        }.onChange(of: recipesModel.searchRecipes, perform: { value in
            
            //- 검색결과에 따라 변화하도록 설정
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                
                if value == recipesModel.searchRecipes && recipesModel.searchRecipes != ""{
                    // 서치 결과 데이터
                   recipesModel.filterRecipes()
                }
            }
            if recipesModel.searchRecipes == ""{
                //->데이터 결과
                withAnimation(.linear){
                    recipesModel.filteredRecipes = recipesModel.recipes
                }
            }
        })
    }
}

// MARK: - 셀뷰
struct RecipesCellView: View{
    
    var recipes : RecipesModel?
    @State var show = false
    @Namespace var animation

    var body: some View {
        VStack{
            AnimatedImage(url: URL(string: recipes?.cook_images[0] ?? "")).resizable().frame(height: 270)
            
            HStack{
                VStack(alignment: .leading){
                    Text(recipes?.cook_name ?? "").font(.title).fontWeight(.heavy)
                    Text(recipes?.cook_level ?? "").fontWeight(.heavy)
                        .font(.body)
                }
                Spacer()
                
                Button(action: {
                    self.show.toggle()
                }){
                    Image(systemName: "arrow.right")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding(14)
                }
                .background(Color("butterfly"))
                .clipShape(Circle())
            }.padding(.horizontal)
                .padding(.bottom,6)
        }.background(Color("rightBlue"))
            .cornerRadius(20)
            .sheet(isPresented: self.$show){
                RecipesDetailView(recipes: recipes, show: $show, animation: animation)
        }
    }
}

// MARK: - 디테일 뷰
struct RecipesDetailView : View{
    var recipes : RecipesModel?
    @Binding var show : Bool
    var animation : Namespace.ID
    
    var body: some View {
        ScrollView{
            VStack{
                VStack{
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)){
                        WebImage(url: URL(string: recipes?.cook_images[0] ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 330)
                            .cornerRadius(40, corners: [.bottomLeft, .bottomRight])
                            .shadow(color: Color.primary.opacity(0.3), radius: 1)
                        
                        HStack{
                            Button(action: {
                                withAnimation(.spring()){show.toggle()}
                            }){
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "heart")
                                    .foregroundColor(.pink)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            })
                        }
                        .padding()
                        .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    }
                    
                    HStack(spacing: 5){
                        WebImage(url: URL(string: recipes?.cook_images[0] ?? "")).resizable().frame(width: 60, height: 60).cornerRadius(10)
                        WebImage(url: URL(string: recipes?.cook_images[1] ?? "")).resizable().frame(width: 60, height: 60).cornerRadius(10)
                        WebImage(url: URL(string: recipes?.cook_images[2] ?? "")).resizable().frame(width: 60, height: 60).cornerRadius(10)
                        WebImage(url: URL(string: recipes?.cook_images[3] ?? "")).resizable().frame(width: 60, height: 60).cornerRadius(10)
                    }
                    
                    HStack(alignment: .top){
                        
                        VStack(alignment: .leading, spacing: 12){
                            Text(recipes?.cook_name ?? "없는 레시피입니다.")
                                .font(.title)
                                .foregroundColor(Color("butterfly"))
                                .fontWeight(.bold)
                                .matchedGeometryEffect(id: recipes?.cook_name ?? "", in: animation)
                            
                            HStack(spacing: 5){
                                Image(systemName: "sparkles").resizable().frame(width: 20, height: 20)
                                Text("난이도: \(recipes?.cook_level ?? "")")
                                    .foregroundColor(.black)
                                    .frame(width: 120)
                                    .matchedGeometryEffect(id: recipes?.cook_level ?? "", in: animation)
                                
                                HStack(spacing: 5){
                                    ForEach(1...5, id: \.self){ index in
                                        Image(systemName: "star.fill")
                                            .foregroundColor(index <= Int(recipes?.ratings ?? "") ?? 0 ? Color("butterfly") : .gray)
                                    }
                                }
                            }
                        }
                        
                        Spacer(minLength: 0)
                        Text(recipes?.cook_tag ?? "")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color("butterfly"))
                    }
                    .padding()
                    .padding(.bottom)
                }
                .background(Color.white)
                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                
                Spacer(minLength: 0)
            }
            .background(Color.white)
            
            VStack(alignment: .leading, spacing: 15){
                HStack(spacing: 15){
                    Text("재료: \(recipes?.cook_indigator ?? "재료가 없습니다.")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color("butterfly"))
                }
                Spacer(minLength: 0)
            }
            .padding(.top)
            
            Text("자세한 조리법")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color("butterfly"))
            
            Text(recipes?.cook_details ?? "").multilineTextAlignment(.leading)
        }
    }
}

