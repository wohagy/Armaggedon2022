//
//  AsteroidsViewController.swift
//  Armaggedon 2022
//
//  Created by Macbook on 27.04.2022.
//

import UIKit

protocol AsteroidsViewProtocol: AnyObject {
    var tableView: UITableView { get }
    var asteroids: [Asteroid] { get set }
    
    func showTableView()
    func tableViewAddIndicator(for isNeedIndicator: Bool)
}

final class AsteroidsViewController: UIViewController, AsteroidsViewProtocol {
    
    private lazy var loadIndicator = getActivityIndicator()
    
    let tableView = UITableView(frame: .zero)
    
    var asteroids = [Asteroid]()
    
    var presenter: AsteroidsPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupTableView()
        setupConstraint()
        title = "Asteroids"
        view.backgroundColor = .white
    }
    
    func showTableView() {
        loadIndicator.isHidden = true
        tableView.isHidden = false
    }
    
    func tableViewAddIndicator(for isNeedIndicator: Bool) {
        tableView.tableFooterView = isNeedIndicator ? getActivityIndicator() : nil
    }
    
    private func getActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }
}

// MARK: - setupTableView(), UITableViewDataSource & UITableViewDelegate

extension AsteroidsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setupTableView() {
        tableView.register(AsteroidsTableViewCell.self, forCellReuseIdentifier: AsteroidsTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AsteroidsTableViewCell.identifier,
                                                 for: indexPath)
        guard let asteroidCell = cell as? AsteroidsTableViewCell else { return cell }
        
        asteroidCell.configure(model: asteroids[indexPath.row], cellDelegate: self)
        
        return asteroidCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UIScrollViewDelegate

extension AsteroidsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > tableView.contentSize.height - 100 - scrollView.frame.size.height {
            presenter?.loadMoreAsteroids()
        }
    }
}

// MARK: - UIScrollViewDelegate

extension AsteroidsViewController: AsteroidsTableViewCellDelegate {
    
    func destructButtonTaped(model: Asteroid) {
        presenter?.saveDestructAsteroid(model)
    }
}

// MARK: - Constraints

extension AsteroidsViewController {
    
    private func setupConstraint() {
        view.addSubview(loadIndicator)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            loadIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
