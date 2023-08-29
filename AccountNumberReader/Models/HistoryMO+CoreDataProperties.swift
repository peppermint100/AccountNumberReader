//
//  HistoryMO+CoreDataProperties.swift
//  AccountNumberReader
//
//  Created by 이인규 on 2023/08/29.
//
//

import Foundation
import CoreData


extension HistoryMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryMO> {
        return NSFetchRequest<HistoryMO>(entityName: "History")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var image: Data?
    @NSManaged public var createdAt: Date?
    @NSManaged public var isPinned: Bool

}

extension HistoryMO : Identifiable {

}
