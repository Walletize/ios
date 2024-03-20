//
//  LoginResponse.swift
//  Walletize
//
//  Created by Yap Justin on 01/02/24.
//

import Foundation

struct Login: Codable {
    var accessToken: String?
    var refreshToken: String?
}

struct LoginRequest: Codable {
    let email: String
    let password: String
}
