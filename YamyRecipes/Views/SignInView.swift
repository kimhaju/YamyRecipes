//
//  SignInView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import SwiftUI

struct SignInView: View {
    
    // MARK: - 속성값
    @State private var email : String = ""
    @State private var password : String = ""
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle : String = "로그인에 실패했습니다. 정보를 확인해주세요!"
    
    // MARK: - helper
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty {
            
            return "모든 항목을 입력해주세요!"
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.password = ""
    }
    
    func signIn() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthViewModel.signIn( email: email, password: password, onSuccess: { user in
            self.clear()
        }){ errorMessage in
            print("에러발생 \(errorMessage)")
            self.error = errorMessage
            self.showingAlert = true
            return
        }
    }
  
    // MARK: - 뷰 본체
    var body: some View {
        NavigationView{
                ZStack {
                    Image("back").resizable().aspectRatio(contentMode: .fill).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Image("cooking").resizable().frame(width: 150, height: 150).background(Color("cooking")).clipShape(Circle())
                        
                        VStack(alignment: .leading){
                            Text("YamyRecipes!").font(.system(size: 32, weight: .heavy)).foregroundColor(Color("salmon"))
                            Text("Sign in").font(.system(size: 16, weight: .medium)).foregroundColor(Color("salmon"))
                        }
                        FormField(value: $email, icon: "envelope.fill", placeholder: "E-mail",color: "salmon")
                        FormField(value: $password, icon: "lock.fill", placeholder: "password", isSecure: true,color: "salmon").padding(.top,1)
                        
                        Button(action: signIn){
                            Text("Sign In").font(.title).modifier(ButtonModifier(color: "salmon"))
                        }.alert(isPresented: $showingAlert){
                            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("ok")))
                        }
                        
                        HStack{
                            NavigationLink(destination: SignUpView()){
                                Text("아이디가 없으신가요? 회원가입").font(.system(size: 15))
                            }
                        }
                        Spacer()
                    }.padding()
                }
               
                .navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }
    }

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}



