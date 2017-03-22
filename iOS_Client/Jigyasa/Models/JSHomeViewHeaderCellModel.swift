//
//  File.swift
//  Jigyasa
//
//  Created by siddesh medehalmath ganeshbabu on 02/01/17.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import Foundation


struct JSHomeViewHeaderCellModel {
    
     var headerText: String
    
     var isExpanded: Bool
    
     var sectionIndex: Int
    
     init() {
        
        headerText = "Not Title Set"
        isExpanded = true
        sectionIndex = -1
    }
    
     init(forSectionIndex sectionIndex: Int, withHeaderText headerText: String, andIsExpanded isExpanded: Bool) {
        
        self.headerText = headerText
        self.isExpanded = isExpanded
        self.sectionIndex = sectionIndex
        
    }
    
}
