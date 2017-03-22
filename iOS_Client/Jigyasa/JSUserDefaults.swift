//
//  JSUserDefaults.swift
//  Jigyasa
//
//  Created by annapurna chandra on 19/01/17.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSUserDefaults: UserDefaults {

    func updateUserName(userName: String) {
     self.set(userName, forKey: JSEmployeeModelKey.userName.rawValue)
    }
    
    func getUserName() -> String? {
       return self.string(forKey: JSEmployeeModelKey.userName.rawValue)
    }
    
    func deleteUserName() {
        self.removeObject(forKey: JSEmployeeModelKey.userName.rawValue)
    }
}
