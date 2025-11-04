//
//  TextView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2024.
//

import SwiftUI


struct ContentView5: View {
    
    @State var string = ""
    
    var body: some View {
        
        VStack {
            
            EditorExample(outerMutableString2: $string)
                .border(.black)
                .frame(height: 200)
                .padding()
            
            
            VStack(alignment: .leading) {
                TextField("الدور - الشقة/الوحدة", text: $string)
                    .frame(height: 20) // Increase TextField height directly
                    .padding(.horizontal)
            }
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
            .padding()
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $string)
                    .padding(4)
                    .background(Color.white)
                    .cornerRadius(8)
                
                if string == "" {
                    Text("Enter your message")
                        .foregroundColor(.gray)
                        .padding()
                }

            }
            .frame(height: 120)
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
            .padding()

            
            TextEditor(text: $string)
                .frame(height: 100)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                .padding(.horizontal)
                .overlay {
                    if string == "" {
                        Text("Enter your message")
                            .foregroundColor(.gray)
                           // .padding(.horizontal, 5)
                            //.padding(.vertical, 8)
                            .offset(x: -95, y: -25)
                    }
                }
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

