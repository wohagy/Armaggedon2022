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
}

final class CoreDataService: CoreDataServiceProtocol {
    
    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack
    }
    
    private let coreDataStack: CoreDataStackProtocol
    
    var viewContext: NSManagedObjectContext {
        return coreDataStack.container.viewContext
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
