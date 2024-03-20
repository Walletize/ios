//
//  Encryption.swift
//  Walletize
//
//  Created by Yap Justin on 19/03/24.
//

import Foundation
import CryptoSwift

func encrypt(plaintext: [UInt8], key: [UInt8]) -> String? {
    do {
        let iv = AES.randomIV(AES.blockSize)
        
        let encipher = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
        var ciphertext = try encipher.encrypt(plaintext)
        ciphertext = iv + ciphertext
        
        return ciphertext.toBase64()
    } catch {
        return nil
    }
}

func decrypt(ciphertext: String, key: [UInt8]) -> Data? {
    do {
        let decodedCipherText = Data(base64Encoded: ciphertext, options: .ignoreUnknownCharacters)
        guard let decodedCipherText else {
            throw(RuntimeError("Decoding ciphertext failed"))
        }
        let iv = decodedCipherText.prefix(16).bytes
        let ciphertextBinary = decodedCipherText.suffix(decodedCipherText.count - 16).bytes
        
        let decipher = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
        let plaintext = try decipher.decrypt(ciphertextBinary)
        
        return Data(plaintext)
    } catch {
        return nil
    }
}
