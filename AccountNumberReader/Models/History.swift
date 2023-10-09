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
    
    init (id: UUID, title: String, content: String, image: UIImage, createdAt: Date, isPinned: Bool) {
        self.id = id
        self.title = title
        self.content = content
        self.image = image
        self.createdAt = createdAt
        self.isPinned = isPinned
    }
    
    init(from historyMO: HistoryMO) {
        self.id = historyMO.id!
        self.title = historyMO.title!
        self.content = historyMO.content!
        self.image = UIImage(data: historyMO.image!)!
        self.createdAt = historyMO.createdAt!
        self.isPinned = historyMO.isPinned
    }
    
    func save(completion: @escaping () -> Void) {
        print("히스토리 저장 중...\(self)")
        HistoryManager.shared.addHistory(self, completion: completion)
    }
}
