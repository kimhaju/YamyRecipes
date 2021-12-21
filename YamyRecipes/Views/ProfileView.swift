//
//  ProfileView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/21.
//

import SwiftUI

struct ProfileView: View {
    
    var user: UserModel?
    @EnvironmentObject var userSession: SessionStore
    
    var body: some View {
        VStack{
            if userSession.session != nil {
                Button(action: userSession.logout){
                    Text("logout").font(.headline)
                }
            }else {
                SignInView()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
