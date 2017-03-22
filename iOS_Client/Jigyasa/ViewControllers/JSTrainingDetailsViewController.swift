//
//  JSCourseDetailedTableViewController.swift
//  Addnew
//
//  Created by manohara reddy p on 10/01/17.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSTrainingDetailsViewController: UITableViewController {
    
    @IBOutlet weak var trainingImage: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var trainer: UILabel!
    @IBOutlet weak var document: UILabel!
    @IBOutlet weak var trainingDetails: UILabel!
    
    @IBOutlet weak var nominateCount: UILabel!
    @IBOutlet weak var approveCount: UILabel!
    
    
    private var numberOfRows :Int {
        
        get {
            
            if navigationController?.childViewControllers[0] is JSHomeViewController {
                // Diaplay All the cells
                return 9
            } else if navigationController?.childViewControllers[0] is JSTrainingHistoryViewController {
                
                // Hide request button if user is from history view controller
                navigationItem.rightBarButtonItem = nil
                // Approve, Nominate are hidden
                return 7
            }
            return 0
        }
    }
    
    // Hardcoded removed after service integration
    var nominateEmployees : [Employee] = [
        
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"A S Rekha", JSEmployeeModelKey.lastName.rawValue: "Prakash"]), newId: "1748", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Anil Kumar", JSEmployeeModelKey.lastName.rawValue: "B M"]), newId: "3449", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Chetan", JSEmployeeModelKey.lastName.rawValue: "H"]), newId: "2408", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Debasis", JSEmployeeModelKey.lastName.rawValue: "Mishra"]), newId: "2107", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Disha Anana", JSEmployeeModelKey.lastName.rawValue: "Sehgal"]), newId: "2527", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Hemantha", JSEmployeeModelKey.lastName.rawValue: "Kumar E"]), newId: "1605", newIsSelected: false)
    ]
    
    
    var approveEmployees: [Employee] = [
        
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"A S Rekha", JSEmployeeModelKey.lastName.rawValue: "Prakash"]), newId: "1748", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Anil Kumar", JSEmployeeModelKey.lastName.rawValue: "B M"]), newId: "3449", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Chetan", JSEmployeeModelKey.lastName.rawValue: "H"]), newId: "2408", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Debasis", JSEmployeeModelKey.lastName.rawValue: "Mishra"]), newId: "2107", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Disha Anana", JSEmployeeModelKey.lastName.rawValue: "Sehgal"]), newId: "2527", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Hemantha", JSEmployeeModelKey.lastName.rawValue: "Kumar E"]), newId: "1605", newIsSelected: false)
    ]
    
    // Constants which are private to viewController
    private let cellHight: CGFloat = 44
    private let nominateCellIndex = 7
    private let approveCellIndex = 8
    private let materialIndex = 5
    
    //MARK: Default Method
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        trainingDetails.text = "The Topics covered in this training are: \n 1. What is accessibility ?\n 2. How to add accessibility to Cocoa applications ? \n 3. Advantages of adding accessibility."
        location.text = "Jog, KRR"
        trainingImage.image = #imageLiteral(resourceName: "Swift")
        tableView.estimatedRowHeight = cellHight
        tableView.rowHeight = UITableViewAutomaticDimension
        configureMaterialLink()
        getTrainingDetails()
        tableView.bounces = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        displayNominatedAndRequestedCount()
    }
    
    //MARK: Instance Method
    func displayNominatedAndRequestedCount() {
        
        let nominates = nominateEmployees.filter({$0.isNominated == true})
        let approves = approveEmployees.filter({$0.isNominated == true})
        nominateCount.text = "\(nominates.count) Nominated"
        approveCount.text = " \(approveEmployees.count) Requests, \(approves.count) Approved"
    }
    
    func openMaterialUrlInBrowser() {
        
        if let url = URL(string: "https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/") {
            UIApplication.shared.openURL(url)
        }
    }
    
    private func configureMaterialLink() {
        
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let attributedString = NSAttributedString(string: "www.Documents.com", attributes: underlineAttribute)
        document.attributedText = attributedString
    }
    
    private func getTrainingDetails() {
        
        let requestBody = [JSTrainingModelKey.trainingId.rawValue: 139]
        JSServiceRequestManager.sharedManager().dataTaskWithURL(postBody: requestBody, urlEndString: JSServiceEndPoints.trainingDetails.rawValue, completionHandler:{ (responseData) in
            print(responseData)
        })
    }
    
    //request alert
    func presentRequestAlert() {
        
        let alertController = UIAlertController(title: "A request will be sent to your manager",
                                                message: "A mail will be sent to you upon approval",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: JSButtonTitle.okButtonTitle.rawValue,
                                     style: .default,
                                     handler: nil)
        let cancelAction = UIAlertAction(title: JSButtonTitle.cancelButtonTitle.rawValue,
                                         style: .default,
                                         handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: UITableView Delegate and Datasource Method
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == materialIndex {
            openMaterialUrlInBrowser()
        } else {
            performSegue(withIdentifier: "AddEmployees", sender: self)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textAlignment = .center
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        }
    }
    
    //MARK: Button Action
    @IBAction func request(_ sender: UIBarButtonItem) {
        
        presentRequestAlert()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addViewController = segue.destination as? JSAddManagerViewController {
            
            if tableView.indexPathForSelectedRow?.row == nominateCellIndex  {
                
                addViewController.employees = nominateEmployees
                addViewController.selectedView = "Nominate"
            } else if tableView.indexPathForSelectedRow?.row == approveCellIndex {
                
                addViewController.employees = approveEmployees
                addViewController.selectedView = "Approve"
            }
            addViewController.selectedCourseTitle = courseName.text!
        }
    }
}
