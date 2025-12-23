//
//  AtibbiServicePage.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 14/12/2025.
//


import SwiftUI

struct ConsultationView: View {
    
    @State private var selectedTab: ConsultationTab = .current
    
    var body: some View {
        ScrollView {
            
            Button {
                print("")
            } label: {
                Text("go to altibbi")
            }.buttonStyle(.bordered)
            
            
            Picker("", selection: $selectedTab) {
                ForEach(ConsultationTab.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
       
            if selectedTab == .current {
                currentConsultation
            } else {
                previousConsultation
            }
            
            Spacer()
        }
        .padding()
    }
}

extension ConsultationView {
    
    var currentConsultation: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Current Consultation")
                .font(.title2.bold())
            
            Text("Prescriptions pending your action or awaiting doctor's response.")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            ConsultationCard()
        }
    }
    
    var previousConsultation: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Previous Consultation")
                .font(.title2.bold())
            
            Text("Your history of requested prescriptions.")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            ConsultationCard()
        }
    }
}

struct ConsultationCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text("Weight-Loss Consultation")
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Button("Join to chat") {}
                    .font(.footnote.bold())
                    .padding(.horizontal, 14)
                    .padding(.vertical, 8)
                    .background(.yellow)
                    .clipShape(Capsule())
            }
            
            HStack(spacing: 12) {
                Circle()
                    .fill(.yellow.opacity(0.2))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.yellow)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Dr. Mohamed Ahmed")
                        .font(.subheadline.bold())
                    
                    Text("Nutritionist • 3 Nov 2025, 09:00 Am")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Text("Patient with common cold symptoms: runny stuffy nose, mild cough, low-grade fever.")
                .font(.subheadline)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.blue.opacity(0.4))
                )
            
            HStack {
                Text("Consultation no#: nc-12345")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Text("Fee: ₤ 50")
                    .font(.subheadline.bold())
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .shadow(color: .black.opacity(0.08), radius: 10)
        )
    }
}

enum ConsultationTab: String, CaseIterable {
    case current = "Current"
    case previous = "Previous"
}

#Preview {
    ConsultationView()
}
