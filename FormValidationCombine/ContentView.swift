//
//  ContentView.swift
//  FormValidationCombine
//
//  Created by 仲優樹 on 2025/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            Text("🛂 フォームバリデーション")
                .font(.title2)
                .bold()
            
            TextField("メールアドレス", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding(.horizontal)
            
            if !viewModel.isEmailValid && !viewModel.email.isEmpty {
                Text("メールアドレスの形式が正しくありません")
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            SecureField("パスワード（6文字以上）", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            if !viewModel.isPasswordValid && !viewModel.password.isEmpty {
                Text("パスワードは6文字以上にしてください")
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button("ログイン") {
                print("ログイン実行")
            }
            .disabled(!viewModel.isFormValid)
            .padding()
            .background(viewModel.isFormValid ? Color.blue : Color.gray)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
