//
//  CookImagePicker.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/13.
//

import SwiftUI
import PhotosUI

struct CookImagePicker: UIViewControllerRepresentable {

    @Binding var show: Bool
    @Binding var ImageData: Data
    
    func makeCoordinator() -> Coordinator {
        return CookImagePicker.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        
        let controller = PHPickerViewController(configuration: PHPickerConfiguration())
        controller.delegate = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
        
    }
    
    class Coordinator: NSObject,PHPickerViewControllerDelegate{
        
        var parent: CookImagePicker
        
        init(parent: CookImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            if !results.isEmpty{
                
                if results.first!.itemProvider.canLoadObject(ofClass: UIImage.self){
                    
                    results.first!.itemProvider.loadObject(ofClass: UIImage.self) { (image, _) in
                        
                        guard let imageData = image else{return}
                        
                        let data = (imageData as! UIImage).jpegData(compressionQuality: 0.5)!
                        
                        DispatchQueue.main.async {
                            
                            self.parent.ImageData = data
                            self.parent.show.toggle()
                        }
                    }
                }
                else{
                    self.parent.show.toggle()
                }
            }
            else{
                self.parent.show.toggle()
            }
        }
    }
}
