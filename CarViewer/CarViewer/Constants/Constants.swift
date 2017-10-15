//
//  Constants.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 15..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import Foundation

enum Constants {

    // https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/{modelIdentifier}/{color}/2x/car.png
    public static let carImageUrlScheme = "https://prod.drive-now-content.com/fileadmin/user_upload_global/assets/cars/%@/%@/2x/car.png"
    public static let carsJSONUrl = URL(string: "http://www.codetalk.de/cars.json")!
}
