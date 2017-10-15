//
//  FuelInformation.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 15..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import Foundation

struct FuelInformation {
    let fuelType: String
    let fuelLevel: Float
    
    var share: (String, Float) {
        return (fuelType, fuelLevel)
    }
    
    public init(fuelType: String, fuelLevel: Float) {
        self.fuelType = fuelType
        self.fuelLevel = fuelLevel
    }
}
