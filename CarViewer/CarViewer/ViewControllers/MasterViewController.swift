//
//  MasterViewController.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 14..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    var defaultRowHeight: CGFloat = 40.0
    var detailViewController: DetailViewController? = nil
    var carList = [Car]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCarCell, for: indexPath) as? ReusableCarCell

        return cell!.carImage.frame.height
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.reusableCarCell, for: indexPath)
        cell.imageView?.image = UIImage(named: Constants.placeholderCarImage, in: Bundle.main, compatibleWith: nil)
        guard let imageUrl = carList[indexPath.row].carImageUrl else {
            print("Image load failed.")
            return cell
        }
        let imageLoaderDataTask = URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            if let data = data, let loadedImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let updateCell = tableView.cellForRow(at: indexPath) as? ReusableCarCell {
                        updateCell.carImage.image = loadedImage
                    }
                    self.tableView.reloadData()
                }
            }
        }
        imageLoaderDataTask.resume()
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

    /*
     // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
     
     func controllerDidChangeContent(controller: NSFetchedResultsController) {
         // In the simplest, most efficient, case, reload the table view.
         tableView.reloadData()
     }
     */
}

extension MasterViewController {
    func loadData() {
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
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        task.resume()
    }
}
