//
//  ReusableCarCell.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 15..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import UIKit

class ReusableCarCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carModelName: UILabel!
    @IBOutlet weak var carColor: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
