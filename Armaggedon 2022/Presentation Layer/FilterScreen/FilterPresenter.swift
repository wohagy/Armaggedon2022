//
//  FilterPresenter.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation

protocol FilterPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func changeSettings(settings: FilterSettings)
}

final class FilterPresenter: FilterPresenterProtocol {
    
    init(view: FilterViewProtocol,
         filterSettings: FilterSettings,
         filterSettingsDelegate: FilterDelegate,
         router: RouterProtocol) {
        self.view = view
        self.filterSettings = filterSettings
        self.filterSettingsDelegate = filterSettingsDelegate
        self.router = router
    }
    
    private weak var view: FilterViewProtocol?
    private let filterSettings: FilterSettings
    private var filterSettingsDelegate: FilterDelegate?
    private let router: RouterProtocol
    
    func viewDidLoad() {
        self.view?.filterSettings = filterSettings
    }
    
    func changeSettings(settings: FilterSettings) {
        filterSettingsDelegate?.changeFilterSettings(with: settings)
    }
}
