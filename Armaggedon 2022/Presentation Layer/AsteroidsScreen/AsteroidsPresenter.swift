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
    
    func viewDidLoad() {
        loadAsteroids()
    }
    
    private func loadAsteroids() {
        let requestConfig = RequestsFactory.AsteroidsConfig.asteroidsConfig()
        networkService?.send(requestConfig: requestConfig) { result in
            switch result {
            case .success(let asteroids):
                DispatchQueue.main.async {
                    self.view?.asteroids = asteroids
                    self.view?.tableView.reloadData()
                    self.view?.showTableView()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
