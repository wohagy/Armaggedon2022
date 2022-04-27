//
//  DestructionPresenter.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import Foundation

protocol DestructionPresenterProtocol: AnyObject {
    init(view: DestructionViewProtocol,
         router: RouterProtocol)
}

final class DestructionPresenter: DestructionPresenterProtocol {
    
    init(view: DestructionViewProtocol,
         router: RouterProtocol) {
        self.view = view
        self.router = router
    }
    
    private weak var view: DestructionViewProtocol?
    private var router: RouterProtocol
}
