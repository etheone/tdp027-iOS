//
//  SOS.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-04-06.
//  Copyright © 2016 act4heart. All rights reserved.
//

import CoreTelephony
import UIKit

class SOS: UIViewController {
    
    
    @IBOutlet weak var buttonCredits: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var sosButton: UIButton!
    @IBOutlet weak var sosText: UILabel!
    
    var gpsTracker = GPSTracker()
    var userLocation : Dictionary<String,String> = [String: String]()
    var callInProgress : Bool = false
    let callCenter = CTCallCenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //roundedButton(buttonCredits)
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        gpsTracker.startTracking()
        userLocation = gpsTracker.getLocationInformation()
        
        self.checkCallState()
        
    }
    
    func openApp() {
        UIApplication.sharedApplication().openURL(NSURL(string: "act4heart://")!)
    }
    
    @IBAction func backToMenu(sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "Tillbaka till menyn", message: "Du kan inte ångra detta val.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Fortsätt", style: .Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("SOSToMenu", sender: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Avbryt", style: .Default, handler: { (action: UIAlertAction!) in
            // Cancel
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func sosCall(sender: AnyObject) {
        if !callInProgress {
            // Function that runs when emergencyButton is clicked
            animateSOSButton()
            
            let newSOSText = "Ringer nu till SOS\n\n\n\nDin nuvarande position:"
            sosText.text = newSOSText
            callInProgress = true
            
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: #selector(SOS.openApp), userInfo: nil, repeats: false)
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://0763080242")!)
        }
    }
    
    func checkCallState() {
        self.callCenter.callEventHandler = { (call: CTCall) -> () in
            if call.callState == "CTCallStadeDialing" {
                
            } else if call.callState == "CTCallStateDisconnected" {
                // Call ended. Stop call animation and reset boolean.
                self.sosButton!.imageView!.stopAnimating()
                self.sosButton!.setImage(UIImage(named:"call-button.png"), forState: UIControlState.Normal)
                self.callInProgress = false
            }
        }
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: #selector(SOS.checkCallState), userInfo: nil, repeats: false)
    }
    
    func animateSOSButton(){
        var imageList = [UIImage]()
        let image0:UIImage = UIImage(named:"call-button.png")!
        let image1:UIImage = UIImage(named:"call-button-1.png")!
        let image2:UIImage = UIImage(named:"call-button-2.png")!
        let image3:UIImage = UIImage(named:"call-button-3.png")!
        
        //animationButtonscreenButton = screenButton
        imageList = [image0, image1, image2, image3]
        
        sosButton!.imageView!.animationImages = imageList
        sosButton!.imageView!.animationDuration = 2.0
        sosButton!.imageView!.startAnimating()
    }
    
    func getLocationToText() -> String {

        userLocation = gpsTracker.getLocationInformation()
        var locationString = ""
        if (userLocation["street"] != "" && userLocation["street"] != nil) {
            locationString += "Gata: \(userLocation["street"]!)"
        } else {
            locationString += "Plats: \(userLocation["name"]!)"
        }
        locationString += "\nStad: \(userLocation["city"]!)"
        return locationString
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

