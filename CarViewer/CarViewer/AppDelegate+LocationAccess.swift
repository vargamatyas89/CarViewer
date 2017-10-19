//
//  AppDelegate+LocationAccess.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 19..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import CoreLocation

extension AppDelegate {
    // Request access to users location for mapView
    // Also needs property to be set in Info.plist - 'Privacy - Location When In Use Usage Description'
    func requestLocationAccess() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
}
