//
//  famailyMembersPage.swift
//  AlDwaaNewApp
//
//  Created by ahmed hussien on 24/11/2025.
//

import SwiftUI

struct familyMembersPage: View {
    
    @State var selectedFamilyMember: Int? = nil
    private let cornerRadius: CGFloat = 25
    
    var body: some View {
        VStack(alignment: .leading,spacing: 24) {
            Text("Select the patient for this consultation.")
                .font(.system(size: 20, weight: .semibold))
                .padding(.horizontal)
            
            VStack(spacing: 16) {
                ForEach(0...2,id: \.self){ value in
                    familyMemberCard
                        .background{
                            RoundedRectangle(cornerRadius:25)
                                .stroke( selectedFamilyMember == value ? Color.yellow : Color.clear, lineWidth: 3)
                        }
                        .onTapGesture{
                            selectedFamilyMember = value
                        }
                }
                addFamilyButton
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            nextButton
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .background(.regularMaterial)
        }
        
    }
        
    private var familyMemberCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .firstTextBaseline) {
                Text("Ahmed Mohamed")
                    .font(.system(size: 18, weight: .bold))
                
                Spacer()
            }
            
            Text("095-7926745")
                .font(.system(size: 16))
        }
        .padding(20)
        .cardBackground(cornerRadius: 25,shadowRadius: 5)

    }
    
    private var addFamilyButton: some View {
        Button(action: {
                // add family member action
        }) {
            HStack {
                Image(systemName: "plus")
                    .font(.system(size: 18, weight: .semibold))
                Text("Add a new family member")
                    .font(.system(size: 16, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(16)
            .cardBackground(cornerRadius: 25,shadowRadius: 5,shadowY: 4)
        }
    }
    
    private var nextButton: some View {
        AppButton(state: .constant(.normal)) {
            print("vasvsd")
        } builder: {
            Text("next")
        }
        .frame(height: 40)
    }
}

    // MARK: - Helpers & Preview


struct PatientSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        familyMembersPage()
            
    }
}


    
