//
//  SignUpView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import SwiftUI

struct SignUpView: View {
    
    // MARK: - 속성값
    @State private var email : String = ""
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var profileImage : Image?
    @State private var pickedImage: Image?
    @State private var showingActionSheet = false
    @State private var showingImagePicker = false
    @State private var imageData : Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var error: String = ""
    @State private var showingAlert = false
    @State private var alertTitle : String = "회원가입에 실패했습니다. 정보를 확인해주세요!"
    
    // MARK: - helper
    func loadImage() {
        guard let inputImage = pickedImage else { return }
        
        profileImage = inputImage
    }
    
    func errorCheck() -> String? {
        if email.trimmingCharacters(in: .whitespaces).isEmpty || password.trimmingCharacters(in: .whitespaces).isEmpty || username.trimmingCharacters(in: .whitespaces).isEmpty || imageData.isEmpty {
            
            return "모든 항목을 입력해주세요!"
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.username = ""
        self.password = ""
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.showingAlert = true
            return
        }
        
        AuthViewModel.signUp(username: username, email: email, password: password, imageData: imageData, onSuccess: { user in
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
        NavigationView {
                ZStack {
                    Image("back").resizable().aspectRatio(contentMode: .fill).frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).ignoresSafeArea()
                    
                    VStack(spacing: 15) {
                        
                        Group{
                            if profileImage != nil {
                                profileImage!.resizable().clipShape(Circle()).frame(width: 100, height: 100).onTapGesture {
                                    self.showingActionSheet = true
                                }
                            }else {
                                Image(systemName: "person.circle.fill").resizable().clipShape(Circle()).foregroundColor(Color("salmon")).frame(width: 100, height: 100).onTapGesture {
                                    self.showingActionSheet = true
                                }
                            }
                        }

                        VStack(alignment: .leading){
                            Text("환영합니다!").font(.system(size: 32, weight: .heavy)).foregroundColor(Color("salmon"))
                            Text("Sign in").font(.system(size: 16, weight: .medium)).foregroundColor(Color("salmon"))
                        }
                      
                        Group{
                            FormField(value: $email, icon: "envelope.fill", placeholder: "E-mail",color: "salmon")
                            FormField(value: $username, icon: "person.fill", placeholder: "user-name",color: "salmon")
                            FormField(value: $password, icon: "lock.fill", placeholder: "password", isSecure: true,color: "salmon").padding(.top,1)
                        }
                        Button(action: signUp){
                            Text("Sign Up").font(.title).modifier(ButtonModifier(color: "salmon"))
                        }.alert(isPresented: $showingAlert){
                            Alert(title: Text(alertTitle), message: Text(error), dismissButton: .default(Text("ok")))
                        }
                        Spacer()
                    }
                    .padding()
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
                    ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
                }.actionSheet(isPresented: $showingActionSheet){
                    ActionSheet(title: Text(""), buttons: [.default(Text("프로필 사진을 선택하기")){
                        self.sourceType = .photoLibrary
                        self.showingImagePicker = true
                    },.default(Text("프로필 사진을 찍기")){
                        self.sourceType = .camera
                        self.showingImagePicker = true
                    }, .cancel()
                ])
            }.navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
