//
//  MapViewController.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 15..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
