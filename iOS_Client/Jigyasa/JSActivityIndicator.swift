//
//  JSActivityIndicator.swift
//  Jigyasa
//
//  Created by basagond a mugganauar on 30/11/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit

class JSActivityIndicator: UIView {

    var activityIndicatorView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        
        print("dev")
        super.init(frame:frame)
        self.backgroundColor = UIColor().activityIndicatorBackgroundColor
        
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        self.activityIndicatorView.center = self.center
        self.addSubview(self.activityIndicatorView)
    }
    
    required init?(coder aDecoder: NSCoder) {
       
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
       
        self.activityIndicatorView.startAnimating()
    }
    
    func stopAnimating() {
       
        self.activityIndicatorView.stopAnimating()
    }

}
