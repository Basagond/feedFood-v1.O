//
//  JSAddNewTrainingViewController.swift
//  Jigyasa
//
//  Created by ajaybabu singineedi on 30/11/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit


class JSAddNewTrainingViewController: UITableViewController, UITextFieldDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{
    
    @IBOutlet weak var course: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var startDate: UITextField!
    @IBOutlet weak var trainer: UITextField!
    @IBOutlet weak var seats: UITextField!
    @IBOutlet weak var link: UITextField!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var trainingDescription: UITextView!
    @IBOutlet weak var emailDescription: UITextView!
    @IBOutlet weak var endDate: UITextField!
    
    // Notify by mail options to change status
    @IBOutlet weak var immediately: UIButton!
    @IBOutlet weak var atDefaultScheduledTime: UIButton!
    
    //placeholders in textview
    @IBOutlet weak var addComments: UILabel!
    @IBOutlet weak var mailDescription: UILabel!
    
    @IBOutlet weak var addTrainers: UIButton!
    
    // Recipients to change status
    @IBOutlet weak var selectManagers: UIButton!
    @IBOutlet weak var allEmployees: UIButton!
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    private var datePickerView: UIDatePicker?
    
    // Configure textfields and textview
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        // Add target to inform whenever text changes
        course.addTarget(self, action:#selector(JSAddNewTrainingViewController.updateDone) , for: .editingChanged)
        location.addTarget(self, action:#selector(JSAddNewTrainingViewController.updateDone) , for: .editingChanged)
        trainer.addTarget(self, action:#selector(JSAddNewTrainingViewController.updateDone) , for: .editingChanged)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        startDate.resignFirstResponder()
        endDate.resignFirstResponder()
    }
    
    func updateDone() {
        
        if course.text!.isEmpty || location.text!.isEmpty || trainer.text!.isEmpty
          || trainingDescription.text.isEmpty || emailDescription.text.isEmpty {
            doneButton.isEnabled = false
        } else {
            doneButton.isEnabled = true
        }
    }
    
    //Hardcoded data removed after service integration
    var selectedTrainers = [
        
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"A S Rekha", JSEmployeeModelKey.lastName.rawValue: "Prakash"]), newId: "1748", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Anil Kumar", JSEmployeeModelKey.lastName.rawValue: "B M"]), newId: "3449", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Chetan", JSEmployeeModelKey.lastName.rawValue: "H"]), newId: "2408", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Debasis", JSEmployeeModelKey.lastName.rawValue: "Mishra"]), newId: "2107", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Disha Anana", JSEmployeeModelKey.lastName.rawValue: "Sehgal"]), newId: "2527", newIsSelected: false),
        Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Hemantha", JSEmployeeModelKey.lastName.rawValue: "Kumar E"]), newId: "1605", newIsSelected: false)
        
    ]
    
    var selectedManagers = [
        
    Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"A S Rekha", JSEmployeeModelKey.lastName.rawValue: "Prakash"]), newId: "1748", newIsSelected: false),
    Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Anil Kumar", JSEmployeeModelKey.lastName.rawValue: "B M"]), newId: "3449", newIsSelected: false),
    Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Chetan", JSEmployeeModelKey.lastName.rawValue: "H"]), newId: "2408", newIsSelected: false),
    Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Debasis", JSEmployeeModelKey.lastName.rawValue: "Mishra"]), newId: "2107", newIsSelected: false),
    Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Disha Anana", JSEmployeeModelKey.lastName.rawValue: "Sehgal"]), newId: "2527", newIsSelected: false),
    Employee(newName: Name(inputDictionary: [JSEmployeeModelKey.firstName.rawValue:"Hemantha", JSEmployeeModelKey.lastName.rawValue: "Kumar E"]), newId: "1605", newIsSelected: false)
    ]
    
    private func updateUI(){
        
        configure(textField: course)
        configure(textField: location)
        configure(textField: startDate)
        configure(textField: endDate)
        configure(textField: trainer)
        configure(textField: seats)
        configure(textField: link)
        configure(textView: trainingDescription)
        configure(textView: emailDescription)
        configure()
        trainingDescription.delegate = self
        emailDescription.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayTrainers()
    }
    
    // MARK: - Display trainers
    private func displayTrainers(){
        
        let trainers = selectedTrainers.filter{$0.isNominated == true}
        var trainerText = JSDefaultValues.defaultStringValue
        
        if trainers.count > 2 {
            
            trainerText = "\(trainers[0].name.fullName), " +
                "\(trainers[1].name.fullName) "  +
            "and \(trainers.count - 2) More"
        } else if trainers.count == 2 {
            
            trainerText =   "\(trainers[0].name.fullName), " +
            "\(trainers[1].name.fullName)"
        } else if trainers.count == 1 {
            
            trainerText =  "\(trainers[0].name.fullName)"
        }
        
        trainer.text = trainerText
    }
    
    // MARK: - congfigure textField method
    private func configure(textField:UITextField) {
        
        textField.borderStyle = .none
        textField.background = #imageLiteral(resourceName: "BottomLine")
        textField.delegate = self
    }
    
    // MARK: - congfigure textView method
    private func configure(textView:UITextView) {
        
        textView.layer.borderColor = UIColor.darkGray.cgColor
        textView.layer.borderWidth = JSCGFloatValue.suggestTrainingBorderWidth.rawValue
    }
    
    // MARK: - Congfigure datePicker
    private func configure() {
        
        datePickerView  = UIDatePicker()
        let minDate = Date() // Todays date
        var components = DateComponents()
        components.month = 6
        let maxDate = Calendar(identifier: .gregorian).date(byAdding: components, to: minDate)
        datePickerView?.minimumDate = minDate
        datePickerView?.maximumDate = maxDate
        startDate.inputView = datePickerView
        endDate.inputView = datePickerView
        datePickerView?.addTarget(self, action:#selector(JSAddNewTrainingViewController.handleDatePicker(sender:)), for: .valueChanged)
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "MMM d, yyyy h:mm a"
        
        if startDate.isFirstResponder {
            
            startDate.text = timeFormatter.string(from: sender.date)
        } else if endDate.isFirstResponder {
            
            endDate.text = timeFormatter.string(from: sender.date)
        }
    }
    
    // MARK: - Select image from photoLibrary
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
       
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: - Notify by mail method
    @IBAction func notifyByMail(_ sender: UIButton) {
        
        if sender.tag == 0 {
            
            immediately.setImage(#imageLiteral(resourceName: "Circle"), for: .normal)
            atDefaultScheduledTime.setImage(#imageLiteral(resourceName: "CircleEmpty"), for: .normal)
        } else {
            
            immediately.setImage(#imageLiteral(resourceName: "CircleEmpty"), for: .normal)
            atDefaultScheduledTime.setImage(#imageLiteral(resourceName: "Circle"), for: .normal)
        }
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        
       view.endEditing(true)
        if validateUserInfomation() {
           // Service call to send date to server
            dismiss(animated: true, completion: nil)
        }
    }

     // MARK: - validate user infomation
    func validateUserInfomation()-> Bool {
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "MMM d, yyyy h:mm a"
        
        guard let start = startDate.text,!start.isEmpty,let end = endDate.text, !end.isEmpty else {
            showAlert(message: "Please Enter start and end date")
            return false
        }
        
        if let strartDate = timeFormatter.date(from: start), let endDate = timeFormatter.date(from: end){
            if strartDate > endDate {
                showAlert(message: "The start date must be before the end date.")
                return false
            }
        }
        return true
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: JSErrorMessage.errorAlertTitle.rawValue, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: JSButtonTitle.okButtonTitle.rawValue, style: .default, handler: nil)
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Select recipients method
    @IBAction func selectRecipients(_ sender: UIButton) {
        
        if sender.tag == 0 {
            
            selectManagers.setImage(#imageLiteral(resourceName: "Circle"), for: .normal)
            allEmployees.setImage(#imageLiteral(resourceName: "CircleEmpty"), for: .normal)
        } else {
            
            allEmployees.setImage(#imageLiteral(resourceName: "Circle"), for: .normal)
            selectManagers.setImage(#imageLiteral(resourceName: "CircleEmpty"), for: .normal)
        }
    }
    
    // MARK: - Textview Deligate method
    // Dismiss keyboard when return key pressed in keyboard for textview
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    // MARK: - Textfield Deligate method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if startDate.isFirstResponder || endDate.isFirstResponder{
            // Date formate to display in datae picker for start and end date
            datePickerView?.datePickerMode = .dateAndTime
        }
        return true
    }
    
    // MARK: - Textfield Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if trainer.isFirstResponder {
            
            performSegue(withIdentifier: "addTrainers", sender: nil)
            trainer.resignFirstResponder()
        }
        
        if location.isFirstResponder {
            
            performSegue(withIdentifier: "location", sender: nil)
            location.resignFirstResponder()
        }
    }

    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    // Set addImage to display the selected image.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        addImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    //MAEK:- UITextView Delegate Method
    func textViewDidChange(_ textView: UITextView) {
        
        updateDone()
        // Placeholder text for UITextView
        addComments.isHidden = trainingDescription.text.isEmpty ? false : true
        mailDescription.isHidden = emailDescription.text.isEmpty ? false : true
    }
    
    //MAEK:- Cancel `UIBarButtonItem` action
    @IBAction func backToLanding(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MAEK:- unwindFromLocation 
    // Take selected location and update in location text field
    @IBAction func unwindFromLocation(_ segue: UIStoryboardSegue) {
    
        if let source = segue.source as?  JSLocationViewController {
            location.text = source.selectedLocation
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addMangerViewController = segue.destination as? JSAddManagerViewController {
            
            if segue.identifier == "addTrainers" {
                
                addMangerViewController.selectedCourseTitle = "Select Trainer"
                addMangerViewController.employees = selectedTrainers
            } else if segue.identifier == "addManagers" {
                
                addMangerViewController.selectedCourseTitle = "Select Manager(s)"
                addMangerViewController.employees = selectedManagers
            }
        }
    }
}
