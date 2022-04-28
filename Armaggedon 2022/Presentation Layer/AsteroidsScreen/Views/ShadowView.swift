//
//  ShadowView.swift
//  Armaggedon 2022
//
//  Created by Macbook on 28.04.2022.
//

import UIKit

final class ShadowView: UIView {

    private var shadowLayer: CAShapeLayer!

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor

            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = .zero
            shadowLayer.shadowOpacity = 0.7
            shadowLayer.shadowRadius = 7

            layer.insertSublayer(shadowLayer, at: 0)
        }
    }

}
