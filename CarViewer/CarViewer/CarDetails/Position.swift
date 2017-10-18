//
//  Position.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 15..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import Foundation

struct Position {
    let latitude: Double
    let longitude: Double
    
    var share: (Double, Double) {
        return (latitude, longitude)
    }
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
