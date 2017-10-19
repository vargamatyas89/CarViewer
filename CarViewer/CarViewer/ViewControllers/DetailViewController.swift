//
//  DetailViewController.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 14..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    public var car: Car!

    @IBAction func showOnMap(_ sender: Any) {
        performSegue(withIdentifier: "showOnMap", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillImage()
        self.fillTextViewWithCarData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOnMap", let car = car, let navigationController = segue.destination as? UINavigationController {
            let mapViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
            mapViewController.carName = car.name
            mapViewController.position = car.position
            mapViewController.title = "Car position"
            navigationController.navigationItem.setLeftBarButton(nil, animated: true)
            navigationController.pushViewController(mapViewController, animated: true)
        }
    }
    
    private func fillImage() {
        var image: UIImage?
        DispatchQueue.main.async {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }
        
        DispatchQueue.global().async {
            guard let imageData = self.car.carImageData else {
                print("Data for image can not be loaded.")
                return
            }
            image = UIImage(data: imageData)

            DispatchQueue.main.async(execute: {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                if image != nil {
                    self.carImage.image = image
                }
            })
        }
    }
    
    private func fillTextViewWithCarData() {
        var result = ""
        result.appendLine("Name: \(car.name)")
        result.appendLine("Model name: \(car.modelName)")
        result.appendLine(car.innerCleanlinessDescription)
        result.appendLine("Model identifier: \(car.modelIdentifier)")
        result.appendLine("ID: \(car.id)")
        result.appendLine("Make: \(car.make)")
        result.appendLine("Group: \(car.group)")
        result.appendLine("Color: " + car.colorDescription)
        result.appendLine("Series: \(car.series)")
        result.appendLine("Fuel information: " + car.fuelInformation.share)
        result.appendLine("Transmission: \(car.transmission)")
        result.appendLine("License plate: \(car.licensePlate)")
        
        self.textView.text = result
    }
}

