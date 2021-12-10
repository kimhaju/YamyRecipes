//
//  ImagePicker.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/09.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var pickedImage: Image?
    @Binding var showImagePicker: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController{
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
        
    }
    
    //->이미지 피커를 하려면 델리게이트 작업이 필요한데 이 클래스가 델리게이트역할을 해준다!
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[.editedImage] as! UIImage
            parent.pickedImage = Image(uiImage: uiImage)
            
            //->용량을 위해서 이미지들을 jpeg파일로 변경
            if let mediaData = uiImage.jpegData(compressionQuality: 0.5) {
                
                parent.imageData = mediaData
            }
            parent.showImagePicker = false
        }
    }
}
