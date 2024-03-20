//
//  KeyGenerator.swift
//  Walletize
//
//  Created by Yap Justin on 18/03/24.
//

import Foundation

func generateRandomBytes(length: Int) -> [UInt8]? {
    var bytes = [UInt8](repeating: 0, count: length)
    let result = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)

    guard result == errSecSuccess else {
        print("Problem generating random bytes")
        return nil
    }

    return bytes
}
