//
//  JSMenuTableViewController.swift
//  Jigyasa
//
//  Created by annapurna chandra on 15/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

// model to display show sidemenu
struct Menu {
    
    var name: JSSideMenu
    var image: UIImage
}

class JSMenuTableViewController: UITableViewController {
    
    var delegate: JSMenuTableViewControllerProtocol?
    var subControllerDelegate: JSLogInViewControllerProtocol?
    @IBOutlet private weak var userNameLabel: UILabel!
    
    private let menuData = [
        
        Menu(name: .home, image: #imageLiteral(resourceName: "Home")),
        Menu(name: .suggest, image: #imageLiteral(resourceName: "SuggestTraining")),
        Menu(name: .history, image: #imageLiteral(resourceName: "TrainingHistory")),
        Menu(name: .about, image: #imageLiteral(resourceName: "About")),
        Menu(name: .help, image: #imageLiteral(resourceName: "Help")),
        Menu(name:.logout, image: #imageLiteral(resourceName: "Logout"))
    ]
    
     //Presenting viewController storyboardId
    private let storyboardId: [JSSideMenu: JSSubViewControllers]  = [
        
        .home:JSSubViewControllers.homeViewController,
        .suggest: JSSubViewControllers.suggestTrainingViewController,
        .history: JSSubViewControllers.historyViewController,
        .about: JSSubViewControllers.aboutViewController,
        .help: JSSubViewControllers.helpViewController
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loggedInUserDefaults = JSUserDefaults()
        userNameLabel.text = loggedInUserDefaults.getUserName()
    }
    
    //MARK: UITableView delegate and datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menuData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:JSCellIdentifiers.menuTableCellIdentifier.rawValue ) as! JSSideMenuTableViewCell
        cell.menu = menuData[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Loading different view controllers according to selected menu option
        if case .logout = menuData[indexPath.row].name {
            
            showLogoutAlert()
        } else {
            
            if let storyboardId = storyboardId[menuData[indexPath.row].name] {
            
                subControllerDelegate?.loadSubViewControllers(controller: storyboardId)
                // close sidemenu
                delegate?.hideMenuViewController()
            }
        }
    }
    
    // MARK: - Show logout alert
    private func showLogoutAlert() {
        
        let logout = UIAlertController(title: JSLogoutMessage.title.rawValue,
                                       message: JSLogoutMessage.message.rawValue,
                                       preferredStyle:.alert)
        logout.addAction(UIAlertAction(title: JSButtonTitle.cancelButtonTitle.rawValue,
                                       style: .cancel) { (alert) in
                                        
        })
        logout.addAction(UIAlertAction(title:JSButtonTitle.okButtonTitle.rawValue,
                                       style: .default) { (alert) in
                                        let loggedInUserDefaults = JSUserDefaults()
                                        loggedInUserDefaults.deleteUserName()
                                        self.subControllerDelegate?.resetLoginPageAfterLogout()
        })
        present(logout, animated: true, completion: nil)
    }
}


