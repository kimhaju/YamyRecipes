//
//  HomeView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/10.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    var user: UserModel?
    @EnvironmentObject var userSession: SessionStore
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("back").resizable().aspectRatio(contentMode: .fill).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).ignoresSafeArea()
                
                VStack{
                    HStack{
                        VStack(alignment: .leading, spacing: 10){
                            Text("안녕하세요! \(user?.username ?? "noName")").font(.title)
                                .fontWeight(.bold)
                            
                            Text("같이 레시피를 찾고 공유해요!")
                        }
                        .foregroundColor(.black)
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {}){
                            WebImage(url: URL(string: user?.profileImageUrl ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")).resizable().renderingMode(.original).frame(width: 60, height: 60).clipShape(Circle())
                        }
                    }.padding()
                    
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 220){
                            GeometryReader{ geometry in
                                HStack(spacing: 10){
                                        VStack {
                                            Button(action: {}, label: {
                                                NavigationLink(destination: RecipeSearchView().environmentObject(RecipesViewModel())){
                                                    Image("recipeSearch").resizable().frame(width: geometry.size.width / 2.2, height: 150).background(Color("rightBlue")).cornerRadius(10, corners: [.topLeft, .topRight]).border(width: 1, edges: [.bottom], color: .black)
                                                }
                                            })
                                                Text("레시피 검색 ").fontWeight(.bold).padding(.bottom,20)
                                        }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
 
                                    VStack{
                                        Button(action: {}, label: {
                                            NavigationLink(destination: HeartRecipesView()){
                                        Image("heartRecipes").resizable().frame(width: geometry.size.width / 2.2, height: 150).background(Color("rightCyan")).cornerRadius(10, corners: [.topLeft, .topRight]).border(width: 1, edges: [.bottom], color: .black)
                                            }
                                        })

                                        Text("마음에 드는 레시피 ").fontWeight(.bold).padding(.bottom,20)
                                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                                }.padding(.leading,12.5)
                            }
                            
                            // MARK: - 두번째 행 시작
                            GeometryReader{ geometry in
                                HStack(spacing: 10){
                                    VStack {
                                        Button(action: {}, label: {
                                            NavigationLink(destination: MyRecipesView()){
                                        Image("myMenu").resizable().frame(width: geometry.size.width / 2.2, height: 150).background(Color("pink")).cornerRadius(10, corners: [.topLeft, .topRight]).border(width: 1, edges: [.bottom], color: .black)
                                            }
                                        })
                                        
                                        Text("내가 남긴 게시글 보기").fontWeight(.bold).padding(.bottom,20)
                                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                                    
                                    VStack{
                                        Button(action: {}, label: {
                                            NavigationLink(destination: RecipesUploadView(user: self.userSession.session).environmentObject(RecipesViewModel())){
                                        Image("recipesUpload").resizable().frame(width: geometry.size.width / 2.2, height: 150).background(Color("rightYellow")).cornerRadius(10, corners: [.topLeft, .topRight]).border(width: 1, edges: [.bottom], color: .black)
                                            }
                                        })
                  
                                        Text("레시피 업로드 하기 ").fontWeight(.bold).padding(.bottom,20)
                                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                                }.padding(.leading,12.5)
                            }
                        
                            // MARK: - 세번째 행 시작
                            
                            GeometryReader{ geometry in
                                HStack(spacing: 10){
                                    
                                    VStack {
                                        Button(action: {}, label: {
                                            NavigationLink(destination: CoreIndicatorsView(classifier: ImageClassifier())){
                                        Image("ingredients").resizable().frame(width: geometry.size.width / 2.2, height: 150).background(Color.white)
                                            .cornerRadius(10, corners: [.topLeft, .topRight]).border(width: 1, edges: [.bottom], color: .black)
                                            }
                                        })

                                        Text("재료 탐색").fontWeight(.bold).padding(.bottom,20)
                                        
                                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black))
                                    
                                    VStack{
                                        Button(action: {}, label: {
                                            NavigationLink(destination: QuestionView()){
                                        Image("question").resizable().frame(width: geometry.size.width / 2.2, height: 150).background(Color("rightBlue")).cornerRadius(10, corners: [.topLeft, .topRight]).border(width: 1, edges: [.bottom], color: .black)
                                            }
                                        })
            
                                        Text("관리자에게 문의").fontWeight(.bold).padding(.bottom,20)
                                    }.overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black)).background(Color.white)
                                }.padding(.leading,12.5)
                            }
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

