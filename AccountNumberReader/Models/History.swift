//
//  History.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/08/31.
//

import UIKit

struct History {
    var id: UUID
    var title: String
    var content: String
    var image: UIImage
    var createdAt: Date
    var isPinned: Bool
//    @NSManaged public var id: UUID?
//    @NSManaged public var title: String?
//    @NSManaged public var content: String?
//    @NSManaged public var image: Data?
//    @NSManaged public var createdAt: Date?
//    @NSManaged public var isPinned: Bool
    
    init(from historyMO: HistoryMO) {
        self.id = historyMO.id!
        self.title = historyMO.title!
        self.content = historyMO.content!
        self.image = UIImage(data: historyMO.image!)!
        self.createdAt = historyMO.createdAt!
        self.isPinned = historyMO.isPinned
    }
}
