//
//  GPSTracker.swift
//  Act4Heart
//
//  Created by Emil Nilsson on 18/02/16.
//  Copyright © 2016 act4heart. All rights reserved.
//

import Foundation
import CoreLocation

class GPSTracker: NSObject, CLLocationManagerDelegate {
    
    var locationManager1: CLLocationManager!
    var seenError : Bool = false
    var address : Dictionary<String,String> = [String: String]()
    
    func startTracking() {
        
        locationManager1 = CLLocationManager()
        locationManager1.delegate = self
        locationManager1.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager1.requestAlwaysAuthorization()
        locationManager1.startUpdatingLocation()
    }
    
    func getLocationInformation() -> Dictionary<String,String> {
        return address
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    
                    //self.address = String(p.addressDictionary!)
                    //print(p.addressDictionary!)
                    
                    var city = ""
                    var zip = ""
                    var street = ""
                    var name = ""
                    
                    if (p.addressDictionary!["City"] != nil) { city = p.addressDictionary!["City"]! as! String }
                    if (p.addressDictionary!["ZIP"] != nil) { zip = p.addressDictionary!["ZIP"]! as! String }
                    if (p.addressDictionary!["Street"] != nil) { street = p.addressDictionary!["Street"]! as! String }
                    if (p.addressDictionary!["Name"] != nil) { name = p.addressDictionary!["Name"]! as! String }
                    
                    self.address["city"] = city
                    self.address["zip"] = zip
                    self.address["street"] = street
                    self.address["name"] = name
                    //self.address["info"] = String(p.addressDictionary!)
                    
                    //p.addressDictionary["Street"]
                    
                }
                
                
            }
            
        })
        
        
    }
    
}
