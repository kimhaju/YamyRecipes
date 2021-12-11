//
//  CustomTextField.swift
//  YamyRecipes
//
//  Created by haju Kim on 2021/12/11.
//

import SwiftUI

struct DynamicTextField: UIViewRepresentable {
    
    @Binding var text: String
    @Binding var height: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        
        textView.isScrollEnabled = true
        textView.alwaysBounceVertical = false
        
        textView.text = text
        textView.backgroundColor = UIColor.clear
        
        context.coordinator.textView = textView
        textView.delegate = context.coordinator
        textView.layoutManager.delegate = context.coordinator
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(dynamicTextField: self)
   }
}

class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate{

    var dynamicTextField: DynamicTextField
    weak var textView: UITextView?
    
    init(dynamicTextField: DynamicTextField) {
        self.dynamicTextField = dynamicTextField
    }

    func textViewDidChange(_ textView: UITextView) {
        self.dynamicTextField.text = textView.text
    }

    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - 달라진 길이 호출 메서드
    
    func layoutManager(_ layoutManager: NSLayoutManager, didCompleteLayoutFor textContainer: NSTextContainer?, atEnd layoutFinishedFlag: Bool){
        
        DispatchQueue.main.async { [weak self] in
            guard let view = self?.textView else { return }
            
            let size = view.sizeThatFits(view.bounds.size)
            
            if self?.dynamicTextField.height != size.height { self?.dynamicTextField.height = size.height }
        }
    }
}
