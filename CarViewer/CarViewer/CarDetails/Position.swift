//
//  Position.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 15..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import Foundation

struct Position {
    let latitude: Float
    let longitude: Float
    
    var share: (Float, Float) {
        return (latitude, longitude)
    }
    
    public init(latitude: Float, longitude: Float) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
