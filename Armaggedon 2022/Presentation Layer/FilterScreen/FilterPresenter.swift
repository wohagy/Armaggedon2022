//
//  FilterPresenter.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation

protocol FilterPresenterProtocol: AnyObject {
    init(view: FilterViewProtocol,
         router: RouterProtocol)
    
    func viewDidLoad()
}

final class FilterPresenter: FilterPresenterProtocol {
    
    init(view: FilterViewProtocol,
         router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    private weak var view: FilterViewProtocol?
    private var router: RouterProtocol
    
    func viewDidLoad() {
    }
}
