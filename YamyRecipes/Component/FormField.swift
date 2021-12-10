//
//  FormField.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import SwiftUI

struct FormField: View {
    @Binding var value: String
    var icon : String
    var placeholder : String
    var isSecure = false
    
    var body: some View {
        Group{
            HStack{
                Image(systemName: icon).padding().foregroundColor(Color("salmon"))
                Group{
                    if isSecure {
                        SecureField(placeholder, text: $value)
                    }else {
                        TextField(placeholder, text: $value)
                    }
                }.font(Font.system(size: 20, design: .monospaced))
                    .foregroundColor(Color("salmon"))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .multilineTextAlignment(.leading)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
            }
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("salmon"), lineWidth: 4))
        }
    }
}


