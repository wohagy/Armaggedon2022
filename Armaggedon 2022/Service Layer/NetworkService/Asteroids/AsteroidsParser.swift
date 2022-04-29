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
                    var diameter: Double
                    var kmDistance: Double
                    var lunarDistance: Double
                    var isDanger: Bool
                    
                    name = asteroid.name
                    
                    isDanger = asteroid.isPotentiallyHazardousAsteroid
                    
                    let diameterMax = asteroid.estimatedDiameter.kilometers.estimatedDiameterMax
                    let diameterMin = asteroid.estimatedDiameter.kilometers.estimatedDiameterMin
                    let unroundedDiameter = (diameterMax + diameterMin) / 2
                    diameter = round(unroundedDiameter * 100) / 100
                    
                    approachDate = asteroid.closeApproachData.first?.closeApproachDate ?? "Неизвестно"
                    kmDistance = stringToRoundDouble(asteroid.closeApproachData.first?.missDistance.kilometers)
                    lunarDistance = stringToRoundDouble(asteroid.closeApproachData.first?.missDistance.lunar)
                    
                    let asteroidModel = Asteroid(name: name,
                                                 approachDate: approachDate,
                                                 diameter: diameter,
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
    
    private func stringToRoundDouble(_ optionalString: String?) -> Double {
        guard let string = optionalString,
              let unroundDouble = Double(string) else { return 0 }
        let double = round(unroundDouble * 100) / 100
        return double
    }
}
