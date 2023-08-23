import Foundation

enum SettingsKeys: String {
    case copyScope
    case includeHyphen
    case leaveHistory
}

enum CopyScope: String {
    case onlyAccountNumber
    case includeBankName
    case includeName
}

enum IncludeHyphen: String{
    case on
    case off
}

enum LeaveHistory: String {
    case every
    case ask
    case never
}
