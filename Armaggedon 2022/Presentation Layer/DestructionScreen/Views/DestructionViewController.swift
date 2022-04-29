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
    
    private let brussButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Уничтожить", for: .normal)
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 12.0, bottom: 5.0, right: 12.0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
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
        fetchedResultsController?.delegate = fetchedResultsControllerDelegate
        brussButton.addTarget(self, action: #selector(destructAsteroids), for: .touchUpInside)
    }
    
    @objc private func destructAsteroids() {
        presenter?.deleteAsteroidsFromDB()
    }
}

// MARK: - setupTableView(), UITableViewDataSource & UITableViewDelegate

extension DestructionViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.register(DestructAsteroidCell.self, forCellReuseIdentifier: DestructAsteroidCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
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
        guard let asteroidCell = cell as? DestructAsteroidCell,
              let dbAsteroid = fetchedResultsController?.object(at: indexPath),
              let asteroid = Asteroid(dbAsteroid: dbAsteroid)else { return cell }
        
        asteroidCell.configure(model: asteroid)
        
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
        view.addSubview(brussButton)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            brussButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            brussButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
