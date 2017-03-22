//
//  ViewController.swift
//  Jigyasa
//
//  Created by basagond a mugganavar on 24/11/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

//let defaults = UserDefaults.standard //basu: To store userName


class JSLogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var homeViewController: UINavigationController!
    
    var isMenuHidden = false
    var menuNavigationController: UINavigationController?
    var homeNavigationController: UINavigationController?
    var overlayView: UIView?
    
    //var activityIndicator = JSActivityIndicator()
    
    let loggedInUserDefaults = JSUserDefaults()
    
    //MARK:- Default Method
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        userName.delegate = self
        password.delegate = self
        password.addTarget(self, action:#selector(JSLogInViewController.textDidChange(text:)) , for: .editingChanged)
        userName.addTarget(self, action:#selector(JSLogInViewController.textDidChange(text:)) , for: .editingChanged)
        
        if let userName = loggedInUserDefaults.getUserName() {
            print(userName)
            updateUI()
        }
    }
    
    //MARK:- Button Actions
    @IBAction func loginAction(_ sender: Any) {
        
        view.endEditing(true)
        // Add activity indicator
        //activityIndicator = JSActivityIndicator(frame: self.view.frame)
        //activityIndicator.startAnimating()
        //self.view.window?.addSubview(activityIndicator)
        
        var uName: String!
        
        if let userName = userName.text  {
            uName = userName
            if let range = uName.range(of: "@exilant.com", options: .caseInsensitive) {
                
                uName.removeSubrange(range)
            }
            
        }
        
        //Creating post body for login service
        let postbody = [
            JSEmployeeModelKey.userName.rawValue: uName ?? "",
            JSEmployeeModelKey.password.rawValue: password.text!
        ]
                
        JSServiceRequestManager.sharedManager().dataTaskWithURL(postBody: postbody, urlEndString: JSServiceEndPoints.loginUser.rawValue, completionHandler: { (employeeInformation) in
            
            //self.activityIndicator.stopAnimating()
            //self.activityIndicator.removeFromSuperview()
            
            if let alertMessage = employeeInformation[JSResponseKey.errorMessage.rawValue] as? String {
                
                self.showAlert(message: alertMessage)
            }
            
            if let status = employeeInformation[JSResponseKey.status.rawValue] as? [String: Any] {
                
                print("status: ", status)
                if let statusCode = status[JSResponseKey.statusCode.rawValue] as? String {
                    if statusCode == JSResponseKey.successCode.rawValue {
                        self.loggedInUserDefaults.set(self.userName.text, forKey: JSEmployeeModelKey.userName.rawValue)
                        
                        self.updateUI()
                    } else if statusCode == JSResponseKey.badRequestCode.rawValue {
                        
                        self.showAlert(message: JSErrorMessage.loginFailMessage.rawValue)
                    }
                }
            } else {
                self.showAlert(message: JSErrorMessage.properCredentials.rawValue)
            }
            
        })
        //loggedInUserDefaults.set(self.userName.text, forKey: EmployeeModelKey.userName.rawValue)
        //loggedInUserDefaults.set(self.password.text, forKey: EmployeeModelKey.userName.rawValue)
        //loggedInUserDefaults.updateUserName(userName: self.userName.text!)
        //self.updateUI()
        
        //}
        //updateUI()
    }
    
    public func textDidChange(text:UITextField) {
        
        guard let name = userName.text,!name.isEmpty,
            let pass = password.text, !pass.isEmpty else {
                
                loginButton.isEnabled =  false
                loginButton.alpha = 0.5
                
                return
        }
        
        loginButton.isEnabled =  true
        loginButton.alpha = 1
    }
    
    // MARK: - Textfield Deligate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- Instance Methods
    
    
    /// Alert indication
    ///
    /// - Parameter message: alert description
    func showAlert(message: String) {
        
        let alertController = UIAlertController(title: JSErrorMessage.errorAlertTitle.rawValue, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: JSButtonTitle.okButtonTitle.rawValue, style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func updateUI() {
        
        overlayView = UIView(frame: view.frame)
        overlayView?.backgroundColor = UIColor().menuBackgrounColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(JSLogInViewController.tapGestureAction(_:)))
        overlayView?.addGestureRecognizer(tapGesture)
        
        //Initializing Menu Navigation Controller
        initializeMenuNavigationContoller()
        hideMenuViewController()
        
        //Initializing Root Navigation Controller
        initializeRootNavigationContoller()
    }
    
    
    //MARK :- Tap Gesture Method
    
    func tapGestureAction(_ sender: UITapGestureRecognizer) {
        hideMenuViewController()
    }
    
    //MARK:- Orientation Method
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if isMenuHidden {
            menuNavigationController?.view.frame = CGRect(x: -(view.frame.size.width/2 + JSCGFloatValue.menuTableViewWidthOffeset.rawValue), y: 0, width: view.frame.size.width/2 + JSCGFloatValue.menuTableViewWidthOffeset.rawValue, height:view.frame.height)
            
        } else {
            menuNavigationController?.view.frame = CGRect(x: 0, y: 0, width: (view.frame.size.width/2 + JSCGFloatValue.menuTableViewWidthOffeset.rawValue) , height: view.frame.height)
            
        }
        overlayView?.frame = view.frame
        
        //While changing orientation, navigation bar height was not changing
        menuNavigationController?.setNavigationBarHidden(true, animated: false)
        menuNavigationController?.setNavigationBarHidden(false, animated: false)
        
        homeNavigationController?.setNavigationBarHidden(true, animated: false)
        homeNavigationController?.setNavigationBarHidden(false, animated: false)
    }
}

