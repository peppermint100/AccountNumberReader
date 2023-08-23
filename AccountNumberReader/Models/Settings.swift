import Foundation

enum SettingsKeys {
    case copyScope(values: [CopyScope])
    case includeHyphen(values: [IncludeHyphen])
    case leaveHistory(values: [LeaveHistory])
    
    var keyString: String {
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
