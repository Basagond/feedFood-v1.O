//
//  UIImageView.swift
//  Jigyasa
//
//  Created by siddesh medehalmath ganeshbabu on 02/01/17.
//  Copyright © 2017 Exilant Technologies. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    
    func rotateArrowDown(){
        UIView.animate(withDuration: 0.3){
            self.transform = CGAffineTransform(rotationAngle: self.degreeToRadians(of: 90.0))
        }
    }
    
    func rotateArrowRight(){
        UIView.animate(withDuration: 0.3){
            self.transform = CGAffineTransform(rotationAngle: self.degreeToRadians(of: 0.0))
        }
    }
    
    private func degreeToRadians(of degree:Double) -> CGFloat {
        return CGFloat(0.0)
    }
}
