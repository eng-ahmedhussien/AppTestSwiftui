//
//  CartItemRow.swift
//  AppTestSwiftui
//
//  Created by Vodafone on 06/05/2026.
//
// Receives items from VM, passes them down

import SwiftUI

struct UserModel {
    var total: Int
    var onIncresse: (() -> Void)?
    var onDecresse: (() -> Void)?
}

final class UserViewModel: ObservableObject {
    @Published var user: UserModel

    init() {
        self.user = UserModel( total: 20)

        // VM sets the closure
        self.user.onIncresse = increese
        self.user.onDecresse = deincreese
    }
    
    func increese() {
        user.total += 1
    }
    
    func deincreese() {
        user.total -= 1
    }
}

// Level 1
struct ParentView: View {
    @StateObject private var vm = UserViewModel()

    var body: some View {
        LevelOneView(user: vm.user)
    }
}

// Level 2
struct LevelOneView: View {
    let user: UserModel

    var body: some View {
        LevelTwoView(user: user)
    }
}

// Level 3
struct LevelTwoView: View {
    let user: UserModel

    var body: some View {
        LevelThreeView(user: user)
    }
}

// Deepest view
struct LevelThreeView: View {
    let user: UserModel

    var body: some View {
       HStack{
           Button("-") {
               user.onDecresse?()
           }
           
            Text("Total: \(user.total)")
           
           Button("+") {
               user.onIncresse?()
           }
        }
       
    }
}
#Preview{
    ParentView()
}
