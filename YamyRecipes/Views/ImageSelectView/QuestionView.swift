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
    @State var scrolled = false

    var body: some View {
        
        VStack(spacing: 0){
            
            HStack{
                Text("문의하기")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                
                Spacer(minLength: 0)
            }
            .padding()
            .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
            .background(Color("butterfly"))
            
            ScrollViewReader{ reader in
                ScrollView{
                    VStack(spacing: 15){
                        ForEach(question.msgs){ msg in
                            ChatRow(chatData: msg)
                                .onAppear{
                                    if msg.id == self.question.msgs.last!.id && !scrolled {
                                        
                                        reader.scrollTo(question.msgs.last!, anchor: .bottom)
                                        scrolled = true
                                    }
                                }
                        }
                        .onChange(of: question.msgs, perform: { value in
                            reader.scrollTo(question.msgs.last!, anchor: .bottom)
                            
                        })
                    }
                    .padding(.vertical)
                }
            }
            
            HStack(spacing: 15){
                TextField("문의사항을 입력해주세요.", text: $question.txt)
                    .padding(.horizontal)
                    .frame(height: 45)
                    .background(Color.primary.opacity(0.06))
                    .clipShape(Capsule())
                
                if question.txt != "" {
                    Button(action: question.writeMsg, label: {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                            .frame(width: 45, height: 45)
                            .background(Color("butterfly"))
                            .clipShape(Circle())
                    })
                }
            }
            .animation(.default)
            .padding()
        }
        .onAppear(perform: {
            question.onAppear()
        })
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct ChatRow: View {
    var chatData : MsgModel
    @AppStorage("current_user") var user = ""
    
    var body: some View {
        HStack(spacing: 15){
            
            if chatData.user != user {
                NickName(name: chatData.user)
            }
            if chatData.user == user {Spacer(minLength: 0)}
            
            VStack(alignment: chatData.user == user ? .trailing : .leading, spacing: 5, content: {
                
                Text(chatData.msg)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color("rightBlue"))
                    .clipShape(ChatBubble(myMsg: chatData.user == user))
                
                Text(chatData.timeStamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(chatData.user != user ?.leading : .trailing , 10)
            })
            
            if chatData.user == user {
                NickName(name: chatData.user)
            }
            if chatData.user != user {Spacer(minLength: 0)}
        }
        .padding(.horizontal)
        .id(chatData.id)
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
            .clipShape(Circle())
            .contentShape(Circle())
            .contextMenu{
                Text(name)
                    .fontWeight(.bold)
            }
        
    }
}

