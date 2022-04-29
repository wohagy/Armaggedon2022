//
//  DestructionViewController.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit
import CoreData

protocol DestructionViewProtocol: AnyObject {
    var fetchedResultsController: NSFetchedResultsController<DBAsteroid>? { get set }
}

class DestructionViewController: UIViewController, DestructionViewProtocol {
    
    let tableView = UITableView(frame: .zero)
    
    var presenter: DestructionPresenterProtocol?
    var fetchedResultsController: NSFetchedResultsController<DBAsteroid>?
    var fetchedResultsControllerDelegate: NSFetchedResultsControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupTableView()
        setupConstraint()
        title = "Destruction"
        view.backgroundColor = .white
        fetchedResultsControllerDelegate = BaseFetchedResultsControllerDelegate(tableView: tableView)
    }
}

// MARK: - setupTableView(), UITableViewDataSource & UITableViewDelegate

extension DestructionViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.register(DestructAsteroidCell.self, forCellReuseIdentifier: DestructAsteroidCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections,
              let number = sections[safeIndex: section]?.numberOfObjects else {
            return 0
        }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DestructAsteroidCell.identifier,
                                                 for: indexPath)
        guard let asteroidCell = cell as? DestructAsteroidCell else { return cell }
        
        let dbAsteroid = fetchedResultsController?.object(at: indexPath)
        
        print(dbAsteroid?.name)
        
        return asteroidCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Constraints

extension DestructionViewController {
    
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
