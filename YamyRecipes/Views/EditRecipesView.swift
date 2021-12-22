//
//  EditRecipesView.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/22.
//

import SwiftUI

struct EditRecipesView: View {
    
    var recipes : RecipesModel?
    @Binding var show : Bool
    var animation : Namespace.ID
    var user: UserModel?
    @State private var cookName: String = ""
    @State private var cookIndigator: String = ""
    
    var body: some View {
        VStack {
            

        }
    }
}

//struct EditRecipesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRecipesView()
//    }
//}
