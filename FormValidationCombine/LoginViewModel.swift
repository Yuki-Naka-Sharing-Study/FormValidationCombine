//
//  LoginViewModel.swift
//  FormValidationCombine
//
//  Created by 仲優樹 on 2025/06/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isFormValid: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $email
            .map { self.validateEmail($0) }
            .assign(to: \.isEmailValid, on: self)
            .store(in: &cancellables)
        
        $password
            .map { $0.count >= 6 }
            .assign(to: \.isPasswordValid, on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest($isEmailValid, $isPasswordValid)
            .map { $0 && $1 }
            .assign(to: \.isFormValid, on: self)
            .store(in: &cancellables)
    }
    
    private func validateEmail(_ email: String) -> Bool {
        // 簡易的なメールアドレス判定
        let regex = #"^\S+@\S+\.\S+$"#
        return email.range(of: regex, options: .regularExpression) != nil
    }
}
