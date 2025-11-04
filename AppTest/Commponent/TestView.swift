//
//  TestView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 09/06/2025.
//
import SwiftUI
import Foundation
import MapKit

struct PharmacyListView: View {
    let pharmacies: [Pharmacy]
    @State private var showingCallSheet = false
    @State private var selectedPharmacy: Pharmacy?

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(pharmacies) { pharmacy in
                    VStack(alignment: .leading, spacing: 8) {
                        // Name
                        Text(pharmacy.name)
                            .font(.system(.headline, design: .default))
                            .foregroundColor(.primary)
                        // Location details
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(pharmacy.cityName), \(pharmacy.governorateName)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            if let notes = pharmacy.addressNotes, !notes.isEmpty {
                                Text(notes)
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                        // Line number and buttons
                        HStack {
                            Text("Line: \(pharmacy.lineNumber)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            HStack(spacing: 10) {
                                Button(action: {
                                    selectedPharmacy = pharmacy
                                    showingCallSheet = true
                                }) {
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.blue)
                                        .padding(8)
                                        .background(Color(.systemGray6))
                                        .clipShape(Circle())
                                }
                                Button(action: {
                                    openInMaps(latitude: pharmacy.latitude, longitude: pharmacy.longitude, name: pharmacy.name)
                                }) {
                                    Image(systemName: "map.fill")
                                        .foregroundColor(.green)
                                        .padding(8)
                                        .background(Color(.systemGray6))
                                        .clipShape(Circle())
                                }
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 14, style: .continuous)
                            .fill(Color(.systemBackground))
                            .shadow(color: Color(.black).opacity(0.05), radius: 2, x: 0, y: 1)
                    )
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
       .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .confirmationDialog(
            "Choose a number to call",
            isPresented: $showingCallSheet,
            titleVisibility: .visible
        ) {
            if let pharmacy = selectedPharmacy {
                if !pharmacy.phoneNumber.isEmpty {
                    Button("Phone: \(pharmacy.phoneNumber)") {
                        callNumber(pharmacy.phoneNumber)
                    }
                }
                if !pharmacy.lineNumber.isEmpty {
                    Button("Line: \(pharmacy.lineNumber)") {
                        callNumber(pharmacy.lineNumber)
                    }
                }
                Button("Cancel", role: .cancel) {}
            }
        }
    }

    private func callNumber(_ number: String) {
        let digits = number.filter { $0.isNumber || $0 == "+" }
        if let url = URL(string: "tel://\(digits)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }

    private func openInMaps(latitude: String, longitude: String, name: String) {
        guard let lat = Double(latitude), let lon = Double(longitude) else { return }
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: nil)
    }
}




struct PharmacyListView_Previews: PreviewProvider {
    static var previews: some View {
//        PharmacyListView(pharmacies: [
//            Pharmacy(
//                id: 1,
//                name: "Roshdy Pharmacy",
//                email: "info@roshdypharma.com",
//                lineNumber: "02-26234567",
//                latitude: "30.0603",
//                longitude: "31.3307",
//                cityName: "مدينة نصر",
//                governorateName: "القاهرة",
//                phoneNumber: "01012345678",
//                addressNotes: nil
//            ),
//            Pharmacy(
//                id: 2,
//                name: "Roshdy Pharmacy",
//                email: "info@roshdypharma.com",
//                lineNumber: "02-26234567",
//                latitude: "30.0603",
//                longitude: "31.3307",
//                cityName: "مدينة نصر",
//                governorateName: "القاهرة",
//                phoneNumber: "01012345678",
//                addressNotes: nil
//            ),
//            Pharmacy(
//                id: 3,
//                name: "Roshdy Pharmacy",
//                email: "info@roshdypharma.com",
//                lineNumber: "02-26234567",
//                latitude: "30.0603",
//                longitude: "31.3307",
//                cityName: "مدينة نصر",
//                governorateName: "القاهرة",
//                phoneNumber: "01012345678",
//                addressNotes: nil
//            )
//        ])
//        
        ScrollView{
            VStack{
                CardView(description: "description description description description")
                
                CardView(description: "description descriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescriptiondescription")
                
                CardView()
                alertView()
                
            }
            .padding()
        }
    }
}


struct Pharmacy: Identifiable {
    let id: Int
    let name: String
    let email: String
    let lineNumber: String
    let latitude: String
    let longitude: String
    let cityName: String
    let governorateName: String
    let phoneNumber: String
    let addressNotes: String?
}


struct alertView:  View {
    @State private var showingAlert: Bool = false
    private var alertTitle: String = "Write short, descriptive, multiword alert titles"
    private var alertMessage: String = "Try to keep messages short enough to fit on one or two lines to prevent scrolling."
    private var alertButtonText: String = "Confirm"
    private var alertButtonText2: String = "show"

    var body: some View {
        Button(action: {
            showingAlert = true
        }) {
            Text("Show Alert")
        }.alert(Text(alertTitle),
            isPresented: $showingAlert,
            actions: {
                Button(alertButtonText) { }
            Button(alertButtonText2) { }
                Button("Cancel", role: .cancel) { }
            }, message: {
                Text(alertMessage)
            }
        )
    }
}


struct CardView: View {
    private let height: CGFloat = 90
    var description: String?
    var body: some View {
        
        HStack(alignment:.top,spacing: 15){
         
            Image(.calender)
                .resizable()
                .scaledToFit()
                .padding(.leading, 8)
                .frame(width: 35, height: 35)

            
            VStack(alignment: .leading, spacing: 8){
                Text("item?.title ?? ")
                    .bold()
                
                Text(description ?? "")
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }

            Spacer(minLength: 0)
        }
        .padding(.top, 4)
        .frame(height: height)
        .frame(maxWidth: .infinity)
        .padding(.all, 10)
        .background(Color.white)
        .cornerRadius(25)
        .shadow(radius: 5)
        
        
    }
}
