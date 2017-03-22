//
//  JSEmployee.swift
//  Jigyasa
//
//  Created by ajaybabu singineedi on 30/11/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.

import Foundation
var loggedInEmployee: JSEmployee?

//MARK:- Emplyoee protocol
protocol JSEmployeeProtocol {
    
    var id: String {get set}
    var name: Name {get set}
    var details: EmployeeInfo {get set}
    //var manager: JSEmployeeProtocol {get set}
    var reporters: [JSEmployeeProtocol]? {get set}
}

//MARK:- Name structure
struct Name {
    
    var firstName = JSDefaultValues.defaultStringValue
    var lastName = JSDefaultValues.defaultStringValue
    
    /// Converts Dictionary to model
    ///
    /// - Parameter inputDictionary: input dictionary
    /// - Throws: error
    init(inputDictionary: JSONDictionary? = nil) {
        guard let responseDict = inputDictionary else{
            return
        }
        firstName = responseDict[JSEmployeeModelKey.firstName.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        lastName = responseDict[JSEmployeeModelKey.lastName.rawValue] as? String ?? JSDefaultValues.defaultStringValue
    }
}

extension Name {
    
    var fullName: String {
        return firstName + " " + lastName
    }
}

//MARK:- Employees Details Structure
struct EmployeeInfo {
    
    var emailId = JSDefaultValues.defaultStringValue
    var password = JSDefaultValues.defaultStringValue
    var userName = JSDefaultValues.defaultStringValue
    var phoneNumber = JSDefaultValues.defaultStringValue
    var projectName = JSDefaultValues.defaultStringValue
    var officeBaseLocation = JSDefaultValues.defaultStringValue
    var officeCurrentLocation = JSDefaultValues.defaultStringValue
    var designation = JSDefaultValues.defaultStringValue
    var managerId = JSDefaultValues.defaultStringValue
    
    /// Converts Dictionary to model
    ///
    /// - Parameter inputDictionary: input dictionary
    /// - Throws: error
    init(inputDictionary: JSONDictionary? = nil) {
        guard let responseDict = inputDictionary else {
            return
        }
        emailId = responseDict[JSEmployeeModelKey.emailId.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        password = responseDict[JSEmployeeModelKey.password.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        userName = responseDict[JSEmployeeModelKey.userName.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        phoneNumber = responseDict[JSEmployeeModelKey.phoneNumber.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        projectName = responseDict[JSEmployeeModelKey.projectName.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        officeBaseLocation = responseDict[JSEmployeeModelKey.officeBaseLocation.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        officeCurrentLocation = responseDict[JSEmployeeModelKey.officeCurrentLocation.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        designation = responseDict[JSEmployeeModelKey.designation.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        managerId = responseDict[JSEmployeeModelKey.managerId.rawValue] as? String ?? JSDefaultValues.defaultStringValue
    }
}

//MARK:- Employee class
class JSEmployee : JSEmployeeProtocol {
    
    var id = JSDefaultValues.defaultStringValue
    var name  = Name()
    var details = EmployeeInfo()
    //var manager: JSEmployeeProtocol
    var reporters: [JSEmployeeProtocol]? = nil
    
    /// Converts Dictionary to model
    ///
    /// - Parameter inputDictionary: input dictionary
    /// - Throws: error
    init(inputDictionary: JSONDictionary? = nil) {
        guard let responseDict = inputDictionary else{
            return
        }
        id = responseDict[JSEmployeeModelKey.employeeId.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        if let name = responseDict[JSEmployeeModelKey.name.rawValue] as? JSONDictionary {
            self.name = Name(inputDictionary: name)
        }
        if let details = responseDict[JSEmployeeModelKey.details.rawValue] as? JSONDictionary {
            self.details = EmployeeInfo(inputDictionary: details)
        }
        //reporters = try JSEmployee(inputDictionary: json[EmployeeModelKey.re])
        if let reporters = responseDict[JSEmployeeModelKey.reporters.rawValue] as? [JSONDictionary] {
            var reporterArray = [JSEmployee]()
            for reporter in reporters {
                reporterArray.append( JSEmployee(inputDictionary: reporter))
            }
            self.reporters = reporterArray
        }
    }
}

//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//MARK:- Trainee class
class JSTrainee : JSEmployee {
    
    var isAttended = false
    
    override init(inputDictionary: JSONDictionary? = nil) {
        guard let responseDict = inputDictionary else{
            super.init()
            return
        }
        super.init(inputDictionary: responseDict)
        isAttended = responseDict[JSEmployeeModelKey.isAttended.rawValue] as? Bool ?? false
    }
}



