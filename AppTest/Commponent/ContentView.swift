//
//  ContentView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 28/05/2025.
//


//import SwiftUI
//
//struct SavedPopup: View {
//    var body: some View {
//            VStack(spacing: 12) {
//                Image(systemName: "checkmark")
//                    .font(.system(size: 30, weight: .bold))
//                    .foregroundColor(.black)
//                
//                Text("Saved")
//                    .font(.custom("Cairo", fixedSize: 20))
//                    //.font(.body)
//                    .bold()
//                    .foregroundColor(.black)
//            }
//            .padding(50)
//            .background(.ultraThinMaterial) // For blur effect
//            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//    }
//}
//
//#Preview {
//    SavedPopup()
//}

import SwiftUI

struct NurseRequestCell: View {
    let nurseName: String
    let specialty: String
    let date: Date
    let price: String
    let image: Image
    var onCall: (() -> Void)?
    var onCancel: (() -> Void)?

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd 'at' h:mm a"
        return formatter.string(from: date)
    }

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .shadow(radius: 4)

            VStack(alignment: .leading, spacing: 8) {
                Text(nurseName)
                    .font(.headline)

                Text(specialty)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                HStack {
                    Text("Date:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(formattedDate)
                        .font(.caption)
                }

                HStack {
                    Text("Price:")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Text(price)
                        .font(.caption)
                }
                
                HStack(spacing: 16) {
                    Button(action: {
                        onCall?()
                    }) {
                        Text("Call")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.green)
                            .clipShape(Capsule())
                    }

                    Button(action: {
                        onCancel?()
                    }) {
                        Text("Cancel")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.red)
                            .clipShape(Capsule())
                    }
                }
                .padding(.top, 8)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color(.black).opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Preview
struct NurseRequestCell_Previews: PreviewProvider {
    static var previews: some View {
        NurseRequestCell(
            nurseName: "Sarah Ahmed",
            specialty: "Pediatric Nurse",
            date: Date(),
            price: "$100",
            image: Image(systemName: "person.crop.circle"),
            onCall: { print("Call button tapped") },
            onCancel: { print("Cancel button tapped") }
        )
        .previewLayout(.sizeThatFits)
    }
}
