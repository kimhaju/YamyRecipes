//
//  ButtonModifier.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content.frame(minWidth: 0, maxWidth: .infinity)
            .frame(height: 20)
            .padding()
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .bold))
            .background(Color("salmon"))
            .clipShape(Capsule())
    }
}

//Image(systemName: "arrow.right")
//    .font(.system(size: 24, weight: .bold))
//    .foregroundColor(.white)
//    .padding()
//    .background(Color("choco"))
//    .clipShape(Circle())
//    .shadow(color: Color("mint").opacity(0.6), radius: 5, x: 0, y: 0)
