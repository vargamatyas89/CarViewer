//
//  ReusableCarCell.swift
//  CarViewer
//
//  Created by Varga, Matyas on 2017. 10. 15..
//  Copyright © 2017. MyOrg. All rights reserved.
//

import UIKit

class ReusableCarCell: UITableViewCell {
    var reuseIdentifier: String?
    
    @IBOutlet weak var carImage: UIImageView
    @IBOutlet weak var carModelName: String
    @IBOutlet weak var carColor: String
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
