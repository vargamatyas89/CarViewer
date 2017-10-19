//
//  Car.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 14..
//  Copyright © 2017. MyOrg. All rights reserved.
//

//Example JSON data for a car
//"id": "WMWSW31030T222518",
//"modelIdentifier": "mini",
//"modelName": "MINI",
//"name": "Vanessa",
//"make": "BMW",
//"group": "MINI",
//"color": "midnight_black",
//"series": "MINI",
//"fuelType": "D",
//"fuelLevel": 0.7,
//"transmission": "M",
//"licensePlate": "M-VO0259",
//"latitude": 48.134557,
//"longitude": 11.576921,
//"innerCleanliness": "REGULAR",
//"carImageUrl": "https://de.drive-now.com/static/drivenow/img/cars/mini.png"

import Foundation
import CoreLocation

class Car {
    let id: String
    let modelIdentifier: String
    let modelName: String
    let name: String
    let make: String
    let group: String
    let color: String
    let series: String
    let fuelInformation: FuelInformation
    let transmission: String
    let licensePlate: String
    let position: CLLocationCoordinate2D
    let innerCleanliness: String
    let carImageUrl: URL?
    var carImageData: Data?
    
    public init(from dictionary: [String: Any]) throws {
        guard let id = dictionary["id"] as? String,
            let modelIdentifier = dictionary["modelIdentifier"] as? String,
            let modelName = dictionary["modelName"] as? String,
            let name = dictionary["name"] as? String,
            let make = dictionary["make"] as? String,
            let group = dictionary["group"] as? String,
            let color = dictionary["color"] as? String,
            let series = dictionary["series"] as? String,
            let fuelType = dictionary["fuelType"] as? String,
            let fuelLevel = dictionary["fuelLevel"] as? Float,
            let transmission = dictionary["transmission"] as? String,
            let licensePlate = dictionary["licensePlate"] as? String,
            let latitude = dictionary["latitude"] as? Double,
            let longitude = dictionary["longitude"] as? Double,
            let innerCleanliness = dictionary["innerCleanliness"] as? String else {
                throw TransformerError.transformingFailed
        }
        
        self.id = id
        self.modelIdentifier = modelIdentifier
        self.modelName = modelName
        self.name = name
        self.make = make
        self.group = group
        self.color = color
        self.series = series
        self.fuelInformation = FuelInformation(fuelType: fuelType, fuelLevel: fuelLevel)
        self.transmission = transmission
        self.licensePlate = licensePlate
        self.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
        self.innerCleanliness = innerCleanliness
        self.carImageUrl = URL(string: String(format: Constants.carImageUrlSchemeMainPart))?.appendingPathComponent(modelIdentifier).appendingPathComponent(color).appendingPathComponent(Constants.carImageUrlSchemeEndPart)
        if let url = self.carImageUrl {
            let imageData = try Data(contentsOf: url)
            self.carImageData = imageData
        }
    }
    
    
}
