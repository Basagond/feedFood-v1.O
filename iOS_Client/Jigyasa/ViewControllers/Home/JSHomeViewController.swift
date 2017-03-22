//
//  JSHomeViewController.swift
//  Jigyasa
//
//  Created by annapurna chandra on 13/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit


class JSHomeViewController: UIViewController {
    
    var delegate: JSMenuTableViewControllerProtocol?
    
    @IBOutlet var trainingTableView: UITableView!
    @IBOutlet var addTrainingButton: UIBarButtonItem!
    
    
    var headerModels: [JSHomeViewHeaderCellModel] = []
    let searchBar = UISearchBar(frame: CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(320.0), height: CGFloat(44.0)))
    
    
    fileprivate let suggestTrainingIndex = 3
    
    fileprivate var previousSelectedHeaderIndex: Int? = 0
    
    //MARK: Default Method
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        //trainingTableView.setContentOffset(CGPoint(x: CGFloat(0), y: CGFloat(88)), animated: true)
        headerModels = getHeaderModels(forDictionary: nil)
        
        enableReturnKeyWithNoText()
        
        if #available(iOS 10.0, *) {
            let refreshController = UIRefreshControl()
            let attributedDic = [NSForegroundColorAttributeName:UIColor.blue]
            refreshController.attributedTitle = NSAttributedString(string: "Refreshing the Training List", attributes: attributedDic)
            refreshController.addTarget(self, action: #selector(self.onPullToRefresh(_:)), for: .valueChanged)
            trainingTableView.refreshControl = refreshController
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK:- Buttom Actions
    
    @IBAction func MenuButtonAction(_ sender: UIBarButtonItem) {
        self.delegate?.showMenuViewController()
    }
    
}
extension JSHomeViewController: UISearchBarDelegate {
    
    func enableReturnKeyWithNoText() {
        // Find textfield in searbar
        
        if let searchBar = trainingTableView.tableHeaderView as? UISearchBar {
            
            for subview in searchBar.subviews[0].subviews {
                
                if let subview = subview as? UITextField {
                    //makeing searchkey always enable
                    subview.enablesReturnKeyAutomatically = false
                }
            }
        }
    }
    
    // Return keyboard when user press search key
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
}

// MARK: - TableView Delegates
extension JSHomeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return headerModels.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return headerModels[section].isExpanded == true ? ( 5 - section ) : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return CGFloat(30)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return createTrainingGroupHeaderCell(inTableView: tableView, withGroupTitle: "Swift and java", forSectionIndex: section)
    }
    
    
    // MARK: - TableView DataSourceDelegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return createTrainingCell(inTableView: tableView, forIndexPath: indexPath)
    }
    
    //TODO: Need to handle delete functionality only for Admin role
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        //to handle delete funtionality only for upcoming trainings and training suggestions.
        //check can be changed to indexpath.section if header section orders are fixed
        if (headerModels[indexPath.section].headerText == "Upcoming Trainings" || headerModels[indexPath.section].headerText == "Training Suggestions")
        {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == .delete){
            //TODO: Currently number of rows in a section is returning random count which is harcoded ,once that is fixed this can be uncommented
            //trainingTableView.beginUpdates()
            // trainingTableView.deleteRows(at: [indexPath], with: .fade)
            //trainingTableView.endUpdates()
        }
        
    }
    
    fileprivate func createTrainingCell(inTableView tableView:UITableView, forIndexPath indexPath:IndexPath) ->
        UITableViewCell {
            
            var traingCell: UITableViewCell? = nil
            
            if indexPath.section != suggestTrainingIndex {
                traingCell = tableView.dequeueReusableCell(withIdentifier: JSCellIdentifiers.trainingCellIdentifier.rawValue, for: indexPath)
            } else {
                traingCell = tableView.dequeueReusableCell(withIdentifier: JSCellIdentifiers.suggestionTrainingCellIdentifier.rawValue, for: indexPath)
                
            }
            return traingCell!;
    }
    
    
    fileprivate func createTrainingGroupHeaderCell(inTableView tableView:UITableView, withGroupTitle title: String, forSectionIndex sectionIndex: Int) -> UIView {
        
        let trainingGroupHeaderCell = tableView.dequeueReusableCell(withIdentifier: JSCellIdentifiers.trainingGroupHeaderCellIdentifier.rawValue) as! JSTrainingGroupHeaderTableViewCell
        
        
        trainingGroupHeaderCell.groupTextLabel.text = headerModels[sectionIndex].headerText
        
        trainingGroupHeaderCell.groupCellButton.addTarget(self, action: #selector(JSHomeViewController.toggleHeaderSection(_:)), for: .touchUpInside)
        
        trainingGroupHeaderCell.groupCellButton.tag = sectionIndex
        
        if (headerModels[sectionIndex].isExpanded == true ) {
            
            updateGroupHeaderArrow(forImageView: trainingGroupHeaderCell.expandAndCollapseIcon, asIcon: JSHomeViewControllerConstants.kDownArrow.rawValue)
        } else {
            
            updateGroupHeaderArrow(forImageView: trainingGroupHeaderCell.expandAndCollapseIcon, asIcon: JSHomeViewControllerConstants.kRightArrow.rawValue)
        }
        
        return trainingGroupHeaderCell.contentView;
    }
}

