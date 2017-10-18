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
    
    public var car: Car!

    @IBAction func showOnMap(_ sender: Any) {
        performSegue(withIdentifier: "showOnMap", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fillTextViewWithCarData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOnMap", let car = car, let destination = segue.destination as? MapViewController {
            destination.carName = car.name
            destination.position = car.position
            
        }
    }
    
    private func fillTextViewWithCarData() {
        
    }
}

