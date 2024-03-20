//
//  LoginService.swift
//  Walletize
//
//  Created by Yap Justin on 01/02/24.
//

import Foundation
import KeychainAccess
import CryptoSwift

class AuthService {
    static let shared = AuthService()
    let keychain = Keychain(service: "com.walletize.Walletize")
    @Published var token: String?
    @Published var user: User?
    
    func login(email: String, password: String, completion: @escaping (Result<String, RuntimeError>) -> Void) {
        let path = "/login"
        
        guard let url = URL(string: Env.BASE_URL + path) else {
            completion(.failure(RuntimeError("URL is not correct")))
            return
        }
        
        let body = LoginRequest(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(RuntimeError("No data")))
                return
            }
            let string = String(data: data, encoding: .utf8)!
                print("Data as JSON: ", string)
            
            guard let loginResponse = try? JSONDecoder().decode(Login.self, from: data) else {
                completion(.failure(RuntimeError("Login decode failed")))
                return
            }
            
            guard let accessToken = loginResponse.accessToken else {
                completion(.failure(RuntimeError("Token not found")))
                return
            }
            
            self.getUser(accessToken: accessToken) { result in
                switch result {
                case .success(var user):
                    do {
                        let derivedKey = try PKCS5.PBKDF2(
                            password: Array(password.utf8),
                            salt: Array(user.salt.utf8),
                            iterations: 4096,
                            keyLength: 32,
                            variant: .sha2(.sha256)
                        ).calculate()
                        
                        guard let decryptedKey = decrypt(ciphertext: user.key, key: derivedKey) else {
                            completion(.failure(RuntimeError("Key decryption failed")))
                            return
                        }
                        user.key = decryptedKey.base64EncodedString()
                        self.user = user
                    } catch {
                        completion(.failure(RuntimeError("Key derivation failed")))
                    }
                case .failure(let error):
                    print(error.localizedDescription, error)
                }
            }
            
            completion(.success(accessToken))
        }.resume()
        
    }
    
    func signup(email: String, password: String, completion: @escaping (Result<String, RuntimeError>) -> Void) {
        let path = "/signup"
        
        guard let url = URL(string: Env.BASE_URL + path) else {
            completion(.failure(RuntimeError("URL is not correct")))
            return
        }
        guard let key = generateRandomBytes(length: 32) else {
            completion(.failure(RuntimeError("Generate random key failed")))
            return
        }
        guard let salt = generateRandomBytes(length: 16) else {
            completion(.failure(RuntimeError("Generate salt failed")))
            return
        }
        do {
            let derivedKey = try PKCS5.PBKDF2(
                password: Array(password.utf8),
                salt: salt,
                iterations: 4096,
                keyLength: 32,
                variant: .sha2(.sha256)
            ).calculate()
            
            guard let encryptedKey = encrypt(plaintext: key, key: derivedKey) else {
                completion(.failure(RuntimeError("Key encryption failed")))
                return
            }
            
            let user = User(email: email, password: password, salt: salt.toBase64(), key: encryptedKey)
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try? JSONEncoder().encode(user)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                guard let data = data, error == nil else {
                    completion(.failure(RuntimeError("No data")))
                    return
                }
                let string = String(data: data, encoding: .utf8)!
                    print("Data as JSON: ", string)
                
                guard let signup = try? JSONDecoder().decode(Signup.self, from: data) else {
                    completion(.failure(RuntimeError("Signup decode failed")))
                    return
                }
                
                guard signup.success != nil else {
                    completion(.failure(RuntimeError("Signup success not found")))
                    return
                }
                
                if signup.success! {
                    self.login(email: email, password: password) { result in
                        switch result {
                        case .success(let token):
                            completion(.success((token)))
                        case .failure(let error):
                            print(error.localizedDescription, error)
                        }
                    }
                } else {
                    completion(.failure(RuntimeError("Signup failed")))
                }
            }.resume()
        } catch {
            
        }
    }
    
    func getUser(accessToken: String, completion: @escaping (Result<User, RuntimeError>) -> Void) {
        let path = "/users"
        
        guard let url = URL(string: Env.BASE_URL + path) else {
            completion(.failure(RuntimeError("URL is not correct")))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        print(request.value(forHTTPHeaderField: "Authorization") ?? "")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        guard let data = data, error == nil else {
                            completion(.failure(RuntimeError("No data")))
                            return
                        }
                        let string = String(data: data, encoding: .utf8)!
                            print("Data as JSON: ", string)
                        
                        guard let userResponse = try? JSONDecoder().decode(UserResponse.self, from: data) else {
                            completion(.failure(RuntimeError("User decode failed")))
                            return
                        }
                        
                        completion(.success(userResponse.user))
                    } else {
                        completion(.failure(RuntimeError("Get user request error \(httpResponse.statusCode)")))
                    }
                }
            } else {
                completion(.failure(RuntimeError("Get user error")))
            }
        }.resume()
    }
}
