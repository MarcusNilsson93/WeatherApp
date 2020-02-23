//
//  CustomTableViewCell.swift
//  wheatherapp
//
//  Created by Marcus Nilsson on 2020-02-06.
//  Copyright © 2020 Marcus Nilsson. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var myCityLable: UILabel!
    @IBOutlet weak var MyDegreeView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
