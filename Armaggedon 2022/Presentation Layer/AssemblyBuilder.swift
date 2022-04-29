//
//  AssemblyBuilder.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createAsteroidsModule(router: RouterProtocol) -> UIViewController
    func createDestructionModule(router: RouterProtocol) -> UIViewController
    func createFilterModule(router: RouterProtocol) -> UIViewController
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    private var coreDataService: CoreDataServiceProtocol = CoreDataService(coreDataStack: CoreDataStack())
    
    func createAsteroidsModule(router: RouterProtocol) -> UIViewController {
        let view = AsteroidsViewController()
        let networkService = NetworkService()
        let presenter = AsteroidsPresenter(view: view, networkService: networkService, coreDataService: coreDataService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createDestructionModule(router: RouterProtocol) -> UIViewController {
        let view = DestructionViewController()
        let presenter = DestructionPresenter(view: view, coreDataService: coreDataService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createFilterModule(router: RouterProtocol) -> UIViewController {
        let view = FilterViewController()
        let presenter = FilterPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
}
