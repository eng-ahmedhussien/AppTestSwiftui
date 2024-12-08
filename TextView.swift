//
//  TextView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2024.
//

import SwiftUI


struct ContentView5: View {
  
    @State var string = "PlaceHolder"
    
    var body: some View {
        VStack {
            Text("\(string)")
            EditorExample(outerMutableString2: $string)
                .border(.black)
                .frame(height: 200)
                .padding()
            
            TextField("", text: .constant("jguy"))
        }
    }
}

struct EditorExample: UIViewRepresentable {
    @Binding var outerMutableString2: String
    
    // this is called first
    func makeCoordinator() -> Coordinator {
        // we can't pass in any values to the Coordinator because they will be out of date when update is called the second time.
        Coordinator()
    }
    
    // this is called second
    func makeUIView(context: Context) -> UITextView {
        context.coordinator.textView
    }
    
    // this is called third and then repeatedly every time a let or `@Binding var` that is passed to this struct's init has changed from last time.
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = outerMutableString2
        // we don't usually pass bindings in to the coordinator and instead use closures.
        // we have to set a new closure because the binding might be different.
         context.coordinator.stringDidChange2 = { string in
            outerMutableString2 = string
        }
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        lazy var textView: UITextView = {
            let textView = UITextView()
            textView.font = UIFont(name: "Helvetica", size: 30.0)
            textView.delegate = self
            textView.font = UIFont.preferredFont(forTextStyle: .body)
            textView.isScrollEnabled = true
            textView.isEditable = true
            textView.isUserInteractionEnabled = true
            textView.textColor = UIColor(.black)
            textView.backgroundColor = .lightText
            textView.layer.cornerRadius = 25
            textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            textView.text = "Placeholder"
            textView.textColor = .gray
            return textView
        }()
        
        var stringDidChange2: ((String) -> ())?
        
        func textViewDidChange(_ textView: UITextView) {
            stringDidChange2?(textView.text)
        }
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            if textView.textColor == UIColor.gray {
                textView.text = ""
                textView.textColor = UIColor.black
            }
        }
        func textViewDidEndEditing(_ textView: UITextView) {
            if textView.text.isEmpty {
                textView.text = "Placeholder"
                textView.textColor = UIColor.gray
            }
        }

        
    }
}

#Preview {
    ContentView5()
}

//
//struct TextViewWithPlaceholder: View {
//    @Binding var text: String
//    var placeholder: String
//
//    var body: some View {
//        VStack{
//            Text("\(text) a")
//                .font(.title)
//                .foregroundColor(.black)
//            
//            UITextViewWrapper(text: $text)
//                .frame(height: 300)
//                .padding()
//        }
//    }
//}
//
//struct UITextViewWrapper: UIViewRepresentable {
//    @Binding var text: String
//    var placeholder = "Placeholder"
//
//    func makeUIView(context: Context) -> UITextView {
//        let textView = UITextView()
//        textView.delegate = context.coordinator
//        textView.font = UIFont.preferredFont(forTextStyle: .body)
//        textView.isScrollEnabled = true
//        textView.isEditable = true
//        textView.isUserInteractionEnabled = true
//        textView.text = text
//        textView.textColor = UIColor(.black)
//        textView.backgroundColor = .lightGray
//        textView.layer.cornerRadius = 25
//        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        textView.text = "Placeholder"
//        textView.textColor = UIColor.red
//
////        if LocalizationManager.shared.currentLanguage == .arabic {
////            textView.textAlignment = .right
////        } else {
////            textView.textAlignment = .left
////        }
//        
//
//        
//        // Initialize with placeholder if text is empty
////        if text.isEmpty {
////            textView.text = placeholder
////            textView.textColor = UIColor.lightGray
////        } else {
////            textView.text = text
////            textView.textColor = UIColor(Color.theme.primary)
////        }
//        return textView
//    }
//
//    func updateUIView(_ uiView: UITextView, context: Context) {
//        //uiView.text = text
////        uiView.text = "Placeholder"
////        uiView.textColor = UIColor.lightGray
//        // Update UITextView's content
////        if text.isEmpty {
////            if uiView.text != placeholder {
////                uiView.text = placeholder
////                uiView.textColor = .red
////            }
////        } else {
////           // if uiView.text != text {
////                uiView.text = text
////                uiView.textColor = UIColor(.black)
////           // }
////        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, UITextViewDelegate {
//        var parent: UITextViewWrapper
//
//        init(_ parent: UITextViewWrapper) {
//            self.parent = parent
//        }
//
////        func textViewDidChange(_ textView: UITextView) {
////            self.parent.text = textView.text
////        }
//        func textViewDidChange(_ textView: UITextView) {
//            // Update binding when the user types
////            if textView.textColor == UIColor.red {
////                // Prevent placeholder text from being treated as real input
////                textView.text = ""
////                textView.textColor = .black
////            }
////            parent.text = textView.text
//            
//            
//            if textView.text.isEmpty {
//                textView.text = placeholder
//                textView.textColor = UIColor.red
//                parent.text = textView.text
//            } else {
//                textView.text = text
//                textView.textColor = UIColor(Color.theme.primary)
//                parent.text = textView.text
//            }
//        }
//        
//        
////        func textViewDidChangeSelection(_ textView: UITextView) {
////            // Prevent cursor interaction with placeholder
////            if textView.window != nil && textView.textColor == UIColor.lightGray {
////                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
////               // textView.text
////            }
////        }
//        
////        func textViewDidBeginEditing(_ textView: UITextView) {
////            // Clear placeholder text when editing begins
//////            if textView.text == parent.placeholder {
//////                textView.text = ""
//////                textView.textColor = UIColor(Color.theme.primary)
//////            }
////            if textView.textColor == UIColor.lightGray {
////                textView.text = nil
////                textView.textColor = UIColor.black
////            }
////        }
//        
////        func textViewDidEndEditing(_ textView: UITextView) {
////            // Restore placeholder text if no user input
//////            if textView.text.isEmpty {
//////                textView.text = parent.placeholder
//////                textView.textColor = UIColor.lightGray
//////            }
////            if textView.text.isEmpty {
////                textView.text = "Placeholder"
////                textView.textColor = UIColor.lightGray
////            }
////        }
//    }
//}
//
//struct ContentView_PreviewsTextsdkfljasl: PreviewProvider {
//    static var previews: some View {
//        TextViewWithPlaceholder(text: .constant(""), placeholder: "amar")
//    }
//}
