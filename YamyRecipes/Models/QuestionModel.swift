//
//  QuestionModel.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/16.
//

import SwiftUI
import Firebase

class QuestionModel : ObservableObject {
    
    @Published var msgs : [MsgModel] = []
    @AppStorage("current_user") var user = ""
    let ref = Firestore.firestore()
    
    init() {
        readAllMsgs()
    }
    
    func onAppear() {
        
        if user == "" {
            
            UIApplication.shared.windows.first?.rootViewController?.present(alertView(), animated: true)
        }
    }
    
    func alertView() -> UIAlertController {
        let alert = UIAlertController(title: "어서오세요! 관리자에게 문의할 사항이 있나요?", message: "메세지 내용을 입력해주세요.", preferredStyle: .alert)
        
        alert.addTextField { txt in
            txt.placeholder = "잇힝"
        }
        
        let join = UIAlertAction(title: "Join", style: .default) { _ in
            
            let user = alert.textFields![0].text ?? ""
            
            if user != "" {
                self.user = user
                return
            }
            
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }
        
        alert.addAction(join)
        return alert
    }
    
    func readAllMsgs() {
        ref.collection("msgs").addSnapshotListener { snap, error in
            
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            
            guard let data = snap else {return}
            
            data.documentChanges.forEach { doc in
                
                if doc.type == .added {
                    let msg = try! doc.document.data(as: MsgModel.self)!
                    
                    DispatchQueue.main.async {
                        self.msgs.append(msg)
                    }
                }
            }
        }
    }
    
}
