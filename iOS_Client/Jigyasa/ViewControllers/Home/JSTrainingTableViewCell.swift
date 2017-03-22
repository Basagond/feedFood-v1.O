//
//  JSTrainingTableViewCell.swift
//  Jigyasa
//
//  Created by siddesh medehalmath ganeshbabu on 21/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSTrainingTableViewCell: UITableViewCell {
    
    
    @IBOutlet var trainingImage: UIImageView!
    
    @IBOutlet var trainingTitle: UILabel!
    
    @IBOutlet var trainingLocation: UILabel!
    
    @IBOutlet var trainingDateAndTime: UILabel!
    
    @IBOutlet var numberOfSeatsAvailableLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
