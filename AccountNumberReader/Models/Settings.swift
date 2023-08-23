import Foundation

struct AppSetting {
    var settingKey: SettingKey
    var settingValues: [String]
}

enum SettingKey: String {
    case copyScope
    case includeHyphen
    case leaveHistory
}

enum CopyScope: String {
    case onlyAccountNumber // 0
    case includeBankName
    case includeName
}

enum IncludeHyphen: String {
    case on
    case off
}

enum LeaveHistory: String {
    case every
    case ask
    case never
}
