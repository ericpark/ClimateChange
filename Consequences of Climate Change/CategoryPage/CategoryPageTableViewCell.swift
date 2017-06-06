//
//  CategoryPageTableViewCell.swift
//  Consequences of Climate Change
//
//  Created by Eric Park on 4/28/17.
//  Copyright © 2017 Eric Park. All rights reserved.
//

import UIKit

class CategoryPageTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
