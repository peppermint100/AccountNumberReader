//
//  SettingManager.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/09/27.
//

import Foundation

class SettingsManager {
    static let shared = SettingsManager()
    
    func getCopyScope() -> CopyScope {
        if let stringValue = UserDefaults.standard.string(forKey: SettingElement.copyScope(nil).keyName),
           let setting = CopyScope(rawValue: stringValue) {
            return setting
        } else {
            return CopyScope.includeBankName
        }
    }
    
    func getLeaveHistory() -> LeaveHistory {
        if let stringValue = UserDefaults.standard.string(forKey: SettingElement.leaveHistory(nil).keyName),
           let setting = LeaveHistory(rawValue: stringValue) {
            return setting
        } else {
            return LeaveHistory.every
        }
    }
}
