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
            case .success(let accessToken):
                do {
                    try self.service.keychain.set(accessToken, key: "accessToken")
                }
                catch let error {
                    print(error)
                }
                
                DispatchQueue.main.async {
                    self.service.token = accessToken
                }
            case .failure(let error):
                print(error.localizedDescription, error)
            }
        }
    }
    
    func signout() {
        do {
            try self.service.keychain.remove("accessToken")
        }
        catch let error {
            print(error)
        }
        
        DispatchQueue.main.async {
            self.service.token = nil
        }
    }
}
