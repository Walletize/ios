//
//  LoginService.swift
//  Walletize
//
//  Created by Yap Justin on 01/02/24.
//

import Foundation

class AuthService {
    static let shared = AuthService()
    @Published var token: String?
    
    func login(email: String, password: String, completion: @escaping (Result<String, APIError>) -> Void) {
        let path = "/login"
        
        guard let url = URL(string: Env.BASE_URL + path) else {
            completion(.failure(APIError.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequest(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(APIError.custom(errorMessage: "No data")))
                return
            }
            let string = String(data: data, encoding: .utf8)!
                print("Data as JSON: ", string)
            
            guard let loginResponse = try? JSONDecoder().decode(Login.self, from: data) else {
                completion(.failure(APIError.custom(errorMessage: "Login decode failed")))
                return
            }
            
            guard let token = loginResponse.token else {
                completion(.failure(APIError.custom(errorMessage: "Token not found")))
                return
            }
            
            completion(.success(token))
            
        }.resume()
        
    }
    
    func signup(email: String, password: String, completion: @escaping (Result<Void, APIError>) -> Void) {
        let path = "/signup"
        
        guard let url = URL(string: Env.BASE_URL + path) else {
            completion(.failure(APIError.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = SignupRequest(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(.failure(APIError.custom(errorMessage: "No data")))
                return
            }
            let string = String(data: data, encoding: .utf8)!
                print("Data as JSON: ", string)
            
            guard let signup = try? JSONDecoder().decode(Signup.self, from: data) else {
                completion(.failure(.custom(errorMessage: "Signup decode failed")))
                return
            }
            
            guard signup.success != nil else {
                completion(.failure(.custom(errorMessage: "Signup success not found")))
                return
            }
            
            if signup.success! {
                completion(.success(()))
            } else {
                completion(.failure(.custom(errorMessage: "Signup failed")))
            }
        }.resume()
        
    }
}
