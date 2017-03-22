//
//  JSCustomColor.swift
//  Jigyasa
//
//  Created by basagond a mugganauar on 30/11/16.
//  Copyright © 2016 Exilant Technologies. All rights reserved.
//

import UIKit

extension UIColor {
    
    //MARK:- Activity indicator
    var activityIndicatorBackgroundColor: UIColor{
        return UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    //MARK:- Navigation Bar
    var navigationBarBackgroundColor: UIColor{
        return UIColor(red: 40, green: 143, blue: 214, alpha: 1)
    }
    
    //MARK:- Label Bar
    var labelTextColor: UIColor{
        return UIColor(red: 40.0/255, green: 143.0/100, blue: 214.0/255, alpha: 1)
    }
    
    // MARK:- Global Tint Color
    var globalTintColor: UIColor{
        return  UIColor(red: 54.0/255, green: 186.0/255, blue: 236.0/255, alpha: 1.0)
    }
    
    //MARK:- Segment Control Color
    var selectedSegmentColor: UIColor{
        return  UIColor(red: 54.0/255, green: 186.0/255, blue: 236.0/255, alpha: 1.0)
    }
    
    var unselectedSegmentColor: UIColor{
        return  UIColor(red: 199/255.0, green: 199/255.0, blue: 199/255.0, alpha: 1)
    }
    
    //MARK:- Menu Background Color
    var menuBackgrounColor: UIColor{
        return  UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)
    }
}
