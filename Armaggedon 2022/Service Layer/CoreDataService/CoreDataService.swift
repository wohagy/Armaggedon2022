//
//  CoreDataService.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol: AnyObject {
    
    init(coreDataStack: CoreDataStackProtocol)

    var viewContext: NSManagedObjectContext { get }
    
    func performSaveOnViewContext(_ block: @escaping (NSManagedObjectContext) -> Void)
    func fetchAsteroid(asteroidName: String) -> DBAsteroid?
    func fetchAsteroids() -> [DBAsteroid]?
}

final class CoreDataService: CoreDataServiceProtocol {
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
    }
    
    private let coreDataStack: CoreDataStackProtocol
    
    var viewContext: NSManagedObjectContext {
        return coreDataStack.container.viewContext
    }
    
    func fetchAsteroids() -> [DBAsteroid]? {
        let fetchRequest: NSFetchRequest<DBAsteroid> = DBAsteroid.fetchRequest()
        return try? viewContext.fetch(fetchRequest)
    }
    
    func fetchAsteroid(asteroidName: String) -> DBAsteroid? {
        let fetchRequest: NSFetchRequest<DBAsteroid> = DBAsteroid.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = '\(asteroidName)'")
        return try? viewContext.fetch(fetchRequest).first
    }
    
    func performSaveOnViewContext(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let context = viewContext
        context.mergePolicy = NSMergePolicy(merge: .overwriteMergePolicyType)
        context.perform {
            block(context)
            if context.hasChanges {
                do {
                    try self.coreDataStack.performSave(in: context)
                } catch {
                    assertionFailure(error.localizedDescription)
                }
            }
        }
    }
    
}
