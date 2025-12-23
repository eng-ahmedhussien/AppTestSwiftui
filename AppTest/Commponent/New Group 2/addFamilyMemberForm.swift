//
//  addFamilyMemberForm.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 02/12/2025.
//
import SwiftUI

struct addFamilyMemberForm: View {
   @State var fullName = ""
   @State var phoneNumber: String = ""
    @State  var dateOfBirth = Date()
    @State var selectRelationship: String = ""
    @State var Weight: String = ""
    @State var Height: String = ""
    
    @State private var showingPicker = false
   
    var body: some View {
        VStack(alignment: .leading,spacing: 0){
            Text("Add family member information")
                .font(.headline.bold())
                .padding(.horizontal)
                .frame( maxWidth: .infinity, alignment: .leading)
            
            AppTextField(text: $fullName, placeholderText: "full name", validation: .isEmpty)
            AppTextField(text: $phoneNumber, placeholderText: "phoneNumber", validation: .isEmpty)
            AppTextField(text: $selectRelationship, placeholderText: "selectRelationship", validation: .isEmpty)
            HStack(alignment: .center, spacing: 5) {
                AppTextField(text: $Weight, placeholderText: "Weight", validation: .numeric)
                AppTextField(text: $Height, placeholderText: "Height", validation: .numeric)
            }
                
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            saveButton
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .background(.regularMaterial)
        }
    }
    
    private var saveButton: some View {
        AppButton(state: .constant(.normal)) {
            print("vasvsd")
        } builder: {
            Text("save")
        }
        .frame(height: 40)
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}

#Preview{
    addFamilyMemberForm()
}
