//
//  ListTableViewCell.swift
//  App5
//
//  Created by Kipras on 3/6/16.
//  Copyright © 2016 Kipras. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listTextView: UITextView!
    @IBOutlet weak var listImageView: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Makes image display in cell to be round.
        listImageView.layer.borderWidth = 1
        listImageView.layer.masksToBounds = false
        listImageView.layer.borderColor = UIColor.whiteColor().CGColor
        listImageView.layer.cornerRadius = listImageView.frame.height/2
        listImageView.clipsToBounds = true

        // Configure the view for the selected state
    }

}
