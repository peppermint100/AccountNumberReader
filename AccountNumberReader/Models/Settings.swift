import Foundation

struct AppSetting {
    var settingKey: SettingKey
    var settingValues: [SettingValue]
}

enum SettingKey {
    case copyScope
    case includeHyphen
    case leaveHistory
    
    static func rawValue(of this: SettingKey) -> String {
        switch this {
        case .copyScope:
            return "copyScope"
        case .includeHyphen:
            return "includeHyphen"
        case .leaveHistory:
            return "leaveHistory"
        }
    }
    
    static func associateOptions(of this: SettingKey) -> [SettingValue] {
        switch this {
        case .copyScope:
            return [.copyScopeOnlyAccountNumber, .copyScopeIncludeBankName, .copyScopeIncludeName]
        case .includeHyphen:
            return [.includeHyphenOn, .includeHyphenOff]
        case .leaveHistory:
            return [.leaveHistoryEvery, .leaveHistoryAsk, .leaveHistoryNever]
        }
    }
}

enum SettingValue {
    case copyScopeOnlyAccountNumber
    case copyScopeIncludeBankName
    case copyScopeIncludeName
    case includeHyphenOn
    case includeHyphenOff
    case leaveHistoryEvery
    case leaveHistoryAsk
    case leaveHistoryNever
    
    static func rawValue(of this: SettingValue) -> String {
        switch this {
        case .copyScopeOnlyAccountNumber:
            return "copyScopeOnlyAccountNumber"
        case .copyScopeIncludeBankName:
            return "copyScopeIncludeBankName"
        case .copyScopeIncludeName:
            return "copyScopeIncludeName"
        case .includeHyphenOn:
            return "includeHyphenOn"
        case .includeHyphenOff:
            return "includeHyphenOff"
        case .leaveHistoryEvery:
            return "leaveHistoryEvery"
        case .leaveHistoryAsk:
            return "leaveHistoryAsk"
        case .leaveHistoryNever:
            return "leaveHistoryNever"
        }
    }
    
    static func getTitle(of this: SettingValue) -> String {
        switch this {
        case .copyScopeOnlyAccountNumber:
            return "계좌번호"
        case .copyScopeIncludeBankName:
            return "계좌번호, 은행명"
        case .copyScopeIncludeName:
            return "계좌번호, 은행명, 이름"
        case .includeHyphenOn:
            return "하이픈 포함"
        case .includeHyphenOff:
            return "하이픈 미포함"
        case .leaveHistoryEvery:
            return "매 스캔마다"
        case .leaveHistoryAsk:
            return "매번 물어보기"
        case .leaveHistoryNever:
            return "저장하지 않음"
        }
    }
}
