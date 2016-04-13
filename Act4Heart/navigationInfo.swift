//
//  navigationInfo.swift
//  Act4Heart
//
//  Created by Emil Nilsson on 13/04/16.
//  Copyright © 2016 act4heart. All rights reserved.
//

import Foundation

extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)
    }
    
}

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
    
}

func pushNavigation(location: String) -> NSURLSessionTask {
    
    let url = "https://act4heart-act4heart.rhcloud.com/sendData"
  
    let timeInterval = NSDate().timeIntervalSince1970
    let params:[String: AnyObject] = ["user":user, "path":location, "unixtime":String(timeInterval)]
    
    let parameterString = params.stringFromHttpParameters()
    let requestURL = NSURL(string:"\(url)?\(parameterString)")!
    
    let request = NSMutableURLRequest(URL: requestURL)
    request.HTTPMethod = "GET"
    
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request)
    
    print("Sending navigational information " + location)
    
    task.resume()
    
    return task
    
}