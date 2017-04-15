//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Vladyslav Chornobai on 15/04/2017.
//  Copyright © 2017 Vladyslav Chornobai. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    //MARK: properties
    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var ratingsField: StarRatingControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
