//
//  DestructAsteroidCell.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import UIKit

final class DestructAsteroidCell: UITableViewCell {

    static let identifier = "DestructAsteroidCell"
    
    private let shadowView = ShadowView()
    
    private let cellView = UIView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let gradeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(shadowView)
        addSubviews()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Asteroid) {
        nameLabel.text = model.name
        gradeLabel.text = "Оценка: \(model.isDanger ? "опасен" : "не опасен")"
        gradeLabel.textColor = model.isDanger ? .red : .label
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        gradeLabel.text = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(shadowView)
        shadowView.addSubview(cellView)
        cellView.addSubview(nameLabel)
        cellView.addSubview(gradeLabel)
    }
}

// MARK: - Constraints

extension DestructAsteroidCell {
    private func setupConstraint() {
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        cellView.translatesAutoresizingMaskIntoConstraints = false
        gradeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            
            cellView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            cellView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            
            gradeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            gradeLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 10),
            gradeLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -10),
            gradeLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10)
        ])
    }
}
