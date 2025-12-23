//
//  PrescriptionAddAttachmentView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//


import SwiftUI

struct AddAttachmentComponent: View {
    
    @State var attachments: [PickedFile]
    
    var filesTypePicker = [FileType.camera, FileType.gallery, FileType.pdf]
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text("Attach file")
                        .font(.headline)
                    Text("Optional")
                        .font(.callout)
                }
                
                Spacer()
                
                Image("upload")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24, alignment: .center)
                
                Text("Upload".localized())
                    .font(.headline)
                    .foregroundColor(Color.black)
            }
            .padding()
        }
        .background{
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [2]))
              
        }.padding()
        
        
        .onTapGesture {
            PopupAttachmentPicker(neededCases: filesTypePicker, title: "Upload product photo".localized()) { picked in
                attachments.append(picked)
            }.showAndStack()
        }
        
    }
}


#Preview {
    VStack{
        AddAttachmentComponent(
            attachments: [
                PickedFile(type: .image, image: UIImage(named: "deliveryTruck"), pdf: nil),
                PickedFile(type: .pdf, image: nil, pdf: nil),
                PickedFile(type: .pdf, image: nil, pdf: nil),
            ])
        
    }
}



