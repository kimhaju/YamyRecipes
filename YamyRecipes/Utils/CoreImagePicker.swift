//
//  CoreImagePicker.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/20.
//

import SwiftUI
import UIKit

struct CoreImagePicker: UIViewControllerRepresentable {
    
    @Binding var uiImage: UIImage?
    @Binding var isPresenting: Bool
    @Binding var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let coreImagePicker = UIImagePickerController()
        coreImagePicker.sourceType = .photoLibrary
        coreImagePicker.delegate = context.coordinator
        return coreImagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    typealias UIViewControllerType = UIImagePickerController
    
    func makeCoordinator() -> Coordinator {
        
        Coordinator(self)
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CoreImagePicker
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            parent.uiImage = info[.originalImage] as? UIImage
            
            parent.isPresenting = false
            
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            
            parent.isPresenting = false
            
        }
        
        init(_ coreImagePicker: CoreImagePicker) {
            
            self.parent = coreImagePicker
            
        }
    }
}
