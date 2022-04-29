//
//  UnitFilterTableViewCell.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import UIKit

protocol UnitFilterCellDelegate: AnyObject {
    func changeUnitMetrics(units: UnitMetrics)
}

final class UnitFilterTableViewCell: UITableViewCell {

    static let identifier = "UnitFilterTableViewCell"
    
    private weak var delegate: FilterDelegate?
    
    private var filterSettings: FilterSettings?

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ед. изм. расстояний"
        return label
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.insertSegment(withTitle: UnitMetrics.kilometers.rawValue, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: UnitMetrics.lunar.rawValue, at: 1, animated: false)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        return segmentedControl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(filterSettings: FilterSettings, delegate: FilterDelegate) {
        self.delegate = delegate
        self.filterSettings = filterSettings
        
        switch filterSettings.unitMetrics {
        case .kilometers:
            self.segmentedControl.selectedSegmentIndex = 0
        case .lunar:
            self.segmentedControl.selectedSegmentIndex = 1
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func addSubviews() {
        contentView.addSubview(label)
        contentView.addSubview(segmentedControl)
    }
    
    @objc private func segmentedControlValueChanged(sender: UISegmentedControl) {
        guard var settings = filterSettings else { return }
        
        if sender.selectedSegmentIndex == 0 {
            settings.unitMetrics = .kilometers
        } else if sender.selectedSegmentIndex == 1 {
            settings.unitMetrics  = .lunar
        }

        delegate?.changeFilterSettings(with: settings)
    }
}

// MARK: - Constraints

extension UnitFilterTableViewCell {
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            segmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            segmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            segmentedControl.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 10),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)

        ])
    }
}
