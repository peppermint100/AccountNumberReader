//
//  AccountExtractor.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/09/27.
//

import Foundation

class AccountExtractor {

    static let shared = AccountExtractor()
    private init() {}

    func extractAccount(from text: String) -> String {
        let copyScope = SettingsManager.shared.getCopyScope()
        let bank = self.getBank(from: text)
        let accountNumber = self.getAccountNumber(from: text, bank: bank)
        
        switch copyScope {
        case .onlyAccountNumber:
            return accountNumber ?? ""
        case .includeBankName:
            return "\(bank.id) \(accountNumber ?? "")"
        }
    }
    
    private func getBank(from text: String) -> Bank {
        print("은행 가져오는 중...")
        let allBanks = Constants.bankList
        
        for bank in allBanks {
            print("\(bank.id) 확인 중...")
            if let bank = bank.matches(withName: text) {
                print("\(bank.id) 확인")
                return bank
            }
        }
        
        print("맞는 은행 없음")
        return Constants.invalidBank
    }
    
    private func getAccountNumber(from text: String, bank: Bank) -> String? {
        print("계좌번호 가져오는 중...")
        return bank.matches(withAccount: text)
    }
}
