//
//  AsteroidsParser.swift
//  Armaggedon 2022
//
//  Created by Macbook on 29.04.2022.
//

import Foundation

final class AsteroidsParser: ParserProtocol {
    
    typealias Model = [Asteroid]
    
    func parse(data: Data) -> [Asteroid]? {
        var asteroids = [Asteroid]()
        do {
            let result = try JSONDecoder().decode(AsteroidsAPIModel.self, from: data)
            
            for day in result.nearEarthObjects {
                let nearEarthObjects = day.value
                for asteroid in nearEarthObjects {
                    
                    var name: String
                    var approachDate: String
                    var diametr: Double
                    var kmDistance: String
                    var lunarDistance: String
                    var isDanger: Bool
                    
                    name = asteroid.name
                    
                    isDanger = asteroid.isPotentiallyHazardousAsteroid
                    
                    let diameterMax = asteroid.estimatedDiameter.kilometers.estimatedDiameterMax
                    let diameterMin = asteroid.estimatedDiameter.kilometers.estimatedDiameterMin
                    diametr = (diameterMax + diameterMin) / 2
                    
                    approachDate = asteroid.closeApproachData.first?.closeApproachDate ?? "Неизвестно"
                    kmDistance = asteroid.closeApproachData.first?.missDistance.kilometers ?? "Неизвестно"
                    lunarDistance = asteroid.closeApproachData.first?.missDistance.lunar ?? "Неизвестно"
                    
                    let asteroidModel = Asteroid(name: name,
                                                 approachDate: approachDate,
                                                 diameter: diametr,
                                                 kmDistance: kmDistance,
                                                 lunarDistance: lunarDistance,
                                                 isDanger: isDanger)
                    
                    asteroids.append(asteroidModel)
                }
            }
            return asteroids
        } catch {
            return nil
        }
    }
}
