//
//  CoreDataStack.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    var container: NSPersistentContainer { get }
    func performSave(in context: NSManagedObjectContext) throws
}

final class CoreDataStack: CoreDataStackProtocol {
    
    var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
    
    func performSave(in context: NSManagedObjectContext) throws {
        try context.save()
        if let parent = context.parent {
            try performSave(in: parent)
        }
    }
    
}
