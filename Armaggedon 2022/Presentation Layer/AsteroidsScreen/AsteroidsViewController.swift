//
//  AsteroidsViewController.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit

protocol AsteroidsViewProtocol: AnyObject {
}

class AsteroidsViewController: UIViewController, AsteroidsViewProtocol {
    
    var presenter: AsteroidsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Asteroids"
        view.backgroundColor = .gray
    }
}
