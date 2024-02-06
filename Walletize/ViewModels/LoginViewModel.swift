//
//  LoginViewModel.swift
//  Walletize
//
//  Created by Yap Justin on 01/02/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    let service = AuthService.shared
    var email: String = ""
    var password: String = ""
    
    func login() {
        service.login(email: email, password: password) { result in
            switch result {
            case .success(let token):
                UserDefaults.standard.setValue(token, forKey: "jsonwebtoken")
                DispatchQueue.main.async {
                    self.service.token = token
                }
            case .failure(let error):
                print(error.localizedDescription, error)
            }
        }
    }
    
    func signout() {
        UserDefaults.standard.removeObject(forKey: "jsonwebtoken")
        DispatchQueue.main.async {
            self.service.token = nil
        }
    }
}
