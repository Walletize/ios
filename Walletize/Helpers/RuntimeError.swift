//
//  APIError.swift
//  Walletize
//
//  Created by Yap Justin on 04/02/24.
//

import Foundation

struct RuntimeError: LocalizedError {
    let description: String

    init(_ description: String) {
        self.description = description
    }

    var errorDescription: String? {
        description
    }
}
