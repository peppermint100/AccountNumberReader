//
//  Bank.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/09/27.
//

import Foundation

import Foundation

class Bank {
    var id: String
    var names: [String]
    var accountNumberRegex: [String] // 하이픈 포함, 미포함, (구)은행 전부 포함할 수 있도록 Array로
    
    var availableBankName: [String] {
        get {
            return [id] + names
        }
    }

    init(id: String, names: [String], accountNumberRegex: [String]) {
        self.id = id
        self.names = names
        self.accountNumberRegex = accountNumberRegex
    }
}
