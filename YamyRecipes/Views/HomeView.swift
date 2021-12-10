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
                VStack{
                    HStack{
                        Image("recipeSearch").resizable().frame(width: 200, height: 200)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

//Button(action: session.logout){
//    Text("logOut").font(.title).modifier(ButtonModifier())
//}
