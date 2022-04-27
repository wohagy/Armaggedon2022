//
//  DestructionViewController.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit

protocol DestructionViewProtocol: AnyObject {
}

class DestructionViewController: UIViewController, DestructionViewProtocol {
    
    var presenter: DestructionPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Destruction"
        view.backgroundColor = .brown
    }
}
