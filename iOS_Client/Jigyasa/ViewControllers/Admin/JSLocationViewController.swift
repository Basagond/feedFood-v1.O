//
//  JSLocationViewController.swift
//  Jigyasa
//
//  Created by manohara reddy p on 02/02/17.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var locationTable: UITableView!
    @IBOutlet weak var noSearchResults: UILabel!
    
    // Hardcoded data removed once server integrated
    private var locationList: [String] = [
        "CARNATION Training Room - 4th Floor - RMR Office",
        "ORCHID Training Room - 2nd floor -  RMR Office"
    ]
    var selectedLocation = JSDefaultValues.defaultStringValue
    
    private var filteredLocationList: [String] = []
    
    private var isSearchBarEmpty: Bool {
        
        return searchBar?.text?.isEmpty ??  false
    }
    
    private var locations : [String] {
        
        return isSearchBarEmpty ? locationList : filteredLocationList
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Service call to get all locations
        locationTable.delegate = self
        locationTable.dataSource = self
        enableReturnKeyWithNoText()
        searchBar.delegate = self
    }
    
    private func enableReturnKeyWithNoText() {
       
        // Find textfield in searchbar
        for subview in searchBar.subviews[0].subviews {
            
            if let subview = subview as? UITextField {
                //searchkey always enable
                subview.enablesReturnKeyAutomatically = false
            }
        }
    }
    
    // MARK: - Tableview delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: JSCellIdentifiers.locationCellIdentifier.rawValue)!
        let location = locations[indexPath.row]
        let attrString = NSMutableAttributedString(string: locations[indexPath.row])
        let range = (location as NSString).range(of: searchBar.text!,
                                                 options: .caseInsensitive)
        attrString.addAttribute(NSForegroundColorAttributeName,
                                value: UIColor.blue,
                                range: range)
        cell.textLabel?.attributedText = attrString
        return cell
    }
    
    // MARK: - Prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let row = locationTable.indexPathForSelectedRow?.row
        
        if let row = row {
            
            selectedLocation = locations[row]
        }
    }
    
    // MARK: - Filtering array
    private func filterLocation(text:String) {
        
        if !isSearchBarEmpty {
            
            filteredLocationList = locationList.filter{$0.lowercased().contains(text)}
            noSearchResults.isHidden = filteredLocationList.isEmpty ? false : true
        } else {
            
            noSearchResults.isHidden = true
        }
        
        locationTable.reloadData()
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let searchText = searchBar.text {
            
            filterLocation(text: searchText.lowercased())
        }
    }
    
    // Return keyboard when user press search key
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    // MARK: - cancelAction
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
}
