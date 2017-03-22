//
//  LogoutTableViewController.swift
//  sideMenu
//
//  Created by manohara reddy p on 12/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSSuggestTrainingViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet private weak var courseTitle: UITextField!
    @IBOutlet private weak var courseDescription: UITextView!
    @IBOutlet private weak var suggest: UIBarButtonItem!
    @IBOutlet private weak var commentPlaceholder: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var delegate: JSMenuTableViewControllerProtocol?
    
    //MARK: Default Method
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        courseTitle.delegate = self
        courseDescription.delegate = self
        courseTitle.addTarget(self, action:#selector(JSSuggestTrainingViewController.updateSuggest) , for: UIControlEvents.editingChanged)
    }
    
    //MARK: Instance Method
    // update the textbutton according to text in trainingName or addComment
    func updateSuggest() {
        
        if let text = courseTitle.text?.isEmpty,!text,!courseDescription.text.isEmpty {
            suggest.isEnabled =  true
        } else {
            suggest.isEnabled =  false
        }
    }
    
    //Request alert
    private func presentConformationAlert() {
        
        let alertController = UIAlertController(title: JSSuggestTrainingMessage.title.rawValue,
                                                message: JSSuggestTrainingMessage.message.rawValue,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: JSButtonTitle.okButtonTitle.rawValue,
                                     style: .default) { (alert) in
                                        
                                        self.postNewSuggestion()
                                    }
        let cancelAction = UIAlertAction(title: JSButtonTitle.cancelButtonTitle.rawValue,
                                         style: .default,
                                         handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func postNewSuggestion(){
       
        activityIndicator.startAnimating()
        suggest.isEnabled = false
        
        let postbody = [
            JSTrainingModelKey.title.rawValue: courseTitle.text!,
            JSTrainingModelKey.description.rawValue: courseDescription.text!,
            JSEmployeeModelKey.employeeId.rawValue: "4306"
        ]
        
        let requestManager = JSServiceRequestManager.sharedManager()
        requestManager.dataTaskWithURL(postBody: postbody,
                                       urlEndString: JSServiceEndPoints.suggestTraining.rawValue)
        { (responce) in
        
            self.activityIndicator.stopAnimating()
            
            if let responce = responce[JSResponseKey.status.rawValue] as? String {
                
                self.presentSuccessAlert(title:responce, message: "\(self.courseTitle.text!) posted successfully")
                
            } else if let responce = responce[JSResponseKey.errorMessage.rawValue] as? String {
                
               self.presentSuccessAlert(title:responce, message: "\(self.courseTitle.text!) posted successfully")
                self.suggest.isEnabled = true
            }
        }
    }
    
    
    //Request alert
    private func presentSuccessAlert(title: String,message: String) {
        
        let alertController = UIAlertController(title:title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: JSButtonTitle.okButtonTitle.rawValue,
                                     style: .default)
        { (alert) in
            
            self.courseTitle.text = JSDefaultValues.defaultStringValue
            self.courseDescription.text = JSDefaultValues.defaultStringValue
            self.commentPlaceholder.isHidden = false
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Menu button action
    @IBAction private func MenuButtonAction(_ sender: UIBarButtonItem) {
        
        // To dismiss keyboard
        view.endEditing(true)
        // show menu
        delegate?.showMenuViewController()
    }
    
    @IBAction private func suggestNewTraining(_ sender: UIButton) {
        
        view.endEditing(true)
        presentConformationAlert()
    }
    
    // MARK: - Textfield delegate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:- UITextView Delegate Method
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Hide the keyboard.
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        updateSuggest()
        // placeholder for textview enable according to validation
        commentPlaceholder.isHidden = textView.text.isEmpty ? false : true
    }
}






