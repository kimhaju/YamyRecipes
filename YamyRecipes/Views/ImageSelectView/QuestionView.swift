//
//  QuestionView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import SwiftUI

struct QuestionView: View {
    
    @StateObject var question = QuestionModel()

    var user: UserModel?
    
    var body: some View {
        
        VStack{
            ScrollView {
                ForEach(question.msgs){ msg in
                    Text(msg.msg ?? "현재 메세지가 존재하지 않습니다!")
                }
            }
        }
    }
}

struct ChatRow: View {
    var charData: MsgModel
    var user: UserModel?
    
    var body: some View {
        HStack(spacing: 15){
            Text(user?.username ?? "").fontWeight(.heavy)
                .foregroundColor(.white)
                .frame(width: 50, height: 50)
                .background(Color("butterfly"))
                .clipShape(Circle())
        }
    }
}

//        .onAppear(perform: {
//            question.onAppear()
//        })

//struct QuestionView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuestionView()
//    }
//}
