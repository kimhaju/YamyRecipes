//
//  AuthViewModel.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import Foundation
import Firebase
import FirebaseFirestore

class AuthViewModel {
    
    static var storeRoot = Firestore.firestore()
    
    static func getUserId(userId: String) -> DocumentReference {
        return storeRoot.collection("users").document(userId)
    }
    
    static func signUp(username: String, email: String, password: String, imageData: Data, onSuccess: @escaping(_ user: UserModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        
        Auth.auth().createUser(withEmail: email, password: password) { authData, error in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else { return }
            
            let storageProfileUserId = StorageService.storageProfileId(userId: userId)
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            StorageService.saveProfileImage(userId: userId, username: username, email: email, imageData: imageData, metaData: metaData, storageProfileImageRef: storageProfileUserId, onSuccess: onSuccess, onError: onError)
            
        }
    }
    
    static func signIn(email: String, password: String, onSuccess: @escaping(_ user: UserModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        
        Auth.auth().signIn(withEmail: email, password: password) { authData, error in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            guard let userId = authData?.user.uid else { return }
            
            let firestoreUserId = getUserId(userId: userId)
            
            firestoreUserId.getDocument { documnet, error in
                if let dict = documnet?.data() {
                    guard let decodedUser = try? UserModel.init(fromDictionary: dict) else { return }
                    
                    onSuccess(decodedUser)
                }
            }
        }
    }
}
