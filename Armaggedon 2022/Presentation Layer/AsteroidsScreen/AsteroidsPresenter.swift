//
//  AsteroidsPresenter.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit

protocol AsteroidsPresenterProtocol: AnyObject {
    init(view: AsteroidsViewProtocol,
         router: RouterProtocol)
}

final class AsteroidsPresenter: AsteroidsPresenterProtocol {
    
    init(view: AsteroidsViewProtocol,
         router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    private weak var view: AsteroidsViewProtocol?
    private var router: RouterProtocol
}
