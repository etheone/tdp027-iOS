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
    var address = ""
    
    func startTracking() {
        
        locationManager1 = CLLocationManager()
        locationManager1.delegate = self
        locationManager1.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            locationManager1.requestAlwaysAuthorization()
        } else {
            // Fallback on earlier versions
        }
        locationManager1.startUpdatingLocation()
    }
    
    func getLocationInformation() -> String {
        
        return address
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation:CLLocation = locations[0]
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    
                    self.address = String(p.addressDictionary!)
                    //p.addressDictionary["Street"]
                    
                }
                
                
            }
            
        })
        
        
    }
    
}
