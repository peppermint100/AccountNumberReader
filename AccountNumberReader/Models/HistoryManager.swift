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
    
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    func getHistories() {
    }
}
