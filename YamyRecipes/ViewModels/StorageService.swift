//
//  StorageService.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import Foundation
import Firebase

class StorageService {
    
    static var storage = Storage.storage()
    
    static var storageRoot = storage.reference(forURL: "gs://yamyrecipes.appspot.com/profile")
    
    static var storageProfile = storageRoot.child("profile")
    
    static func storageProfileId(userId: String) -> StorageReference{
        return storageProfile.child(userId)
    }
    
    static func saveProfileImage(userId: String, username: String, email: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: UserModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void){
        
        storageProfileImageRef.putData(imageData, metadata: metaData){ StorageMetadata, error in
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            storageProfileImageRef.downloadURL { url, error in
                if let metaImageUrl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                        changeRequest.displayName = username
                        
                        changeRequest.commitChanges { error in
                            if error != nil {
                                onError(error!.localizedDescription)
                                return
                            }
                        }
                    }
                    
                    let firestoreUserId = AuthViewModel.getUserId(userId: userId)
                    let user = UserModel.init(uid: userId, email: email, profileImageUrl: metaImageUrl, username: username, searchName: username.splitString())
                    
                    guard let dict = try? user.asDictionary() else { return }
                    
                    firestoreUserId.setData(dict) { error in
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                    }
                    onSuccess(user)
                }
            }
        }
        
    }
}
