import Foundation

struct AppSetting {
    var settingKey: SettingKey
    var settingValues: [SettingValue]
}

enum SettingKey: String {
    case copyScope
    case includeHyphen
    case leaveHistory
}

enum SettingValue: String {
    case copyScopeOnlyAccountNumber
    case copyScopeIncludeBankName
    case copyScopeIncludeName
    case includeHyphenOn
    case includeHyphenOff
    case leaveHistoryEvery
    case leaveHistoryAsk
    case leaveHistoryNever
}
