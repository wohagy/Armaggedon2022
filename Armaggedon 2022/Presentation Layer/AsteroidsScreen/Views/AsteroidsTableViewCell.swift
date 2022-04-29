//
//  AsteroidsTableViewCell.swift
//  Armaggedon 2022
//
//  Created by Macbook on 28.04.2022.
//

import UIKit

protocol AsteroidsTableViewCellDelegate: AnyObject {
    func destructButtonTaped(model: Asteroid)
}

final class AsteroidsTableViewCell: UITableViewCell {

    static let identifier = "AsteroidsTableViewCell"
    
    private weak var delegate: AsteroidsTableViewCellDelegate?
    private var asteroidModel: Asteroid?
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let shadowView = ShadowView()
    
    private let gradientView = UIView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    private let diameterLabel = UILabel()
    private let arrivesLabel = UILabel()
    private let distanceLabel = UILabel()
    private let gradeLabel = UILabel()
    
    private let dinoImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "dino"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let destructButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Уничтожить", for: .normal)
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 5.0, left: 12.0, bottom: 5.0, right: 12.0)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14
        button.startAnimatingPressActions()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(shadowView)
        addSubviews()
        setupConstraint()
        destructButton.addTarget(self, action: #selector(destructButtonTaped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Asteroid, settings: FilterSettings, cellDelegate: AsteroidsTableViewCellDelegate) {
        nameLabel.text = model.name
        
        diameterLabel.text = "Диаметр: \(model.diameter) км"
        
        switch settings.unitMetrics {
        case .kilometers:
            distanceLabel.text = "на расстояние \(model.kmDistance) \(settings.unitMetrics.rawValue)"
        case .lunar:
            distanceLabel.text = "на расстояние \(model.lunarDistance) \(settings.unitMetrics.rawValue)"
        }
        
        arrivesLabel.text = "Подлетает \(model.approachDate)"
        
        gradeLabel.text = "Оценка: \(model.isDanger ? "опасен" : "не опасен")"
        gradeLabel.textColor = model.isDanger ? .red : .label
        gradientView.backgroundColor = model.isDanger ? .red : .green
        
        asteroidModel = model
        delegate = cellDelegate
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        asteroidModel = nil
        delegate = nil
        destructButton.backgroundColor = .blue
    }
    
    private func addSubviews() {
        contentView.addSubview(shadowView)
        shadowView.addSubview(cellView)
        cellView.addSubview(gradientView)
        gradientView.addSubview(nameLabel)
        gradientView.addSubview(dinoImage)
        cellView.addSubview(diameterLabel)
        cellView.addSubview(arrivesLabel)
        cellView.addSubview(distanceLabel)
        cellView.addSubview(gradeLabel)
        cellView.addSubview(destructButton)
    }
    
    @objc private func destructButtonTaped() {
        guard let model = asteroidModel else { return }
        delegate?.destructButtonTaped(model: model)
    }
    
}

// MARK: - Constraints

extension AsteroidsTableViewCell {
    private func setupConstraint() {
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        diameterLabel.translatesAutoresizingMaskIntoConstraints = false
        arrivesLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        gradeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            cellView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            cellView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: gradientView.topAnchor, constant: 105),
            nameLabel.leadingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: 16),
            nameLabel.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: -8),
            
            dinoImage.bottomAnchor.constraint(equalTo: gradientView.bottomAnchor),
            dinoImage.trailingAnchor.constraint(equalTo: gradientView.trailingAnchor, constant: -12),
            dinoImage.heightAnchor.constraint(equalToConstant: 30),
            
            gradientView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor),
            gradientView.topAnchor.constraint(equalTo: cellView.topAnchor),
            gradientView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor),
            
            diameterLabel.topAnchor.constraint(equalTo: gradientView.bottomAnchor, constant: 16),
            diameterLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            diameterLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            
            arrivesLabel.topAnchor.constraint(equalTo: diameterLabel.bottomAnchor, constant: 8),
            arrivesLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            arrivesLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            
            distanceLabel.topAnchor.constraint(equalTo: arrivesLabel.bottomAnchor, constant: 8),
            distanceLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
            distanceLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            
            gradeLabel.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 16),
            gradeLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 16),
                                        gradeLabel.trailingAnchor.constraint(greaterThanOrEqualTo: destructButton.leadingAnchor, constant: -16),
            gradeLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -19),
            
            destructButton.topAnchor.constraint(equalTo: distanceLabel.bottomAnchor, constant: 16),
            destructButton.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -16),
            destructButton.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -19)
        ])
    }
}
