//
//  ShadowView.swift
//  Armaggedon 2022
//
//  Created by Macbook on 28.04.2022.
//

import UIKit

final class ShadowView: UIView {

    private var shadowLayer: CAShapeLayer!
    
    private let shadowOpacity: Float
    private let shadowRadius: CGFloat
    
    init(shadowOpacity: Float, shadowRadius: CGFloat, frame: CGRect) {
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

}
