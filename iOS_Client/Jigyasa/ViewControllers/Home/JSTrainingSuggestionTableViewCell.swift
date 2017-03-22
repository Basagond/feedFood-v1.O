//
//  JSTrainingSuggestionTableViewCell.swift
//  Jigyasa
//
//  Created by siddesh medehalmath ganeshbabu on 21/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSTrainingSuggestionTableViewCell: UITableViewCell {

    @IBOutlet var trainingSuggestionTitle: UILabel!
    
    @IBOutlet var employeeName: UILabel!
    
    @IBOutlet var trainingSuggestionStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
