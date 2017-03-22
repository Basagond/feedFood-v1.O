//
//  JSHelpViewController.swift
//  Jigyasa
//
//  Created by annapurna chandra on 26/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSHelpViewController: UIViewController {
    
    var delegate: JSMenuTableViewControllerProtocol?
    
    //MARK:- Buttom Actions
    @IBAction func MenuButtonAction(_ sender: UIBarButtonItem) {
        
        self.delegate?.showMenuViewController()
    }
}
