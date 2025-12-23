//
//  altibiform.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 04/12/2025.
//

import SwiftUI

struct ConsultationForm: View {
    @State private var selectedDiseases: Set<ChronicDisease> = []
    @State var isTakingMedications = false
    
    @State var attachments: [PickedFile] = []
    var filesTypePicker = [FileType.camera, FileType.gallery, FileType.pdf]
    
    var body: some View {
        ScrollView{
                isTakingMedicationsView
                chronicDiseasesView
                explainYourCondition
                uploadAttached
        }
        .safeAreaInset(edge: .bottom) {
            saveButton
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .background(.regularMaterial)
        }
    }
}

extension ConsultationForm{

    private var isTakingMedicationsView: some View {
        VStack{
            Text("Are you currently taking any medications?")
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.horizontal)
                .frame( maxWidth: .infinity, alignment: .leading)
            
            
            HStack{
                HStack {
                    Button(action: { isTakingMedications = true }) {
                        HStack {
                            Image(systemName: isTakingMedications ? "checkmark.square.fill" : "square")
                            Text("Yes".localized())
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: { isTakingMedications = false }) {
                        HStack {
                            Image(systemName: !isTakingMedications ? "checkmark.square.fill" : "square")
                            Text("No".localized())
                        }
                    }
                    
                    Spacer()
                }
                
                
            }
            .padding()
        }
    }
        
    private var chronicDiseasesView: some View {
        VStack(spacing: 10){
            Text("Do you suffer from any chronic diseases?")
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.horizontal)
                .frame( maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 12) {
                
                ForEach(ChronicDisease.allCases, id: \.self) { disease in
                    Toggle(isOn: Binding(
                        get: { selectedDiseases.contains(disease) },
                        set: { isOn in
                            if isOn {
                                selectedDiseases.insert(disease)
                            } else {
                                selectedDiseases.remove(disease)
                            }
                        }
                    )) {
                        Text(disease.rawValue)
                    }
                    .toggleStyle(CheckboxStyle())
                }
                
                    //                        Text("Selected: \(selectedDiseases.map { $0.rawValue }.joined(separator: ", "))")
                    //                            .font(.footnote)
                    //                            .foregroundColor(.gray)
                    //                            .padding(.top, 16)
            }
            .padding()
        }
    }
    
    private var explainYourCondition: some View{
        VStack {
            Text("Explain your condition")
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.horizontal)
                .frame( maxWidth: .infinity, alignment: .leading)
            
            
        }
    }
    
    private var uploadAttached: some View {
        VStack{
            AppButton(state: .constant(.normal),style: .plain) {
                print("dsvsvd")
            } builder: {
                HStack{
                    VStack(alignment: .leading){
                        Text("Attach file")
                            .font(.headline)
                        Text("Optional")
                            .font(.callout)
                    }
                    .foregroundColor(Color.black)
                    
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
    
    private var saveButton: some View {
        AppButton(state: .constant(.normal)  ) {
           
        } builder: {
            Text("next")
        }
        .frame(height: 40)
    }
}

#Preview {
    ConsultationForm()
}

enum ChronicDisease: String, CaseIterable, Codable {
    case kidneyDiseases = "Kidney diseases"
    case heartAndVeinDiseases = "Heart and vein diseases"
    case none = "I do not suffer from any diseases"
    case chronicRespiratoryDiseases = "Chronic respiratory diseases"
    case diabetes = "Diabetes"
    case other = "Other diseases"
}

struct CheckboxStyle: ToggleStyle {
    var width:CGFloat = 24
    var height:CGFloat = 24
    func makeBody(configuration: Self.Configuration) -> some View {
        
        return HStack(alignment: .top) {
            Image(configuration.isOn ? "toggleOn" : "emptySquare")
                .resizable()
                .frame(width: width, height: height)
                .tint(configuration.isOn ? .yellow : .gray)
            configuration.label
            Spacer()
        }
        .onTapGesture { configuration.isOn.toggle() }
        
    }
}
