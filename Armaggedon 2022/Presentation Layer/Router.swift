//
//  Router.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit

protocol ItemRouter {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: ItemRouter {
    func asteroidsInitialViewController()
    func destructionInitialViewController()
}

final class Router: RouterProtocol {
    
    var navigationController: UINavigationController?
    
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func asteroidsInitialViewController() {
        if let navigationController = navigationController {
            guard let asteroidsViewController = assemblyBuilder?.createAsteroidsModule(router: self) else { return }
            navigationController.title = "Asteroids"
            navigationController.viewControllers = [asteroidsViewController]
        }
    }
    
    func destructionInitialViewController() {
        if let navigationController = navigationController {
            guard let destructionViewController = assemblyBuilder?.createDestructionModule(router: self) else { return }
            navigationController.title = "Destruction"
            navigationController.viewControllers = [destructionViewController]
        }
    }

}
