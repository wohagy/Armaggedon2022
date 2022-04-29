//
//  AsteroidsPresenter.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit

protocol AsteroidsPresenterProtocol: AnyObject {
    init(view: AsteroidsViewProtocol,
         networkService: RequestSenderProtocol,
         coreDataService: CoreDataServiceProtocol,
         router: RouterProtocol)
    
    func viewDidLoad()
    func loadMoreAsteroids()
    func saveDestructAsteroid(_ asteroid: Asteroid)
    func presentFilterScreen()
}

final class AsteroidsPresenter: AsteroidsPresenterProtocol {
    
    init(view: AsteroidsViewProtocol,
         networkService: RequestSenderProtocol,
         coreDataService: CoreDataServiceProtocol,
         router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.coreDataService = coreDataService
        self.router = router
    }
    
    private weak var view: AsteroidsViewProtocol?
    private var networkService: RequestSenderProtocol?
    private var coreDataService: CoreDataServiceProtocol?
    private var router: RouterProtocol
    
    private var isLoadInProgress = false
    private var requestStartDay = Date()
    
    func viewDidLoad() {
        loadAsteroids { [weak self] in
            self?.view?.showTableView()
        }
    }
    
    func loadMoreAsteroids() {
        self.view?.tableViewAddIndicator(for: true)
        loadAsteroids { [weak self] in
            self?.view?.tableViewAddIndicator(for: false)
        }
    }
    
    private func loadAsteroids(completionHandler: (() -> Void)? = nil) {
        
        guard !isLoadInProgress else { return }
        
        isLoadInProgress = true
        
        guard let endDay = Calendar.current.date(byAdding: .day, value: 1, to: requestStartDay) else { return }
        
        let requestConfig = RequestsFactory.AsteroidsConfig.asteroidsConfig(startDay: requestStartDay, endDay: endDay)
        
        requestStartDay = endDay
        
        networkService?.send(requestConfig: requestConfig) { result in
            switch result {
            case .success(let asteroids):
                DispatchQueue.main.async {
                    self.view?.asteroids.append(contentsOf: asteroids)
                    self.view?.tableView.reloadData()
                    if let completion = completionHandler {
                        completion()
                    }
                    self.isLoadInProgress = false
                }
            case .failure(let error):
                Logger.shared.message(error.localizedDescription)
            }
        }
    }
    
    func saveDestructAsteroid(_ asteroid: Asteroid) {
        let isContains = coreDataService?.fetchAsteroid(asteroidName: asteroid.name)
        
        guard isContains == nil else { return }
        
        coreDataService?.performSaveOnViewContext { context in
            let dbAsteroid = DBAsteroid(context: context)
            dbAsteroid.name = asteroid.name
            dbAsteroid.approachDate = asteroid.approachDate
            dbAsteroid.diameter = asteroid.diameter
            dbAsteroid.isDanger = asteroid.isDanger
            dbAsteroid.kmDistance = asteroid.kmDistance
            dbAsteroid.lunarDistance = asteroid.lunarDistance
        }
    }
    
    func presentFilterScreen() {
        router.presentFilterViewController()
    }

}
