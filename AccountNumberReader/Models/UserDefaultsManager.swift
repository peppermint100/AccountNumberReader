//
//  UserDefaultsManager.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/08/28.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    func load(_ key: String) -> String? {
        if let value =  UserDefaults.standard.string(forKey: key) {
            return value
        }
        
        return nil
    }
    
    func save(key: String, value: String) {
        UserDefaults.standard.setValue(value, forKey: key)
    }
}
