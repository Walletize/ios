//
//  Signup.swift
//  Walletize
//
//  Created by Yap Justin on 04/02/24.
//

import Foundation

struct Signup: Codable {
    var success: Bool?
    var message: String?
}

struct SignupRequest: Codable {
    let email: String
    let password: String
}
