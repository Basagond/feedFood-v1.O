//
//  SideMenuTableViewCell.swift
//  sideMenu
//
//  Created by manohara reddy p on 20/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSSideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var icon:UIImageView!
    @IBOutlet private weak var name: UILabel!

    var menu:Menu? {
        
        didSet {
            
            if let menu = menu {
                
                name.text = menu.name.rawValue
                icon.image = menu.image
            }
        }
    }
}
