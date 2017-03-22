//
//  JSLogInViewController+Container.swift
//  Jigyasa
//
//  Created by annapurna chandra on 26/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

extension JSLogInViewController: JSMenuTableViewControllerProtocol, JSLogInViewControllerProtocol{
    
    //Initialize Navigationn Controller
    func initializeMenuNavigationContoller() {
        
        let storyboard = UIStoryboard(name: JSControllerIdentifer.mainStoryboardName.rawValue,
                                      bundle: nil)
        menuNavigationController = storyboard.instantiateViewController(withIdentifier: JSControllerIdentifer.menuNavigationControllerIdentifier.rawValue) as? UINavigationController
        
        let menuTableViewController = menuNavigationController?.topViewController as! JSMenuTableViewController
        menuTableViewController.delegate = self
        menuTableViewController.subControllerDelegate = self
        
        menuNavigationController?.view.frame = CGRect(x: -(view.frame.size.width/2 + JSCGFloatValue.menuTableViewWidthOffeset.rawValue) , y: 0, width: (view.frame.size.width/2 + JSCGFloatValue.menuTableViewWidthOffeset.rawValue), height: view.frame.height)
        view.addSubview((menuNavigationController?.view)!)
    }
    
    // Root Navigation Controller
    func initializeRootNavigationContoller() {
        
        let storyboard = UIStoryboard(name: JSControllerIdentifer.mainStoryboardName.rawValue,
                                      bundle: nil)
        homeNavigationController = storyboard.instantiateViewController(withIdentifier: JSControllerIdentifer.homeNavigationControllerIdentifier.rawValue) as? UINavigationController
        let homeViewController = homeNavigationController?.topViewController as! JSHomeViewController
        homeViewController.delegate = self
        view.addSubview(homeNavigationController!.view)
    }
    
    //MARK: - Menu Viewcontroller Protocol
    func showMenuViewController() {
        
        guard let menuNavigationController = menuNavigationController else {
            return
        }
        UIView.animate(withDuration: 0.2,
                       animations: {
                        menuNavigationController.view.frame = CGRect(x: 0, y: 0, width: (self.view.frame.size.width/2 + JSCGFloatValue.menuTableViewWidthOffeset.rawValue) , height: self.view.frame.height)
                        self.view.addSubview(self.overlayView!)
                        self.view.bringSubview(toFront: (menuNavigationController.view)!)
                        
        }, completion:{ _ in
            self.isMenuHidden = false;
        })
    }
    
    //MARK: - Hide menu viewController
    func hideMenuViewController() {
        
        guard let menuNavigationC = menuNavigationController else {
            return
        }
        
        UIView.animate(withDuration: 0.2,
                       animations: {
                        menuNavigationC.view.frame = CGRect(x: -(self.view.frame.size.width/2 + JSCGFloatValue.menuTableViewWidthOffeset.rawValue), y: 0, width: self.view.frame.size.width/2 + JSCGFloatValue.menuTableViewWidthOffeset.rawValue, height: self.view.frame.height)
        }, completion:{ _ in
            self.overlayView?.removeFromSuperview()
            self.isMenuHidden = true;
        })
    }
    
    //MARK: - Login Viewcontroller Protocol
    // Load controllers based on menu selection
    func loadSubViewControllers(controller:JSSubViewControllers) {
        
        homeNavigationController?.topViewController?.removeFromParentViewController()//Removing current view controller
        
        switch controller {
            
        case .homeViewController:
            let homeViewController = storyboard?.instantiateViewController(withIdentifier: JSControllerIdentifer.homeViewControllerIdentifier.rawValue) as? JSHomeViewController
            homeViewController?.delegate = self
            homeNavigationController?.pushViewController(homeViewController!, animated: true)
            
        case .suggestTrainingViewController:
            let suggestATrainingViewController = storyboard?.instantiateViewController(withIdentifier: JSControllerIdentifer.suggestTrainingViewController.rawValue) as? JSSuggestTrainingViewController
            suggestATrainingViewController?.delegate = self
            homeNavigationController?.pushViewController(suggestATrainingViewController!, animated: true)
            
        case .historyViewController:
            let historViewController = storyboard?.instantiateViewController(withIdentifier: JSControllerIdentifer.historyViewController.rawValue) as? JSTrainingHistoryViewController
            historViewController?.delegate = self
            homeNavigationController?.pushViewController(historViewController!, animated: true)
            break
            
        case .aboutViewController:
            let aboutViewController = storyboard?.instantiateViewController(withIdentifier: JSControllerIdentifer.aboutViewController.rawValue) as? JSAboutViewController
            aboutViewController?.delegate = self
            homeNavigationController?.pushViewController(aboutViewController!, animated: true)
            
        case .helpViewController:
            
            let helpViewController = storyboard?.instantiateViewController(withIdentifier: JSControllerIdentifer.helpViewControllerIdentifier.rawValue) as? JSHelpViewController
            helpViewController?.delegate = self
            homeNavigationController?.pushViewController(helpViewController!, animated: true)
            
        }
    }
    
    //MARK: - Reset login page
    // Reset login page after logout
    func resetLoginPageAfterLogout() {
        
        userName.text = ""
        password.text = ""
        overlayView?.removeFromSuperview()
        
        homeNavigationController?.viewControllers.removeAll()
        menuNavigationController?.viewControllers.removeAll()
        menuNavigationController?.view?.removeFromSuperview()
        //        menuNavigationController?.removeFromParentViewController()
        homeNavigationController?.view?.removeFromSuperview()
        //        homeNavigationController?.removeFromParentViewController()
    }
    
}
