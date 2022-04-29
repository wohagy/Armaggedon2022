//
//  FilterViewController.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import UIKit

protocol FilterViewProtocol: AnyObject {
    var filterSettings: FilterSettings? { get set }
}

final class FilterViewController: UIViewController, FilterViewProtocol {
    
    enum CellType: Int, CaseIterable {
        case unitFilterCell
        case dangerFilterCell
    }

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var presenter: FilterPresenterProtocol?
    
    var filterSettings: FilterSettings?

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
        tableView.register(UnitFilterTableViewCell.self, forCellReuseIdentifier: UnitFilterTableViewCell.identifier)
        tableView.register(DangerFilterTableViewCell.self, forCellReuseIdentifier: DangerFilterTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: UnitFilterTableViewCell.identifier, for: indexPath)
        guard let cellType = CellType(rawValue: indexPath.row),
              let settings = filterSettings else { return defaultCell }
        
        switch cellType {
        
        case .unitFilterCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: UnitFilterTableViewCell.identifier, for: indexPath)
            guard let unitFilterCell = cell as? UnitFilterTableViewCell else { return cell }
            unitFilterCell.configure(filterSettings: settings, delegate: self)
            return unitFilterCell
            
        case .dangerFilterCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: DangerFilterTableViewCell.identifier, for: indexPath)
            guard let dangerFilterCell = cell as? DangerFilterTableViewCell else { return cell }
            dangerFilterCell.configure(filterSettings: settings, delegate: self)
            return dangerFilterCell
        }
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
        guard let settings = filterSettings else { return }
        presenter?.changeSettings(settings: settings)
    }
}

// MARK: - FilterDelegate

extension FilterViewController: FilterDelegate {
    
    func changeFilterSettings(with settings: FilterSettings) {
        filterSettings = settings
        tableView.reloadData()
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
