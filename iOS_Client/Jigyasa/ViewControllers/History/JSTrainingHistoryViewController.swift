//
//  JSHistoryViewController.swift
//  Jigyasa
//
//  Created by siddesh medehalmath ganeshbabu on 30/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSTrainingHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JSTrainingHistoryProtocol {
    
    var delegate: JSMenuTableViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
       
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onMenuButtonTouch(_ sender:UIBarButtonItem){
        
        if let canCallDelegate = delegate{
            canCallDelegate.showMenuViewController()
        }
    }
}

// MARK: - Training Histroy TableView DataSource Delegate

extension JSTrainingHistoryViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let trainingHistoryCell = tableView.dequeueReusableCell(withIdentifier: JSCellIdentifiers.trainingHistoryCellIdentifier.rawValue, for: indexPath) as! JSTrainingHistoryTableViewCell
        
        trainingHistoryCell.didAttendedTraining = (indexPath.row % 2 == 0 ? true : false)
        trainingHistoryCell.trainingMaterialLink = "https://somelink/\(indexPath.row)"
        trainingHistoryCell.delegate = self
        
        return trainingHistoryCell;
    }
}

// MARK: - Training History Tableview Delegate

extension JSTrainingHistoryViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension JSTrainingHistoryViewController {
    
    func onReferenceLinkTouch(hyperLink link: String?) {
        
        if let validLink = link {
            print(validLink)
        } else {
            print("no link found")
        }
    }
}

