//
//  MasterViewController.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 14..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class MasterViewController: UITableViewController {

    var defaultRowHeight = CGFloat(100)
    var detailViewController: DetailViewController? = nil
    var carList = [Car]()
    
    deinit {
        self.carList.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
            
        self.navigationItem.title = "Cars"

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow,
                let cell = sender as? ReusableCarCell,
                let detailViewController = (segue.destination as! UINavigationController).topViewController as? DetailViewController
            {
                let selectedCar = carList[indexPath.row]
                detailViewController.car = selectedCar
                detailViewController.carImage.image = cell.carImage.image
                detailViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                detailViewController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return defaultRowHeight
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCarCell, for: indexPath) as? ReusableCarCell else {
            fatalError("ReusableCarCell can not be instantiated.")
        }
        let car = carList[indexPath.row]
        cell.carModelName.text = car.modelName
        cell.carColor.text = car.colorDescription
        cell.cleanliness.text = car.innerCleanlinessDescription
        cell.carImage.image = UIImage(named: Constants.placeholderCarImage, in: Bundle.main, compatibleWith: nil)
        guard let imageUrl = car.carImageUrl else {
            print("Image load failed.")
            // If there isn't any imageUrl, the default image will remain presented
            return cell
        }
        cell.activityIndicator.startAnimating()
        self.loadImage(into: cell, from: imageUrl)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension MasterViewController {
    func loadData() {
        DispatchQueue.global().async {
            let request = URLRequest(url: Constants.carsJSONUrl, cachePolicy: .returnCacheDataElseLoad)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error happened during json download: \(error)")
                    return
                }
                if let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let data = data,
                    let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
                    let jsonDictionary = jsonData as? [[String: Any]]
                {
                    for element in jsonDictionary {
                        do{
                            try self.carList.append(Car(from: element))
                        } catch {
                            print("Error happened during transforming jsonDictionary element. \(error)")
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            task.resume()
        }
    }
    
    func loadImage(into cell: ReusableCarCell, from url: URL) {
        var image: UIImage?
        
        DispatchQueue.global().async {
            do {
                try image = UIImage(data: Data(contentsOf: url))!
            } catch {
                print("Image can not be loaded.")
            }
            DispatchQueue.main.async(execute: {
                cell.activityIndicator.stopAnimating()
                if image != nil {
                    cell.carImage.image = image
                }
            })
        }
    }
}
