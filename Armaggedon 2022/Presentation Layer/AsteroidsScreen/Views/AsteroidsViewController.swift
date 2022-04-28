//
//  AsteroidsViewController.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit

protocol AsteroidsViewProtocol: AnyObject {
}

final class AsteroidsViewController: UIViewController, AsteroidsViewProtocol {
    
    private let tableView = UITableView(frame: .zero)
    
    var presenter: AsteroidsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupConstraint()
        title = "Asteroids"
        view.backgroundColor = .white
    }
}

// MARK: - setupTableView(), UITableViewDataSource & UITableViewDelegate

extension AsteroidsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.register(AsteroidsTableViewCell.self, forCellReuseIdentifier: AsteroidsTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AsteroidsTableViewCell.identifier,
                                                 for: indexPath)
        guard let asteroidCell = cell as? AsteroidsTableViewCell else { return cell }
        
        asteroidCell.configure()
        
        return asteroidCell
    }
}

// MARK: - Constraints

extension AsteroidsViewController {
    
    private func setupConstraint() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
