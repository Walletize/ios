//
//  WalletizeApp.swift
//  Walletize
//
//  Created by Yap Justin on 01/02/24.
//

import SwiftUI
import CryptoSwift

@main
struct WalletizeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.font, Nunito.body)
                .onAppear {
                    do {
                        let password: [UInt8] = Array("s33krit".utf8)
                        let salt: [UInt8] = Array("nacllcan".utf8)

                        /* Generate a key from a `password`. Optional if you already have a key */
                        let key = try PKCS5.PBKDF2(
                            password: password,
                            salt: salt,
                            iterations: 4096,
                            keyLength: 32, /* AES-256 */
                            variant: .sha2(.sha256)
                        ).calculate()

                        /* Generate random IV value. IV is public value. Either need to generate, or get it from elsewhere */
                        let iv = AES.randomIV(AES.blockSize)

                        /* AES cryptor instance */
                        guard let randomKey = generateRandomBytes(length: 32) else {
                            return
                        }
                        let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)

                        /* Encrypt Data */
                        var myString = "111"
                        var myInt = 111
                        let inputData = Data(bytes: &myInt,
                                             count: MemoryLayout.size(ofValue: myInt))
                        let encryptedBytes = try aes.encrypt(myString.bytes)
                        var encryptedData = Data(encryptedBytes)
                        encryptedData = iv + encryptedData
                        print(encryptedData)
                        let encryptedBase64 = encryptedData.base64EncodedString()
                        print(encryptedBase64)

                        /* Decrypt Data */
                        let decryptedBase64 = Data(base64Encoded: encryptedBase64, options: .ignoreUnknownCharacters)
                        let ivd = decryptedBase64?.prefix(16).bytes
                        let cypher = decryptedBase64?.suffix(16).bytes
                        let aesd = try AES(key: randomKey, blockMode: CBC(iv: ivd!), padding: .pkcs7)
                        let decryptedBytes = try aesd.decrypt(cypher!)
                        print(decryptedBase64)
                        let decryptedData = Data(decryptedBytes)
//                        let x = decryptedData.withUnsafeBytes({
//                            
//                            (rawPtr: UnsafeRawBufferPointer) in
//                            return rawPtr.load(as: Int.self)
//                            
//                        })
                        let x = String(data: decryptedData, encoding: .utf8)

                        print(x)
                    } catch {
                        
                    }
                    
                }
        }
    }
}
