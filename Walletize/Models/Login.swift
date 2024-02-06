//
//  LoginResponse.swift
//  Walletize
//
//  Created by Yap Justin on 01/02/24.
//

import Foundation

struct Login: Codable {
    var token: String?
    var status: Bool?
    var message: String?
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}
