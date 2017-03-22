//
//  JSConstants.swift
//  Jigyasa
//
//  Created by ajaybabu singineedi on 24/11/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

//Dictionary
typealias JSONDictionary = [String: Any]
let jigyasaBaseUrl: String = "http://10.2.2.51:8085/Jigyasa"//Local URL
//let jigyasaBaseUrl: String = "http://10.2.2.51:8085/Jigyasa"//Remote URL

//MARK:- Controllers Identifier
enum JSControllerIdentifer: String {
    case mainStoryboardName = "Main"
    case homeNavigationControllerIdentifier = "JSHomeNavigationControllerIdentifier"
    case homeViewControllerIdentifier = "JSHomeViewControllerIdentifier"
    case menuNavigationControllerIdentifier = "JSMenuNavigationControllerIdentifier"
    case menuTableViewControllerIdentifier = "JSMenuTableViewControllerIdentifier"
    case suggestTrainingViewController = "JSSuggestTrainingViewControllerIdentifier"
    case helpViewControllerIdentifier = "JSHelpViewControllerIdentifier"
    case aboutViewController = "JSAboutViewControllerIdentifier"
    case historyViewController = "JSTrainingHistoryViewController"
}

enum JSCellIdentifiers: String {
    case menuTableCellIdentifier = "JSMenuCellIdentifier"
    case trainingCellIdentifier = "TrainingCellIdentifier"
    case suggestionTrainingCellIdentifier = "SuggestionTrainingCellIdentifier"
    case trainingGroupHeaderCellIdentifier = "TraingGroupHeaderCellIdentifier"
    case trainingHistoryCellIdentifier = "TrainingHistoryCellIdentifier"
    case locationCellIdentifier = "locationCell"
    case addManagerIdentifier = "AddEmployee"
}

// MARK:- Button title constants
enum JSButtonTitle: String {
    case okButtonTitle = "OK"
    case cancelButtonTitle = "Cancel"
}

// MARK:- Error/Alert constants
enum JSErrorMessage: String {
    case errorAlertTitle = "Whoops!"
    case status = "status"
    case errorMessage = "errorMessage"
    case loginFailMessage = "Username and Password does not match"
    case properCredentials = "Please provide EXILANT credentials"
    case noDataMessage = "Problem in receiving data"
    case dataCovertionErrorMessage = "Problem in converting JSON data"
//    case errorCode = "errorCode"
//    case noDataAccessAlertTitle = "No Access"
//    case serverErrorMessage = "Server error.\nPlease try again later."
//    case jsonSerializationErrorMessage = "JSON Serialization Error!"
//    case failAlertTitle = "Failed"
//    case successTitle = "Success"
//    case usernameMissing = "Username is missing"
//    case passwordMissing = "Password is missing"
}

// MARK:- Response  constants
enum JSResponseKey: String {
    case status
    case errorMessage
    case statusCode
    case badRequestCode = "404"
    case successCode = "200"
}

// MARK:- Default Values
struct JSDefaultValues {
    static let defaultStringValue: String = ""
    static let defaultIntValue: Int = 0
    static let defaultDoubleValue: Double = 0.0
    static let defaultDateValue: Date = Date()
    //static let defaultDataValue: Data = nil
    static let defaultSearchBar = CGRect(x: CGFloat(0.0), y: CGFloat(0.0), width: CGFloat(320.0), height: CGFloat(44.0))
}

// MARK: - Employee Detail Constants
enum JSEmployeeModelKey: String {
    case employeeId
    case firstName
    case lastName
    case emailId
    case userName
    case phoneNumber
    case projectName
    case officeBaseLocation
    case officeCurrentLocation
    case designation
    case isAttended
    case password
    case details
    case name
    case reporters
    case managerId
}

// MARK: - Notification Detail Constants
enum JSNotificationModelKey: String {
    case type
    case subject
    case content
    case rcpType
    case ccListId
}

// MARK: - Training Detail Constants
enum JSEventModelKey: String {
    case training
    case trainerList
    case traineesList
    case schedule
    case notification
}

// MARK: - Training Detail Constants
enum JSTrainingModelKey: String {
    case trainingId
    case title
    case description
    case emailNote
    case image
    case location
    case startDate
    case endDate
    case seats
}

// MARK: - Service Configuration Constants
enum JSServerConfiguration: String {
    case jigyasaKeysPlistName = "Jigyasa"
    case appRouteLocal = "appRouteLocal"
    case isLocalKey = "isLocal"
    case appRouteRemote = "appRouteRemote"
}

enum JSHTTPHeaderContentTypeValues : String {
    case json = "application/json"
}

enum JSHTTPHeaderFields : String {
    case contentType = "Content-Type"
    case accept = "Accept"
}

// MARK: - Service Detail Constants
enum JSServiceEndPoints: String {
    case loginUser = "Login"
    case trainingList = "TrainingList"
    case suggestTraining = "SuggestTraining"
    case trainingDetails = "TrainingDetails"
}

// MARK:- Protocol Declaration
protocol JSMenuTableViewControllerProtocol: class{
    func showMenuViewController()
    func hideMenuViewController()
}

protocol JSTrainingHistoryProtocol {
    func onReferenceLinkTouch(hyperLink link:String?)
}

protocol JSAccordianPortocol {
    func onTouchUpInside(forHeader header:JSTrainingGroupHeaderTableViewCell, withIndex index: Int)
}

protocol JSLogInViewControllerProtocol {
    func loadSubViewControllers(controller:JSSubViewControllers)
    func resetLoginPageAfterLogout()
}

//MARK: - View Controllers
enum JSSubViewControllers: String {
    case homeViewController
    case suggestTrainingViewController
    case historyViewController
    case aboutViewController
    case helpViewController
}

// MARK:- Constant Value
enum JSCGFloatValue:CGFloat {
    case menuTableViewWidthOffeset = 20.0
    case suggestTrainingCornerRadius = 5.0
    case suggestTrainingBorderWidth = 1.0
}


// MARK:- Logout message
enum JSLogoutMessage: String {
    case title = "Log out"
    case message = "Are you sure you want to log out?"
}

enum JSSuggestTrainingMessage: String {
    case title = "Your suggestion will be sent to the training department."
    case message = "\nThis training will scheduled after its approval."
}

// MARK: - SideMenu Constants
enum JSSideMenu: String {
    case home = "Home"
    case suggest = "Suggest a training"
    case history = "History"
    case about = "About"
    case help = "Help"
    case logout = "Logout"
}

// MARK: - SuggestTraining Placeholder Constants
//enum JSSTPlaceHolder: CGFloat {
//    case XPosition = 5
//    case YPosition = 0
//    case Width = 100
//    case Hight = 30
//    case FontSize = 14
//}

//enum JSSTPlaceHolderText: String {
//    case Text = "Add comment"
//}

// MARK: - HomeViewController Constants
enum JSHomeViewControllerConstants: String {
    case kDownArrow = "DownArrow"
    case kRightArrow = "RightArrow"
}
