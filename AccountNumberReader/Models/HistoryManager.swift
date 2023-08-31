//
//  HistoryManager.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/08/29.
//

import UIKit
import CoreData

final class HistoryManager {
    
    static let shared = HistoryManager()
    let modelName: String = "History"
    
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    func getHistories() -> [History] {
        return []
    }
    
    func addHistory(_: History) {
    }
}
