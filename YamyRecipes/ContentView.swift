//
//  ContentView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
    
    func listen(){
        session.listen()
    }
    
    var body: some View {
        
        Group {
            if(session.session != nil){
                HomeView(user: self.session.session)
            } else {
                SignInView()
            }
        }.onAppear(perform: listen)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
