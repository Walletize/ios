//
//  Environment.swift
//  Walletize
//
//  Created by Yap Justin on 01/02/24.
//

import Foundation

public enum Env {
    enum Keys {
        static let BASE_URL = "BASE_URL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        
        return dict
    }()
    
    static let BASE_URL: String = {
        guard let str = Env.infoDictionary[Keys.BASE_URL] as? String else {
            fatalError("BASE_URL not found")
        }
        
        return str
    }()
}
