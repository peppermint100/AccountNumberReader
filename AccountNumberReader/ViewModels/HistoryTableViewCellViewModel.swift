//
//  HistoryTableViewCellViewModel.swift
//  AccountNumberReader
//
//  Created by peppermint100 on 2023/09/19.
//

import UIKit

class HistoryTableViewCellViewModel {
    var id: UUID
    var title: Observable<String>
    var content: Observable<String>
    var image: UIImage
    var createdAt: Date
    var isPinned: Observable<Bool>
    
    init(id: UUID, title: Observable<String>, content: Observable<String>, image: UIImage, createdAt: Date, isPinned: Observable<Bool>) {
        self.id = id
        self.title = title
        self.content = content
        self.image = image
        self.createdAt = createdAt
        self.isPinned = isPinned
    }
}
