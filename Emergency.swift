//
//  Emergency.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-02-01.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class Emergency: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var secondMenu: UIView!
    @IBOutlet weak var blueWatch: UILabel!
    @IBOutlet weak var redWatch: UILabel!
    @IBOutlet weak var breadcrumb: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var processStartButton: UIButton!
    @IBOutlet weak var soundIcon: UIBarButtonItem!
    
    var currentPage = 1
    let numberOfPages = 3
    var blueClock: Clock?
    var redClock: Clock?
    var stepDone = false
    var soundOn:Bool = true;
    var manager:CLLocationManager!
    
    // Sound variables
    var audioPlayer = AVAudioPlayer() // Needed for alert sound
    let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("alarm", ofType: "mp3")!)
    
    func openApp() {
        UIApplication.sharedApplication().openURL(NSURL(string: "act4heart://")!)
    }
    
    func changeSoundIcon() {
        if soundOn {
            let newImage = UIImage(named:"ic_volume_up_white_36pt.png")
            soundIcon.image = newImage
        } else {
            let newImage = UIImage(named:"ic_volume_off_white_36pt.png")
            soundIcon.image = newImage
        }
    }
    
    @IBAction func soundChanger(sender: AnyObject) {
        print("click")
        soundOn = !soundOn
        NSUserDefaults.standardUserDefaults().setBool(soundOn, forKey: "soundOn")
        changeSoundIcon()
    }
    
    @IBAction func emergencyStart(sender: AnyObject) {
        // Function that runs when emergencyButton is clicked
        secondMenu.hidden = true
        
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: "openApp", userInfo: nil, repeats: false)
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://0708565661")!)
    }
    
    
    @IBAction func relapseStart(sender: AnyObject) {
        // Function that runs when relapseButton is clicked
        secondMenu.hidden = true
        breadcrumb.text = "Start > Akutsituation > Återfallsprocessen \(currentPage)/\(numberOfPages)"
        navTitle.title = "Återfallsprocessen \(currentPage) av \(numberOfPages)"
        blueClock!.play()
        redClock!.play()
    }
    
    func continueToNextStep() {
        // Function that runs when nextStepButton is clicked
        if (stepDone) {
            
            currentPage++
            if(currentPage < numberOfPages) {
                
                blueClock!.reset()
                blueClock!.play()
                
                
            }
           
            breadcrumb.text = "Start > Akutsituation > Återfallsprocessen \(currentPage)/\(numberOfPages)"
            navTitle.title = "Återfallsprocessen \(currentPage) av \(numberOfPages)"
        }
        stepDone = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Overrides user mute
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
        
        // Gets saved sound option and updates icon if needed
        self.soundOn = NSUserDefaults.standardUserDefaults().boolForKey("soundOn")
        changeSoundIcon()
        
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        //imerValue: Int, clockType: String, timerLabel: UILabel)
        self.blueClock = Clock(timerValue: (3), countDown: true, timerLabel: blueWatch, parent: self)
        self.redClock = Clock(timerValue: (0), countDown: false, timerLabel: redWatch, parent: self)
        
        self.breadcrumb.text = "Start > Akutsituation"
        
        callButton.layer.cornerRadius = 3
        callButton.layer.borderWidth = 1
        callButton.layer.borderColor = UIColor.whiteColor().CGColor
        callButton.clipsToBounds = true
        
        processStartButton.layer.cornerRadius = 3
        processStartButton.layer.borderWidth = 1
        processStartButton.layer.borderColor = UIColor.whiteColor().CGColor
        processStartButton.clipsToBounds = true
        
        redWatch.layer.cornerRadius = 3
        redWatch.layer.borderWidth = 1
        redWatch.layer.borderColor = UIColor.whiteColor().CGColor
        redWatch.clipsToBounds = true
        
        blueWatch.clipsToBounds = true
        blueWatch.layer.cornerRadius = blueWatch.frame.size.width/2
        blueWatch.layer.borderWidth = 1
        blueWatch.layer.borderColor = UIColor.whiteColor().CGColor
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            manager.requestWhenInUseAuthorization()
        } else {
            //iOS 7 code stuff
        }
        
       
        manager.startUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        //userLocation - there is no need for casting, because we are now using CLLocation object
        
        var userLocation:CLLocation = locations[0]
  /*
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)" */
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
                if let p = placemarks?[0] {
                    
                    var subThoroughfare:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        
                        subThoroughfare = p.subThoroughfare!
                        
                    }
                    
                    print ("\(subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)")
                    
                }
                
                
            }
            
        })
        
        
    }


    
    func timerDone() {
        // When the timer is done - activate button at bottom.
        stepDone = true
        
        
        // Only play sound if app sound is on
        if soundOn {
            playSound(alertSound)
        }
        alertBox()
        
    }
    
    func playSound(soundFile: NSURL) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: soundFile)
        } catch {
            // Handle errors
        }
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func alertBox() {
        let alertTitle = "5 minuter har gått"
        let alertMessage = "Ta en ny nitroglycering och tryck OK för att gå vidare"
        let alertCloseText = "OK"
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: alertTitle, message:
                alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            let confirmAction = UIAlertAction(
                title: alertCloseText, style: UIAlertActionStyle.Default) { (action) in
                self.continueToNextStep()
            }
            
            alertController.addAction(confirmAction)
            
        } else {
            
            let alert:UIAlertView = UIAlertView(title: alertTitle, message: alertMessage, delegate: self, cancelButtonTitle: alertCloseText)
            alert.delegate = self
            alert.show()
            
            
            func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int){
                self.continueToNextStep()
            }
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}


