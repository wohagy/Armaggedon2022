//
//  FilterDelegate.swift
//  Armaggedon 2022
//
//  Created by Macbook on 30.04.2022.
//

import Foundation

protocol FilterDelegate: AnyObject {
    func changeFilterSettings(with settings: FilterSettings)
}
