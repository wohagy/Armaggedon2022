//
//  FilterViewController.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import UIKit

protocol FilterViewProtocol: AnyObject {
    
}

class FilterViewController: UIViewController, FilterViewProtocol {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var presenter: FilterPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupTableView()
        setupConstraint()
        customizeNavBar()
        title = "Фильтр"
        view.backgroundColor = .white
    }
}

// MARK: - setupTableView(), UITableViewDataSource & UITableViewDelegate

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.register(DestructAsteroidCell.self, forCellReuseIdentifier: DestructAsteroidCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DestructAsteroidCell.identifier,
                                                 for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - NavBar Customizing, + NavBar buttons actions

extension FilterViewController {
    
    private func customizeNavBar() {
        let filterButton = UIBarButtonItem(title: "Применить", style: .done, target: self, action: #selector(applyFilter))
        
        self.navigationItem.rightBarButtonItems = [filterButton]
    }
    
    @objc private func applyFilter() {
        
    }
}

// MARK: - Constraints

extension FilterViewController {
    
    private func setupConstraint() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
