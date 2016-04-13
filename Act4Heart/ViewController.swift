//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-01-27.
//  Copyright © 2016 act4heart. All rights reserved.
//



import UIKit

let user = UIDevice.currentDevice().identifierForVendor!.UUIDString

class ViewController: UIViewController {

    @IBOutlet weak var miscButton: UIButton!
    @IBOutlet weak var emergencyButton: UIButton!
    
    var gpsTracker = GPSTracker()
    
    @IBAction func miscButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("menuToMisc", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        roundedButton(miscButton)
        roundedButton(emergencyButton)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if ( !defaults.boolForKey("acceptedTerms") ) {
            print("first")
            gpsTracker.startTracking()
            gpsTracker.stopTracking()
            defaults.setBool(true, forKey: "acceptedTerms")
        }
        
    }
    
    func roundedButton(button: UIButton) {
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

