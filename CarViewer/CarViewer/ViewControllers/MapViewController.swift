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
    
    @IBOutlet weak var mapView: MKMapView!
    public var position: Position!
    public var carName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func loadMapView() {
        self.mapView.isZoomEnabled = true
        self.mapView.isRotateEnabled = true
        self.mapView.isScrollEnabled = true
        if let position = position {
            let coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(position.latitude), longitude: CLLocationDegrees(position.longitude))
            let annotation = MKPointAnnotation()
            if let name = carName {
                annotation.title = name
            }
            annotation.coordinate = coordinates
            mapView.addAnnotation(annotation)
        }
    }
}
