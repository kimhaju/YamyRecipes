//
//  RecipesUploadView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import SwiftUI

//struct RecipesModel: Identifiable {
//    var id : String
//    //->음식 이름,요리 분류(국물, 양식, 한식, 베이커리 등등),조리시간,재료, 평가, 조리법, 이미지들
//    var cook_name: String
//    var cook_tag: String
//    var cook_times: String
//    var cook_indigators: String
//    var ratings: String
//    var cook_level: String
//    var cook_details: String
//    var cook_images = Array(repeating: Data(count: 0), count: 6)
//    var writer: String
//}


struct RecipesUploadView: View {
    
    // MARK: - 필드 값
    @State private var cookName : String = ""
    @State private var cookIndigators: String = ""
    @State private var ratings: String = ""
    @State private var cook_details: String = ""
    @State private var writer: String = ""
    @State private var selection: Int = 0
    @State var textHeight: CGFloat = 0
    
    // MARK: - helper
    var textFieldHeight: CGFloat {
            let minHeight: CGFloat = 30
            let maxHeight: CGFloat = 80
            
            if textHeight < minHeight {
                return minHeight
            }
            
            if textHeight > maxHeight {
                return maxHeight
            }
            
            return textHeight
    }
    
    var textWriteHeight: CGFloat {
            let minHeight: CGFloat = 180
            let maxHeight: CGFloat = 360
            
            if textHeight < minHeight {
                return minHeight
            }
            
            if textHeight > maxHeight {
                return maxHeight
            }
            
            return textHeight
    }
    
    // MARK: - 본체
    
    var body: some View {
            ScrollView{
                VStack(alignment: .leading ,spacing: 10){
                    Group{
                       
                        FormField(value: $cookName, icon: "sparkles", placeholder: "요리 제목").padding()
                        
                        CustomPicker(title: "요리 태그", selection: $selection, options: ["한식", "양식", "이색요리", "면류" , "베이커리", "기타"]).padding(.top,10)
                        
                        CustomPicker(title: "조리 시간", selection: $selection, options: ["20분 정도", "30분 정도", "50분 정도", "1시간 이상" , "기타"]).padding(.top,10)
                        
                        CustomPicker(title: "조리 난이도", selection: $selection, options: ["쉬움", "중간", "어려움"]).padding(.top,10)
                        
                        Divider().foregroundColor(Color("salmon")).frame(height: 2)
                        
                        VStack(alignment: .leading, spacing: 10){
                            HStack{
                                Text("재료").font(.title3).fontWeight(.bold).padding(.leading,10)
                                
                                Image(systemName: "wand.and.stars").frame(width: 30, height: 30).foregroundColor(Color("salmon"))
                            }
                            
                                ZStack(alignment: .topLeading){
                                    
                                    if cookIndigators.isEmpty{
                                        Text("여기에 재료를 적어주세요.").foregroundColor(Color.black).padding(4)
                                    }
                                    Color(UIColor.secondarySystemBackground)
                                    
                                    DynamicTextField(text: $cookIndigators, height: $textHeight)
                                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("salmon")))
                                    .frame(width: 330, height: textFieldHeight)
                                
                                HStack{
                                    Text("조리법").font(.title3).fontWeight(.bold).padding(.top,10)
                                    Image(systemName: "moon.stars").frame(width: 30, height: 30).foregroundColor(Color("salmon"))
                                }
                                
                                ZStack(alignment: .topLeading){
                                    
                                    if cookIndigators.isEmpty{
                                        Text("여기에 조리법을 적어주세요.").foregroundColor(Color.black).padding(4)
                                    }
                                    Color(UIColor.secondarySystemBackground)
                                    
                                    DynamicTextField(text: $cookIndigators, height: $textHeight)
                                    
                                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("salmon")))
                                    .frame(width: 330, height: textWriteHeight)
                        }.padding(.leading,20)
                    
                    }
                    Spacer()
                    
                    VStack{
                        Button(action: {}){
                            Text("레시피 업로드").font(.title).modifier(ButtonModifier())
                        }
                        
                    }.padding(10)
                }
            }.navigationBarTitle("레시피 쓰기")
    }
}

struct RecipesUploadView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesUploadView()
    }
}