//MARK: - Accordian action, pull to refresh and Add Training

extension JSHomeViewController {
    
    func toggleHeaderSection(_ sender: UIButton){
        
        let sectionIndex = sender.tag
        
        if let haspreviousSelectedHeaderIndex = previousSelectedHeaderIndex {
            
            if haspreviousSelectedHeaderIndex != sectionIndex {
                previousSelectedHeaderIndex = sectionIndex
                headerModels[haspreviousSelectedHeaderIndex].isExpanded = !headerModels[haspreviousSelectedHeaderIndex].isExpanded
                trainingTableView.reloadSections(IndexSet(integer:haspreviousSelectedHeaderIndex), with: .automatic)
            } else {
                
                return
            }
            
        } else {
            
            previousSelectedHeaderIndex = sectionIndex
        }
        
        headerModels[sectionIndex].isExpanded = !headerModels[sectionIndex].isExpanded
        trainingTableView.reloadSections(IndexSet(integer: sectionIndex), with: .fade)
        
    }
    
    func updateGroupHeaderArrow(forImageView imageView: UIImageView, asIcon icon: String) {
        
        UIView.animate(withDuration: 0.5, animations: {
            imageView.image = UIImage(named: icon)
        })
        
    }
    
    func onPullToRefresh(_ sender:UIRefreshControl) {
        
        self.trainingTableView.tableHeaderView = searchBar
        sender.endRefreshing()
    }
}

extension UITableView {
    
    var isTableHeaderViewVisible: Bool {
        
        guard let tableHeaderView = tableHeaderView else {
            return false
        }
        
        let currentYOffset = self.contentOffset.y;
        let headerHeight = tableHeaderView.frame.size.height;
        
        return currentYOffset < headerHeight
    }
}

//MARK: - Custom Function
extension JSHomeViewController {
    
    func getHeaderModels(forDictionary dictionary: [String:Any]?) -> [JSHomeViewHeaderCellModel] {
        
        let headerModels = [JSHomeViewHeaderCellModel(forSectionIndex: 0, withHeaderText: "My Trainings", andIsExpanded: true),
                            JSHomeViewHeaderCellModel(forSectionIndex: 1, withHeaderText: "Today's Trainings", andIsExpanded: false),
                            JSHomeViewHeaderCellModel(forSectionIndex: 2, withHeaderText: "Upcoming Trainings", andIsExpanded: false),
                            JSHomeViewHeaderCellModel(forSectionIndex: 3, withHeaderText: "Training Suggestions", andIsExpanded: false) ]
        
        return headerModels
    }
}

