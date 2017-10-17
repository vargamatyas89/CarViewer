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

    var defaultRowHeight = CGFloat(124)
    var detailViewController: DetailViewController? = nil
    var carList = [Car]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Cars"
        self.loadData()

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
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
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
        guard let height = (tableView.cellForRow(at: indexPath) as? ReusableCarCell)?.carImage.frame.height else {
            return defaultRowHeight
        }
        return height
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCarCell, for: indexPath) as? ReusableCarCell else {
            fatalError("ReusableCarCell can not be instantiated.")
        }
        let car = carList[indexPath.row]
        cell.carModelName.text = car.modelName
        cell.carColor.text = car.color
        cell.carImage.image = UIImage(named: Constants.placeholderCarImage, in: Bundle.main, compatibleWith: nil)
        guard let imageUrl = car.carImageUrl else {
            print("Image load failed.")
            // If there isn't any imageUrl, the default image will remain presented
            return cell
        }
        cell.activityIndicator.startAnimating()
        DispatchQueue.global().async {
            let imageLoaderDataTask = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, let loadedImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.carImage.image = loadedImage
                        cell.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
            }
            imageLoaderDataTask.resume()
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
}

extension MasterViewController {
    func loadData() {
       // DispatchQueue.global().async {
            let request = URLRequest(url: Constants.carsJSONUrl, cachePolicy: .reloadIgnoringLocalCacheData)
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
                }
            }
            task.resume()
        }
//    }
}
