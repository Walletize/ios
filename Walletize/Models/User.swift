//
//  User.swift
//  Walletize
//
//  Created by Yap Justin on 18/03/24.
//

import Foundation

struct User: Codable {
    var id: String?
    var email: String
    var password: String?
    var salt: String
    var key: String
}

struct UserResponse: Codable {
    var user: User
}
