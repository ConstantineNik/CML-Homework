//
//  PropDetailsCell.swift
//  CML Homework
//
//  Created by Kostiantyn Nikitchenko on 22.04.2021.
//

import UIKit

class PropDetailsCell: UITableViewCell {

    @IBOutlet weak var propertyNameLabel: UILabel!
    @IBOutlet weak var propertyValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
