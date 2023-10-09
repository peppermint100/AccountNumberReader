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
    private var names: [String]
    private var accountNumberRegex: [String] // 하이픈 포함, 미포함, (구)은행 전부 포함할 수 있도록 Array로
    
    private var availableBankName: [String] {
        get {
            return [id] + names
        }
    }

    init(id: String, names: [String], accountNumberRegex: [String]) {
        self.id = id
        self.names = names
        self.accountNumberRegex = accountNumberRegex
    }
    
    func matches(withName text: String) -> Bank? {
        for bankName in self.availableBankName {
            if text.contains(bankName) {
                return self
            }
        }
        
        return nil
    }
    
    func matches(withAccount text: String) -> String? {
        for regex in self.accountNumberRegex {
            if let compare = compareRegex(text: text, regexText: regex) {
                return compare
            }
        }
        
        return nil
    }
    
    private func compareRegex(text: String, regexText: String) -> String? {
        print("\(regexText)에 맞는 텍스트 검색 중...")
        do {
            let regex = try NSRegularExpression(pattern: regexText)
            let matches = regex.matches(
                in: text, options: [],
                range: NSRange(text.startIndex..., in: text))
            
            if let match = matches.first, let accountRange = Range(match.range, in: text) {
                let accountNumber = String(text[accountRange])
                print("텍스트 찾음 \(accountNumber)")
                return accountNumber
            }
        } catch {
            print(error.localizedDescription)
            print("정규 표현식 오류 발생")
        }
        
        return nil
    }
}
