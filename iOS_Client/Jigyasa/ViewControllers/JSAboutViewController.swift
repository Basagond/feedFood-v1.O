//
//  JSAboutViewController.swift
//  Jigyasa
//
//  Created by annapurna chandra on 26/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSAboutViewController: UIViewController {
    
    var delegate: JSMenuTableViewControllerProtocol?
    
    //MARK:- Menu action
    @IBAction func MenuButtonAction(_ sender: UIBarButtonItem) {
        
        delegate?.showMenuViewController()
    }
}
