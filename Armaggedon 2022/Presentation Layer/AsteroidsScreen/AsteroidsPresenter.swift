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
         router: RouterProtocol)
    
    func viewDidLoad()
    func loadMoreAsteroids() 
}

final class AsteroidsPresenter: AsteroidsPresenterProtocol {
    
    init(view: AsteroidsViewProtocol,
         networkService: RequestSenderProtocol,
         router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    private weak var view: AsteroidsViewProtocol?
    private var networkService: RequestSenderProtocol?
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
}
