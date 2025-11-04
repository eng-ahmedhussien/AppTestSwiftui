//
//  NursesListView.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 22/05/2025.
//


import SwiftUI

struct NursesListView: View {
    @StateObject private var viewModel = NursesViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.nurses) { nurse in
                    NurseCardView(nurse: nurse)
                        .onAppear {
                            if nurse.id == viewModel.nurses.last?.id && viewModel.hasNextPage {
                                viewModel.fetchNurses(isLoadMore: true)
                            }
                        }
                }

                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Nurses")
            .onAppear {
                viewModel.fetchNurses()
            }
        }
    }
}


struct NurseCardView: View {
    let nurse: Nurse

    var body: some View {
        HStack(spacing: 16) {
            AsyncImage(url: URL(string: nurse.image)) { image in
                image.resizable()
            } placeholder: {
                Image(systemName: "photo.fill")
            }
            .frame(width: 60, height: 60)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(nurse.fullName)
                    .font(.headline)
                Text(nurse.specialization)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("License: \(nurse.licenseNumber)")
                    .font(.caption)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview(body: {
    NursesListView()
})
