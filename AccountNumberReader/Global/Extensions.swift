//
//  extensions.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/08/31.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: self)
    }
}
