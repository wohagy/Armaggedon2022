//
//  DangerFilterTableViewCell.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import UIKit

final class DangerFilterTableViewCell: UITableViewCell {

    static let identifier = "DangerFilterTableViewCell"

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Показывать только опасные"
        return label
    }()
    
    private let filterSwitch: UISwitch = {
        let filterSwitch = UISwitch()
        filterSwitch.translatesAutoresizingMaskIntoConstraints = false
        return filterSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        label.textColor = .red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func addSubviews() {
        contentView.addSubview(label)
        contentView.addSubview(filterSwitch)
    }
}

// MARK: - Constraints

extension DangerFilterTableViewCell {
    private func setupConstraint() {
        
        NSLayoutConstraint.activate([
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            filterSwitch.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            filterSwitch.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            filterSwitch.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 10),
            filterSwitch.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
