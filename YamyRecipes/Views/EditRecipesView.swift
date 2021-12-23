//
//  EditRecipesView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/22.
//

import SwiftUI

struct EditRecipesView: View {
    
    // MARK: - 필드 값
    
    @EnvironmentObject var recipesViewModel: RecipesViewModel
    
    var recipes : RecipesModel?
    @Binding var show : Bool
    var animation : Namespace.ID
    var user: UserModel?
    @State private var cookName: String = ""
    @State private var cookIndigator: String = ""
    @State private var cookLevel: String = ""
    @State private var cookTime: String = ""
    @State private var cookDetail: String = ""
    @State private var cookTag: String = ""
    @State var textHeight: CGFloat = 0
    
    @State private var error : String = ""
    @State private var showingAlert = false
    @State private var alertTitle: String = "글 수정에 문제가 생겼습니다...😔"
    
    // MARK: -메서드
    func editPost() {
        recipesViewModel.editRecipes(recipesId: recipes?.id ?? "", cookName: cookName, cookdetail: cookDetail, cookIndigator: cookIndigator, cookLevel: cookLevel, cookTag: cookTag, cookTime: cookTime)
    }
    
    func errorCheck() -> String? {
        if cookName.trimmingCharacters(in: .whitespaces).isEmpty || cookIndigator.trimmingCharacters(in: .whitespaces).isEmpty ||
            cookLevel.trimmingCharacters(in: .whitespaces).isEmpty ||
            cookTime.trimmingCharacters(in: .whitespaces).isEmpty ||
            cookDetail.trimmingCharacters(in: .whitespaces).isEmpty ||
            cookTag.trimmingCharacters(in: .whitespaces).isEmpty {
            
            return "입력한 수정정보가 올바른지 확인해주세요."
        }
        return nil
    }
    
    func clear() {
        self.cookName = ""
        self.cookDetail = ""
        self.cookLevel = ""
        self.cookTime = ""
        self.cookTag = ""
        self.cookIndigator = ""
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

    var body: some View {
        ScrollView{
            VStack(alignment: .leading ,spacing: 10){
                Group{
                    FormField(value: $cookName, icon: "sparkles", placeholder: "\(recipes?.cook_name ?? "")", color: "butterfly").padding()
                    
                    HStack(spacing: 10){
                        Text("요리 태그: ").font(.footnote).padding(.leading,5)
                        ForEach(cookTags, id: \.self){ item in
                            Button(action: {cookTag = item}){
                                Text("\(item)")
                                    .fontWeight(.bold)
                                    .foregroundColor(cookTag == item ? Color.white : Color("butterfly"))
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
                                    .foregroundColor(cookTime == item ? Color.white : Color("butterfly"))
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
                                    .foregroundColor(cookLevel == item ? Color.white : Color("butterfly"))
                                    .padding(.vertical,10)
                                    .background(Color("rightBlue").opacity(cookLevel == item ? 1 : 0.07))
                                    .cornerRadius(4)
                            }
                        }
                    }
                    
                    HStack{
                        Text("재료").font(.title3).fontWeight(.bold).padding(.leading,10)
                        
                        Image(systemName: "wand.and.stars").frame(width: 30, height: 30).foregroundColor(Color("butterfly"))
                        
                        ZStack(alignment: .topLeading){
                            if cookIndigator.isEmpty{
                                Text("여기에 재료를 적어주세요.").foregroundColor(Color.black).padding(4)
                            }
                            Color(UIColor.secondarySystemBackground)
                            DynamicTextField(text: $cookIndigator, height: $textHeight)
                        }.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("butterfly")))
                         .frame(width: 260, height: textFieldHeight)
                    }
                    
                    HStack{
                        Text("조리법").font(.title3).fontWeight(.bold).padding(.top,10)
                        Image(systemName: "moon.stars").frame(width: 30, height: 30).foregroundColor(Color("butterfly"))
                    }.padding(.leading,10)
                    
                    ZStack(alignment: .topLeading){
                        
                        Text(recipes?.cook_details ?? "").foregroundColor(Color.black).padding(4)
                       
                        Color(UIColor.secondarySystemBackground)
                        
                        DynamicTextField(text: $cookDetail, height: $textHeight)
                    }
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("butterfly")))
                    .frame(width: 330, height: textWriteHeight)
                    .padding(.leading,20)
                    
                   
                   
                        
                            Button(action: {
                                editPost()
                                self.showingAlert = true
                            }){
                                Text("수정하기").font(.title).modifier(ButtonModifier(color: "butterfly"))
                            }.alert(isPresented: $showingAlert){
                                Alert(title: Text("게시글 수정을 완료 했습니다!"), message: Text("완료"), dismissButton: .default(Text("X")))
                            }
                    
                }
            }.navigationBarTitle("\(recipes!.cook_name): 수정하기")
        }
    }
}

//struct EditRecipesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRecipesView()
//    }
//}
