import Foundation

enum SettingElement {
    case copyScope(CopyScope?)
    case includeHyphen(IncludeHyphen?)
    case leaveHistory(LeaveHistory?)
    
    var keyName: String {
        get {
            switch self {
            case .copyScope:
                return "copyScope"
            case .includeHyphen:
                return "includeHyphen"
            case .leaveHistory:
                return "leaveHistory"
            }
        }
    }
    
    var options: [String] {
        get {
            switch self {
            case .copyScope:
                return [CopyScope.onlyAccountNumber.rawValue, CopyScope.includeBankName.rawValue, CopyScope.includeName.rawValue]
            case .includeHyphen:
                return [IncludeHyphen.on.rawValue, IncludeHyphen.off.rawValue]
            case .leaveHistory:
                return [LeaveHistory.every.rawValue, LeaveHistory.ask.rawValue, LeaveHistory.never.rawValue]
            }
        }
    }
}

enum CopyScope: String {
    case onlyAccountNumber
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
