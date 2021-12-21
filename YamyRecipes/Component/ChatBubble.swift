//
//  ChatBubble.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/21.
//

import Foundation
import SwiftUI

struct ChatBubble : Shape {
    
    var myMsg: Bool
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, myMsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 15, height: 15))
        
        return Path(path.cgPath)
    }
    
}
