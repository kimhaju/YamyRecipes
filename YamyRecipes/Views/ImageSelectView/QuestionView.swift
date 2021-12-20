//
//  QuestionView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import SwiftUI

struct QuestionView: View {
    
    @StateObject var question = QuestionModel()
    @AppStorage("current_user") var user = ""

    var body: some View {
        
        VStack{
            ScrollView{
                ForEach(question.msgs){ msg in
                    
                }
            }
        }
        .onAppear(perform: {
            question.onAppear()
        })
    }
}

struct ChatRow: View {
    var chatData : MsgModel
    @AppStorage("current_user") var user = ""
    
    var body: some View {
        HStack(spacing: 15){
            
        }
    }
}

struct NickName: View {
    var name : String
    @AppStorage("current_user") var user = ""
    
    var body: some View {
        Text(String(name.first!))
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .frame(width: 50, height: 50)
            .background(name == user ? Color("rightBlue") : Color("butterfly").opacity(0.5))
    }
}

