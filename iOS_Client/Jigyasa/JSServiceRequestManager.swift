//
//  JSServiceRequestManager.swift
//  Jigyasa
//
//  Created by basagond a mugganauar on 30/12/16.
//  Copyright © 2016-17 EXILANT Technologies Pvt. Ltd. All rights reserved.
//

import UIKit


class JSServiceRequestManager {
    
    static let requestManager = JSServiceRequestManager()
    let session: URLSession
    
    class func sharedManager() -> JSServiceRequestManager {
        return requestManager
    }
    
    private init() {
        session = URLSession.shared
    }
    
    func dataTaskWithURL(postBody: JSONDictionary, urlEndString: String ,completionHandler: @escaping (JSONDictionary) -> Void){
        
        //Add activity indicator
        let window = UIApplication.shared.windows.first!
        let indicator = JSActivityIndicator(frame: window.frame)
        indicator.startAnimating()
        window.addSubview(indicator)
        window.bringSubview(toFront: indicator)
        
        
        let urlString = jigyasaBaseUrl + "/" + urlEndString
        
        var request = URLRequest(url: URL(string:urlString)!)
        print(postBody)
        request.httpMethod = "Post"
        request.addValue(JSHTTPHeaderContentTypeValues.json.rawValue, forHTTPHeaderField: JSHTTPHeaderFields.contentType.rawValue)
        request.addValue(JSHTTPHeaderContentTypeValues.json.rawValue, forHTTPHeaderField: JSHTTPHeaderFields.accept.rawValue)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: postBody, options: []) else {
            DispatchQueue.main.sync {
                //remove indicator
                indicator.stopAnimating()
                indicator.removeFromSuperview()
                completionHandler([JSErrorMessage.errorMessage.rawValue: JSErrorMessage.dataCovertionErrorMessage.rawValue])
            }
            return
        }
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            (data, response, error) -> Void in
            
            //If response will be nil then return error message
            guard let responseData = response else {
                DispatchQueue.main.sync {
                    //remove indicator
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                    completionHandler([JSErrorMessage.errorMessage.rawValue: JSErrorMessage.noDataMessage.rawValue])
                }
                return
            }
            
            if let httpResponse = responseData as? HTTPURLResponse {
                let statusCode: Int = Int(JSResponseKey.successCode.rawValue)!
                if httpResponse.statusCode == statusCode {//If status code is 200 then return response data
                    do {
                        if let responseData =  try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? JSONDictionary {
                            DispatchQueue.main.sync {
                                indicator.stopAnimating()
                                indicator.removeFromSuperview()
                                completionHandler(responseData)
                            }
                        }
                    }
                    catch let error {
                        print(error)
                    }
                } else {
                    DispatchQueue.main.sync {
                        indicator.stopAnimating()
                        indicator.removeFromSuperview()
                        completionHandler([JSErrorMessage.errorMessage.rawValue: JSErrorMessage.noDataMessage.rawValue])
                    }
                }
            }
        }
        task.resume()
    }
}

