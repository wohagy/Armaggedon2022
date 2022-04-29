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
}

final class AssemblyBuilder: AssemblyBuilderProtocol {
    
    func createAsteroidsModule(router: RouterProtocol) -> UIViewController {
        let view = AsteroidsViewController()
        let networkService = NetworkService()
        let presenter = AsteroidsPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        
        return view
    }
    
    func createDestructionModule(router: RouterProtocol) -> UIViewController {
        let view = DestructionViewController()
        let presenter = DestructionPresenter(view: view, router: router)
        view.presenter = presenter
        
        return view
    }
}
