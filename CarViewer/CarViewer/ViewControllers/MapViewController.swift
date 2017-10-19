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
    public var position: CLLocationCoordinate2D!
    public var carName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadMapView(animated)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func loadMapView(_ animated: Bool) {
        self.mapView.isZoomEnabled = true
        self.mapView.isRotateEnabled = true
        self.mapView.isScrollEnabled = true
        
        self.makeAnnotationPoint()
        
        self.showRegionOfAnnotationPoint(animated)
    }
    
    private func makeAnnotationPoint() {
        let annotation = MKPointAnnotation()
        if let name = carName {
            annotation.title = name
        }
        annotation.coordinate = self.position
        self.mapView.addAnnotation(annotation)
    }
    
    private func showRegionOfAnnotationPoint(_ animated: Bool) {
        var visibleRectangle = mapView.visibleMapRect
        let mapPoint = MKMapPointForCoordinate(position)
        visibleRectangle.origin.x = mapPoint.x - visibleRectangle.size.width * 0.5;
        visibleRectangle.origin.y = mapPoint.y - visibleRectangle.size.height * 0.25;
        mapView.setVisibleMapRect(visibleRectangle, animated: animated)
        mapView.setRegion(MKCoordinateRegion(center: position, span: MKCoordinateSpanMake(position.latitude, position.longitude)), animated: animated)
    }
}
