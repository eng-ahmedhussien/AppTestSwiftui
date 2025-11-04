//
//  NursesViewModel.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 22/05/2025.
//
import SwiftUI
import Combine

class NursesViewModel: ObservableObject {
    @Published var nurses: [Nurse] = []
    @Published var isLoading = false
    @Published var hasNextPage = false

    func fetchNurses(isLoadMore: Bool = false) {
        guard !isLoading else { return }
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if !isLoadMore {
                self.nurses = Nurse.mockData
            } else {
                // simulate appending more data for pagination
                self.nurses.append(contentsOf: Nurse.mockData)
            }
            self.hasNextPage = self.nurses.count < 20 // fake pagination
            self.isLoading = false
        }
    }
}
