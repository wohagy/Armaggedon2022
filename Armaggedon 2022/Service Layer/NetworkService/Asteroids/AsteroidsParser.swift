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
                    
                    name = textFromParentheses(asteroid.name) ?? "Неизвестно"
                    
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

    private func textFromParentheses(_ text: String) -> String? {
        
        do {
            let pattern = "\\((.*?)\\)"
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let nsString = text as NSString
            let range = nsString.range(of: text)
            let results = regex.matches(in: text, options: [], range: range)
            
            guard let result = results.first else { return nil }
            
            var resultString = nsString.substring(with: result.range)
            resultString.removeFirst()
            resultString.removeLast()
            
            return resultString
            
        } catch let error as NSError {
            
            print("invalid regex: \(error.localizedDescription)")
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
