//
//  AppDelegate.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarVC = createTabBarController()
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
        return true
    }
    
    func createTabBarController() -> UITabBarController {
        let asteroidsNavigation = UINavigationController()
        let destructionNavigation = UINavigationController()
        let assemblyBuilder = AssemblyBuilder()
        let asteroidRouter = Router(navigationController: asteroidsNavigation, assemblyBuilder: assemblyBuilder)
        let destructionRouter = Router(navigationController: destructionNavigation, assemblyBuilder: assemblyBuilder)
        asteroidRouter.asteroidsInitialViewController()
        destructionRouter.destructionInitialViewController()
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([asteroidsNavigation, destructionNavigation], animated: false)
        
        if let items = tabBarVC.tabBar.items {
            let images = ["globe", "trash"]
            for item in 0..<items.count {
                items[item].image = UIImage(systemName: images[item])
            }
        }
        
        return tabBarVC
    }
    
}
