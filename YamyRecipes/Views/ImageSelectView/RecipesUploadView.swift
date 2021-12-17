//
//  RecipesUploadView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import SwiftUI
import Firebase

struct RecipesUploadView: View {
    
    // MARK: - 필드 값
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    
    var user : UserModel?
    
    @State private var cookName : String = ""
    @State private var cookIndigators: String = ""
    @State private var ratings: String = ""
    @State private var cook_details: String = ""
    @State private var writer: String = ""
    @State private var selection: Int = 0
    @State private var cookTag : String = "한식"
    @State private var cookTime : String = "10분"
    @State private var cookLevel : String = "쉬움"
    @State var textHeight: CGFloat = 0
    @State var currentImage = 0
    @State private var cookImages : [Data] = []
    
    //->업로드 체크
    
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle : String = "글을 업로드 하는데 실패했습니다.정보를 확인해주세요."
    
    // MARK: - helper

    func errorCheck() -> String? {
        if cookName.trimmingCharacters(in: .whitespaces).isEmpty || cookIndigators.trimmingCharacters(in: .whitespaces).isEmpty || cook_details.trimmingCharacters(in: .whitespaces).isEmpty {
            
            return "모든 항목을 입력해주세요!"
        }else {
            for data in recipesViewModel.cook_images {
                if data.count == 0 {
                    return "이미지를 최소 4개이상 첨부해주세요."
                }
            }
        }
        return nil
    }

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
                        FormField(value: $recipesViewModel.cook_name, icon: "sparkles", placeholder: "요리 제목").padding()
                        HStack(spacing: 10){
                            Text("요리 태그: ").font(.footnote).padding(.leading,5)
                            ForEach(cookTags, id: \.self){ item in
                                Button(action: {cookTag = item}){
                                    Text("\(item)")
                                        .fontWeight(.bold)
                                        .foregroundColor(cookTag == item ? Color.white : Color("salmon"))
                                        .padding(.vertical,10)
                                        .background(Color("rightBlue").opacity(cookTag == item ? 1 : 0.07))
                                        .cornerRadius(4)
                                }
                            }
                        }
                        
                        HStack(spacing: 10){
                            Text("조리시간: ").font(.footnote).padding(.leading,5)
                            ForEach(cookTimes, id: \.self){ item in
                                Button(action: {cookTime = item}){
                                    Text("\(item)")
                                        .fontWeight(.bold)
                                        .foregroundColor(cookTime == item ? Color.white : Color("salmon"))
                                        .padding(.vertical,10)
                                        .background(Color("rightBlue").opacity(cookTime == item ? 1 : 0.07))
                                        .cornerRadius(4)
                                }
                            }
                        }
                        
                        HStack(spacing: 10){
                            Text("요리 태그: ").font(.footnote).padding(.leading,5)
                            ForEach(cookLevels, id: \.self){ item in
                                Button(action: {cookLevel = item}){
                                    Text("\(item)")
                                        .fontWeight(.bold)
                                        .foregroundColor(cookLevel == item ? Color.white : Color("salmon"))
                                        .padding(.vertical,10)
                                        .background(Color("rightBlue").opacity(cookLevel == item ? 1 : 0.07))
                                        .cornerRadius(4)
                                }
                            }
                        }
                        
                        //->여기에 이미지 선택
                        VStack(alignment: .leading){
                            Text("요리 이미지 선택").font(.title3).fontWeight(.bold).padding(.leading,10)
                            
                            GeometryReader{ reader in
                                
                                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2),spacing: 20, content: {
                                    
                                    ForEach(recipesViewModel.cook_images.indices, id: \.self) { index in
                                        
                                        ZStack {
                                            if recipesViewModel.cook_images[index].count == 0 {
                                                Image(systemName: "plus.circle.fill").font(.system(size: 45)).foregroundColor(Color.white)
                                            }else {
                                                Image(uiImage: UIImage(data: recipesViewModel.cook_images[index])!).resizable()
                                            }
                                            
                                        }.frame(width: (reader.size.width-15) / 2, height: 100)
                                            .background(Color("salmon"))
                                            .onTapGesture {
                                                currentImage = index
                                                recipesViewModel.picker.toggle()
                                            }
                                    }
                                })
                            }.sheet(isPresented: $recipesViewModel.picker, content: {
                                CookImagePicker(show: $recipesViewModel.picker, ImageData: $recipesViewModel.cook_images[currentImage])
                            })
                            .padding(.bottom,10)
                        }.padding()

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
                                    
                                    DynamicTextField(text: $recipesViewModel.cook_indigator, height: $textHeight)
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
                                    
                                    DynamicTextField(text: $recipesViewModel.cook_details, height: $textHeight)
                                    
                                }.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("salmon")))
                                    .frame(width: 330, height: textWriteHeight)
                        }.padding(.leading,20)
                         .padding(.top,200)
                    }
                    Spacer()
                    
                    VStack{
                            Button(action: {
                           
                                recipesViewModel.uploadPosting(userId: user?.uid ?? "", cookTag: cookTag, cookTimes: cookTime, cookLevel: cookLevel)
                            }){
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
