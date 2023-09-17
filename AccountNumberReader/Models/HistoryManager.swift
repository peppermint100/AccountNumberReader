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
        var result: [History] = []
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        let createdAtDesc = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [createdAtDesc]
        
        do {
            guard let histories = try context?.fetch(request) as? [HistoryMO] else {
                return result
            }
            result = histories.map({ (historyMO: HistoryMO) -> History in
                return History.init(from: historyMO)
            })
        } catch {
            print(error.localizedDescription)
            return result
        }
        
        return result
    }
    
    func addHistory(_ history: History, completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                if let historySaved = NSManagedObject(entity: entity, insertInto: context) as? HistoryMO {
                    historySaved.id = history.id
                    historySaved.title = history.title
                    historySaved.content = history.content
                    historySaved.createdAt = history.createdAt
                    historySaved.image = history.image.jpegData(compressionQuality: 1.0)
                    historySaved.isPinned = history.isPinned
                    
                    if (context.hasChanges) {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error.localizedDescription)
                            completion()
                        }
                    }
                }
            }
        }
    }
    
    func searchHistory(_ query: String) -> [History] {
        var result: [History] = []
        
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        let titleLike = NSPredicate(format: "title CONTAINS %@", query)
        let contentLike = NSPredicate(format: "content CONTAINS %@", query)
        let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [titleLike, contentLike])
        let createdAtDesc = NSSortDescriptor(key: "createdAt", ascending: false)
        
        request.predicate = predicate
        request.sortDescriptors = [createdAtDesc]
        
        do {
            guard let histories = try context?.fetch(request) as? [HistoryMO] else {
                return result
            }
            result = histories.map({ historyMO in
                return History.init(from: historyMO)
            })
        } catch {
            print(error.localizedDescription)
            return result
        }
        
        return result
    }
    
    func updateTitle(id: UUID, title: String) {
        print("HistoryManager updateTitle 호출")
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        let equalId = NSPredicate(format: "id == %@", id as CVarArg)
        
        request.predicate = equalId
        
        if let context {
            do {
                let history = try context.fetch(request) as? [HistoryMO]
                print("history = ", history)
                history?.first?.title = title
                if (context.hasChanges) {
                    print("history context hasChanges")
                    try context.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateContent(id: UUID, content: String) {
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        let equalId = NSPredicate(format: "id == %@", id.uuidString)
        
        request.predicate = equalId
        
        if let context {
            do {
                let history = try context.fetch(request) as? [HistoryMO]
                history?.first?.content = content
                if (context.hasChanges) {
                    try context.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getHistoryById(id: UUID) -> HistoryMO? {
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        let equalId = NSPredicate(format: "id == %@", id.uuidString)
        
        request.predicate = equalId
        
        do {
            guard let history = try context?.fetch(request) as? HistoryMO else {
                return nil
            }
            return history
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    func deleteHistory(id: UUID, completion: @escaping () -> Void) {
        let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
        let equalId = NSPredicate(format: "id == %@", id.uuidString)
        
        request.predicate = equalId
        
        if let context {
            do {
                guard let histories = try context.fetch(request) as? [HistoryMO] else {
                    return
                }
                if !histories.isEmpty {
                    let history = histories.first!
                    context.delete(history)
                }
                if context.hasChanges {
                    try context.save()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        completion()
    }
}
