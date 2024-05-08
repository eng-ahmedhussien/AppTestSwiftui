//
//  RoundedButton.swift
//  AppTest
//
//  Created by ahmed hussien on 29/04/2024.
//

import SwiftUI

struct RoundedButton : View {
    var label: String
    var buttonAction: () -> Void = {}
    var body: some View {
        Button(action: self.buttonAction) {
            HStack {
                Spacer()
                Text(self.label)
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .padding(.vertical, 10.0)
        .background(Color.blue)
        .cornerRadius(4.0)
        .padding(.horizontal, 50)
    }
}


struct test: View {
    @State private var isAuthenticating = false
    @State private var isIniting = false
    @State private var isInitSuccess = false
    @State private var isShow = false
    @State private var isError = false
    @State private var isErrorMessage = false
    @State private var country = "SA"
    @State private var amount = "100"
    @State private var currency = "SAR"
    @State private var phone = ""
    @State private var isVip = "false"
    @State private var dataResult = ""
    @State private var dataError = ""
    @State private var token = ""
    @State private var apiUrl = "https://api-sandbox.tamara.co"
    @State private var publishKey = "d36c6279-90c2-4239-b4e2-2c91bfda0fe4"
    @State private var pushUrl = "https://tamara.co/pushnotification"
    @State private var notificationToken = "aeae44a2-5f57-475e-a384-0e9b8a802326"
    @State private var isSandbox = "true"
    var body: some View {
        RoundedButton(label: "Init", buttonAction: {
            isIniting.toggle()
        })
        .padding(.top, 20)
        .alert("Init", isPresented: $isIniting) {
            TextField("token", text:$token)
            TextField("apiUrl", text: $apiUrl)
            TextField("publishKey", text: $publishKey)
            TextField("pushUrl", text: $pushUrl)
            TextField("notificationToken", text: $notificationToken)
            TextField("isSandbox", text: $isSandbox)
            Button("OK", action: initValue)
        }
    message: {}.alert("Init success", isPresented: $isInitSuccess) {
            Button("OK", role: .cancel) { }
        }
    }
    
    func initValue() {
    }
}

#Preview{
    test()
}
