import Foundation

enum SettingElement {
    case copyScope(CopyScope?)
    case leaveHistory(LeaveHistory?)
    
    var keyName: String {
        get {
            switch self {
            case .copyScope:
                return "copyScope"
            case .leaveHistory:
                return "leaveHistory"
            }
        }
    }
    
    var options: [String] {
        get {
            switch self {
            case .copyScope:
                return [CopyScope.onlyAccountNumber.rawValue, CopyScope.includeBankName.rawValue]
            case .leaveHistory:
                return [LeaveHistory.every.rawValue, LeaveHistory.ask.rawValue, LeaveHistory.never.rawValue]
            }
        }
    }
}

enum CopyScope: String {
    case onlyAccountNumber
    case includeBankName
}

enum LeaveHistory: String {
    case every
    case ask
    case never
}
