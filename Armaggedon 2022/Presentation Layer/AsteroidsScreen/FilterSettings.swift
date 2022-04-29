//
//  FilterSettings.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation

struct FilterSettings {
    var unitMetrics: UnitMetrics
    var showOnlyDangerous: Bool
}

enum UnitMetrics: String, CaseIterable {
    case kilometers = "км"
    case lunar = "л.орб."
}
