//
//  JSEvent.swift
//
//
//  Created by ajaybabu singineedi on 30/11/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import Foundation

//MARK:- Training Schedule
struct JSSchedule {
    var location = JSDefaultValues.defaultStringValue
    var startDate = JSDefaultValues.defaultStringValue
    var endDate = JSDefaultValues.defaultStringValue
    
    /// Converts dictionary to model
    ///
    /// - Parameter inputDictionary: Dictionary from response
    /// - Returns: model
    init(inputDictionary: JSONDictionary? = nil) {
        guard let responseDict = inputDictionary else {
            return
        }
        location = responseDict[JSTrainingModelKey.location.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        startDate = responseDict[JSTrainingModelKey.startDate.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        endDate = responseDict[JSTrainingModelKey.endDate.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        
    }
    
}

//MARK:- Training information
struct  JSTraining {
    
    var id = JSDefaultValues.defaultIntValue
    var title = JSDefaultValues.defaultStringValue
    var description = JSDefaultValues.defaultStringValue
    var emailNote = JSDefaultValues.defaultStringValue
    var image = JSDefaultValues.defaultStringValue
    
    /// Converts dictionary to model
    ///
    /// - Parameter inputDictionary: Dictionary from response
    /// - Returns: model
    init(inputDictionary: JSONDictionary? = nil) {
        guard let responseDict = inputDictionary else {
            return
        }
        id = responseDict[JSTrainingModelKey.trainingId.rawValue] as? Int ?? JSDefaultValues.defaultIntValue
        title = responseDict[JSTrainingModelKey.title.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        description = responseDict[JSTrainingModelKey.description.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        emailNote = responseDict[JSTrainingModelKey.emailNote.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        image = responseDict[JSTrainingModelKey.image.rawValue] as? String ?? JSDefaultValues.defaultStringValue
    }
}

//MARK:- Mail notification
struct JSNotification {
    
    var type = JSDefaultValues.defaultStringValue
    var subject = JSDefaultValues.defaultStringValue
    var content = JSDefaultValues.defaultStringValue
    var rcpType = JSDefaultValues.defaultStringValue
    var ccListId = [JSDefaultValues.defaultStringValue]
    
    /// Converts Dictionary to model
    ///
    /// - Parameter inputDictionary: input dictionary
    /// - Throws: error
    init(withData: Any? = nil) {
        guard let responseDict = withData as? JSONDictionary else {
            return
        }
        type = responseDict[JSNotificationModelKey.type.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        subject = responseDict[JSNotificationModelKey.subject.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        content = responseDict[JSNotificationModelKey.content.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        rcpType = responseDict[JSNotificationModelKey.rcpType.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        if let ccList = responseDict[JSNotificationModelKey.ccListId.rawValue] as? [String] {
            for id in ccList {
                ccListId.append(id)
            }
        }
    }
    
    ///Converts model to Dictionary
    func modelData() -> JSONDictionary {
        var result = JSONDictionary()
        result[JSNotificationModelKey.type.rawValue] = type as AnyObject?
        result[JSNotificationModelKey.subject.rawValue] = subject as AnyObject?
        result[JSNotificationModelKey.content.rawValue] = content as AnyObject?
        result[JSNotificationModelKey.rcpType.rawValue] = rcpType as AnyObject?
        result[JSNotificationModelKey.ccListId.rawValue] = ccListId as AnyObject?
        return result
    }
}

//MARK:- Event Information
class JSEvent  {
    
    var training = JSTraining()
    var trainerList = [JSEmployee]()
    var trainees = [JSTrainee]()
    var schedule = [JSSchedule]()
    var notification = JSNotification()
    
    /// Converts dictionary to model
    ///
    /// - Parameter inputDictionary: Dictionary from response
    /// - Returns: model
    init(inputDictionary: JSONDictionary? = nil) {
        guard let responseDict = inputDictionary else {
            return
        }
        if let training = responseDict[JSEventModelKey.training.rawValue] as? JSONDictionary {
            self.training = JSTraining(inputDictionary: training)
        }
        if let notification = responseDict[JSEventModelKey.notification.rawValue] as? JSONDictionary {
            self.notification = JSNotification(withData: notification)
        }
        
        /* if let trainerList = responseDict[EventModelKey.trainerList.rawValue] as? JSONDictionary {
         self.trainerList = [JSEmployee(inputDictionary: trainerList)]
         }
         if let trainees = responseDict[EventModelKey.traineesList.rawValue] as? JSONDictionary {
         self.trainees = [JSTrainee(inputDictionary: trainees)]
         }
         if let schedule = responseDict[EventModelKey.schedule.rawValue] as? JSONDictionary {
         self.schedule = [JSSchedule(inputDictionary: schedule)]
         }*/
        
        if let trainers = responseDict[JSEventModelKey.trainerList.rawValue] as? [JSONDictionary] {
            var trainerArray = [JSEmployee]()
            for trainer in trainers {
                trainerArray.append( JSEmployee(inputDictionary: trainer))
            }
            self.trainerList = trainerArray
        }
        
        if let trainees = responseDict[JSEventModelKey.traineesList.rawValue] as? [JSONDictionary] {
            var traineeArray = [JSTrainee]()
            for trainee in trainees {
                traineeArray.append( JSTrainee(inputDictionary: trainee))
            }
            self.trainerList = traineeArray
        }
        
        if let schedules = responseDict[JSEventModelKey.schedule.rawValue] as? [JSONDictionary] {
            var scheduleArray = [JSSchedule]()
            for schedule in schedules {
                scheduleArray.append( JSSchedule(inputDictionary: schedule))
            }
            self.schedule = scheduleArray
        }
    }
}

//MARK:- Event infromation
class JSEventInfo {
    
    var trainingId  = JSDefaultValues.defaultIntValue
    var trainingName = JSDefaultValues.defaultStringValue
    var image = JSDefaultValues.defaultStringValue
    var schedule = JSSchedule()
    var seats = JSDefaultValues.defaultIntValue
    
    /// Converts dictionary to model
    ///
    /// - Parameter inputDictionary: Dictionary from response
    /// - Returns: model
    init(inputDictionary: JSONDictionary? = nil) {
        guard let responseDict = inputDictionary else {
            return
        }
        trainingId = responseDict[JSTrainingModelKey.trainingId.rawValue] as? Int ?? JSDefaultValues.defaultIntValue
        trainingName = responseDict[JSTrainingModelKey.title.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        image = responseDict[JSTrainingModelKey.image.rawValue] as? String ?? JSDefaultValues.defaultStringValue
        seats = responseDict[JSTrainingModelK, ey.seats.rawValue] as? Int ?? JSDefaultValues.defaultIntValue
        if let schedule = responseDict[JSEventModelKey.schedule.rawValue] as? JSONDictionary {
            self.schedule = JSSchedule(inputDictionary: schedule)
        }
    }
}

//MARK:- Event Information
class Employee {
    
    let name: Name
    let id: String
    var isSelected: Bool
    var isNominated = false
    init(newName: Name, newId: String, newIsSelected: Bool) {
        name = newName
        id = newId
        isSelected = newIsSelected
    }
}




