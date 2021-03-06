//
//  DestructionPresenter.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import Foundation
import CoreData

protocol DestructionPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func deleteAsteroidsFromDB()
}

final class DestructionPresenter: DestructionPresenterProtocol {
    
    init(view: DestructionViewProtocol,
         coreDataService: CoreDataServiceProtocol,
         router: RouterProtocol) {
        self.view = view
        self.coreDataService = coreDataService
        self.router = router
    }
    
    private weak var view: DestructionViewProtocol?
    private let coreDataService: CoreDataServiceProtocol
    private let router: RouterProtocol
    
    private func getFetchedResultsController() -> NSFetchedResultsController<DBAsteroid>? {
        let context = coreDataService.viewContext
        let fetchRequest: NSFetchRequest<DBAsteroid> = DBAsteroid.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(DBAsteroid.diameter), ascending: false)]
        fetchRequest.fetchBatchSize = 10
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        
        do {
            try controller.performFetch()
        } catch {
            Logger.shared.message(error.localizedDescription)
        }

        return controller
    }
    
    func viewDidLoad() {
        self.view?.fetchedResultsController = getFetchedResultsController()
    }
    
    func deleteAsteroidsFromDB() {
        guard let dbAsteroids = coreDataService.fetchAsteroids() else { return }
        coreDataService.performSaveOnViewContext { context in
            for dbAsteroid in dbAsteroids {
                context.delete(dbAsteroid)
            }
        }
    }

}
