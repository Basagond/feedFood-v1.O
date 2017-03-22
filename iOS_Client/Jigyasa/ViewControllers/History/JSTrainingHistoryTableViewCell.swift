//
//  JSTrainingHistoryTableViewCell.swift
//  Jigyasa
//
//  Created by siddesh medehalmath ganeshbabu on 30/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSTrainingHistoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet var trainingIconImage: UIImageView!
    
    @IBOutlet var trainingTitle: UILabel!
    
    @IBOutlet var trainerNameAndID: UILabel!
    
    @IBOutlet var trainingAttended: UILabel!
    
    @IBOutlet  var trainingDateAndTime: UILabel!
    
    @IBOutlet var referenceLink: UIButton!
    
    public var delegate: JSTrainingHistoryProtocol? = nil
    
    public var trainingMaterialLink: String? = nil
    
    public var didAttendedTraining:Bool? = true {
        
        didSet(newValue) {
            if let  hasNewValue = newValue {
                trainingAttended.isHidden = hasNewValue
            }
            
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func onReferenceTap(_ sender:UIButton) {
        
        if let canCallDelegate = delegate {
            canCallDelegate.onReferenceLinkTouch(hyperLink: trainingMaterialLink)
        }
        
    }
    
}
