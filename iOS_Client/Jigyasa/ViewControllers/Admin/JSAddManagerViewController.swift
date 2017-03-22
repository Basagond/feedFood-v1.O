//
//  JSAddManagerViewController.swift
//  Jigyasa
//
//  Created by manohara reddy p on 03/01/17.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSAddManagerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    var employees: [Employee] = [] {
        
        didSet {
            displaySelectedCount()
        }
    }
    
    var filteredEmployees: [Employee] = []
    
    var selectedView : String = "Done"
    var selectedCourseTitle : String = ""
    @IBOutlet weak var noSearchResults: UILabel!
    @IBOutlet weak var employeeTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    private var isSearchBarEmpty: Bool {
        
        return searchBar?.text?.isEmpty ??  false
    }
    
    private var employeeList : [Employee] {
        
        return isSearchBarEmpty ? employees : filteredEmployees
    }
    
    //MARK: Default Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeTable.delegate = self
        employeeTable.dataSource = self
        employeeTable.isEditing = true
        searchBar.delegate = self
        doneButton.isEnabled = false
        doneButton.title = selectedView
        enableReturnKeyWithNoText()
    }
    
    //MARK: Instance Method
    func enableReturnKeyWithNoText() {
       
        // Find textfield in searchbar
        for subview in searchBar.subviews[0].subviews {
            
            if let subview = subview as? UITextField {
                //searchkey always enable
                subview.enablesReturnKeyAutomatically = false
            }
        }
    }
    
    func displaySelectedCount() {
        
        let filterValue = employeeList.filter({$0.isSelected})
        if filterValue.isEmpty {
            doneButton.isEnabled = false
            title = selectedCourseTitle
        } else {
            title = "\(filterValue.count) selected"
            doneButton.isEnabled = true
        }
    }
    
    // MARK: - Filtering array
    private func filterManagers(text:String) {
        
        if !isSearchBarEmpty {
            
            filteredEmployees = employees.filter {
                $0.id.lowercased().hasPrefix(text) ||
                    $0.name.firstName.lowercased().contains(text) ||
                    $0.name.lastName.lowercased().contains(text)
            }
            noSearchResults.isHidden = filteredEmployees.isEmpty ? false : true
        } else {
            noSearchResults.isHidden = true
        }
        employeeTable.reloadData()
    }
    
    //MARK: UITableView Delagte and Datasource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: JSCellIdentifiers.addManagerIdentifier.rawValue)
        let manager = employeeList[indexPath.row]
        let employeeInfo = manager.id + " - "  + manager.name.firstName + " " +  manager.name.lastName
        let attrString = NSMutableAttributedString(string: employeeInfo)
        
        let range = (employeeInfo as NSString).range(of: searchBar.text!, options: .caseInsensitive)
        attrString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: range)
        cell!.textLabel?.attributedText = attrString
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        employeeList[indexPath.row].isSelected = true
        displaySelectedCount()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        employeeList[indexPath.row].isSelected = false
        displaySelectedCount()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if employeeList[indexPath.row].isNominated {
            cell.isUserInteractionEnabled = false
            cell.isEditing = false
            cell.accessoryType = .checkmark
            cell.tintColor = UIColor.gray
            cell.textLabel?.textColor = UIColor.gray
            return
        }
        if employeeList[indexPath.row].isSelected {
            
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableViewScrollPosition.none)
            self.tableView(tableView, didSelectRowAt: indexPath)
        }
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchText = searchBar.text {
            
            filterManagers(text: searchText.lowercased())
        }
    }
    
    // Return keyboard when user press search key
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    //MARK: Button action
    @IBAction func doneButtonSelected(_ sender: UIBarButtonItem) {
        
        let selectedCount = employees.filter({$0.isSelected}).count
        var selectionMessage = "\(selectedCount) trainer(s) have been added"
        
        if sender.title == "Nominate" {
            selectionMessage = "\(selectedCount) member(s) have been nominated"
        } else if sender.title == "Approve" {
            selectionMessage = "\(selectedCount) requests have been approved"
        }
       
        let confirmationAlert = UIAlertController(title: selectionMessage, message: "", preferredStyle:.alert)
        
        confirmationAlert.addAction(UIAlertAction(title: JSButtonTitle.cancelButtonTitle.rawValue, style: .cancel) { (alert) in
        })
        confirmationAlert.addAction(UIAlertAction(title: JSButtonTitle.okButtonTitle.rawValue, style: .default) { (alert) in
            _ = self.employees.map { (employee) -> Employee in
                if employee.isSelected == true {
                    employee.isNominated = true
                    employee.isSelected = false
                }
                return employee
            }
            _ = self.navigationController?.popViewController(animated: true)
        })
        
        self.present(confirmationAlert, animated: true, completion: nil)
        
    }
    
    @IBAction func selectAllEmployees(_ sender: UIBarButtonItem) {
        
        if sender.title == "Select All" {
            
            employees = employees.map {
                
                if $0.isNominated == false {
                    
                    $0.isSelected = true
                    return $0
                }
                return $0
            }
            sender.title = "Deselect All"
        } else {
            employees = employees.map {
                if $0.isNominated == false {
                    $0.isSelected = false
                    return $0
                }
                return $0
            }
            sender.title = "Select All"
        }
        employeeTable.reloadData()
    }
}
