//
//  Asteroid.swift
//  Armaggedon 2022
//
//  Created by Macbook on 28.04.2022.
//

import Foundation

struct Asteroid {
    let name: String
    let approachDate: String
    let diameter: Double
    let kmDistance: Double
    let lunarDistance: Double
    let isDanger: Bool
    
    init(name: String,
         approachDate: String,
         diameter: Double,
         kmDistance: Double,
         lunarDistance: Double,
         isDanger: Bool) {
        
        self.name = name
        self.approachDate = approachDate
        self.diameter = diameter
        self.kmDistance = kmDistance
        self.lunarDistance = lunarDistance
        self.isDanger = isDanger
    }
    
    init?(dbAsteroid: DBAsteroid) {
        guard let name = dbAsteroid.name,
              let approachDate = dbAsteroid.approachDate else { return nil }
        
        self.name = name
        self.approachDate = approachDate
        self.diameter = dbAsteroid.diameter
        self.kmDistance = dbAsteroid.kmDistance
        self.lunarDistance = dbAsteroid.lunarDistance
        self.isDanger = dbAsteroid.isDanger
    }
}
