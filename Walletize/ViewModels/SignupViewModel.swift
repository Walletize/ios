//
//  SignupViewModel.swift
//  Walletize
//
//  Created by Yap Justin on 04/02/24.
//

import Foundation

class SignupViewModel: ObservableObject {
    let service = AuthService.shared
    var email: String = ""
    var password: String = ""
    
    func signup() {
        service.signup(email: email, password: password) { result in
            switch result {
            case .success():
                self.service.login(email: self.email, password: self.password) { result in
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
            case .failure(let error):
                print(error.localizedDescription, error)
            }
        }
    }
}
