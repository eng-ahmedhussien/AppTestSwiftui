//
//  SwappableView_usingTransaction.swift
//  AppTestSwiftui
//
//  Created by ahmed hussien on 02/12/2024.
//

import SwiftUI



struct SwappableView_usingTransaction: View {
    
    var body: some View {
        let items = [
            SwappableItem(iconName: "star.fill", text: "#1 fitst", iconColor: .purple),
            SwappableItem(iconName: "star", text: "#2 secound", iconColor: .purple),
            SwappableItem(iconName: "square.and.arrow.up.circle.fill", text: "#3 thard", iconColor: .purple)
        ]
        
        SwappableView(viewModel: SwappableViewModel(items: items))
            .frame(width: 300, height: 30)
           
    }
}

#Preview {
    SwappableView_usingTransaction()
}


struct SwappableItem: Identifiable {
    let id = UUID()
    let iconName: String
    let text: String
    let iconColor: Color
}

class SwappableViewModel: ObservableObject {
    @Published var currentIndex: Int = 0
    var items: [SwappableItem]
    private var timer: Timer?

    init(items: [SwappableItem]) {
        self.items = items
    }
    
    deinit {
        timer?.invalidate()
    }

     func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }

            self.currentIndex = (self.currentIndex + 1) % self.items.count

            
            
        }
    }
}

struct SwappableView: View {
    @StateObject var viewModel: SwappableViewModel

    var body: some View {
        ZStack {
            HStack {
                Image(systemName: viewModel.items[viewModel.currentIndex].iconName)
                    .foregroundColor(viewModel.items[viewModel.currentIndex].iconColor)
                Text(viewModel.items[viewModel.currentIndex].text)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .id(viewModel.currentIndex)
            .transition(.asymmetric(
                insertion: .move(edge: .bottom).combined(with: .opacity),
                removal: .move(edge: .top).combined(with: .opacity)
            ))

        }
        .clipped()
        // Apply animation to the ZStack based on currentIndex changes
        .animation(.easeInOut(duration: 0.5), value: viewModel.currentIndex)
        .onAppear {
            viewModel.startTimer()
        }
       
    }
}
