//
//  Emergency.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-02-01.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit
import AVFoundation

class Emergency: UIViewController {
    
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var secondMenu: UIView!
    @IBOutlet weak var sosView: UIView!
    @IBOutlet weak var blueWatch: UILabel!
    @IBOutlet weak var redWatch: UILabel!
    @IBOutlet weak var breadcrumb: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var topText: UILabel!
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var processStartButton: UIButton!
    @IBOutlet weak var soundIcon: UIBarButtonItem!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var stepOneSOSButton: UIButton!
    @IBOutlet weak var relapseAddress: UILabel!
    
    // SOS
    @IBOutlet weak var sosLocation: UILabel!
    @IBOutlet weak var sosClickText: UILabel!
    @IBOutlet weak var sosButton: UIButton!
    
    // Step 4
    @IBOutlet weak var noEmergencyButton: UIButton!
    @IBOutlet weak var stillEmergencyButton: UIButton!
    
    
    
    var currentPage = 1
    let numberOfPages = 4
    var blueClock: Clock?
    var redClock: Clock?
    var soundOn:Bool = true
    var gpsTracker = GPSTracker()
    var userData = [[String: String]]()
    var currentEmergency = Dictionary<String,String>()
    var userLocation : Dictionary<String,String> = [String: String]()
    var callInProgress : Bool = false
    
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
    
    @IBAction func continueToStep2(sender: AnyObject) {
        stepOneSOSButton.hidden = true
        relapseAddress.hidden = true
        continueButton.hidden = true
        blueWatch.hidden = false
        topText.text = "Ta en ny Nitroglycerin när \nden blå klockan når 00:00"
        continueToNextStep()
    }
    
    @IBAction func backToMenu(sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "Tillbaka till menyn", message: "Du kan inte ångra detta val.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Fortsätt", style: .Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("emergencyToMenu", sender: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Avbryt", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func sosStart(sender: AnyObject) {
        breadcrumb.text = "Start > Akutsituation > Första gången"
        navTitle.title = "Första gången"
        sosView.hidden = false
        sosLocation.text = getLocationToText()
    }
    
    @IBAction func soundChanger(sender: AnyObject) {
        print("click")
        soundOn = !soundOn
        NSUserDefaults.standardUserDefaults().setBool(soundOn, forKey: "soundOn")
        changeSoundIcon()
    }
    
    @IBAction func sosCall(sender: AnyObject) {
        if !callInProgress {
            // Function that runs when emergencyButton is clicked
            animation()
            
            let newSOSCText = "Ringer nu till SOS\n\n\n\nDin nuvarande position:"
            sosClickText.text = newSOSCText
            secondMenu.hidden = true
            callInProgress = true
            sosButton.setImage(UIImage(named: "calling.gif"), forState: UIControlState.Normal)
            stepOneSOSButton.setImage(UIImage(named: "calling.gif"), forState: UIControlState.Normal)
            
        
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(2), target: self, selector: "openApp", userInfo: nil, repeats: false)
            UIApplication.sharedApplication().openURL(NSURL(string: "tel://0708565661")!)
        }
    }
    
    @IBAction func relapseStart(sender: AnyObject) {
        // Function that runs when relapseButton is clicked
        
        relapseAddress.text = getLocationToText()
        
        secondMenu.hidden = true
        breadcrumb.text = "Start > Akutsituation > Återfallsprocessen \(currentPage)/\(numberOfPages)"
        navTitle.title = "Återfallsprocessen \(currentPage) av \(numberOfPages)"
        
        currentEmergency["Start"] = parseDate()
        
        //blueClock!.play()
        redClock!.play()
        
        //timerDone()
    }
    
    func animation(){
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
        if (userLocation["street"] != "") {
            locationString += "Gata: \(userLocation["street"]!)"
        } else {
            locationString += "Plats: \(userLocation["name"]!)"
        }
        locationString += "\nStad: \(userLocation["city"]!)"
        locationString += "\nPostnummer: \(userLocation["zip"]!)"
        return locationString
    }
    
    func parseDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy,MM,dd,HH,mm,ss"
        return formatter.stringFromDate(NSDate())
    }
    
    func continueToNextStep() {
        
        currentPage++
        if(currentPage <= numberOfPages) {
            blueClock!.reset()
            blueClock!.play()
        }
        
        breadcrumb.text = "Start > Akutsituation > Återfallsprocessen \(currentPage)/\(numberOfPages)"
        navTitle.title = "Återfallsprocessen \(currentPage) av \(numberOfPages)"
        
        if currentPage == 2 {
            currentEmergency["Second"] = parseDate()
        } else if currentPage == 3 {
            currentEmergency["Third"] = parseDate()
        } else {
            topText.text = "När den blå klockan når 00:00\nvälj något av alternativen nedan"
            noEmergencyButton.hidden = false
            stillEmergencyButton.hidden = false
        }
        
        print(currentEmergency, currentPage)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func timerDone() {
        // Only play sound if app sound is on
        if soundOn {
            playSound(alertSound)
        }
        alertBox()
        userLocation = gpsTracker.getLocationInformation()
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
        let alertTitle = "Ta en Nitroglycerin"
        var alertMessage = "5 minuter har gått. Tryck OK för att gå vidare till nästa steg."
        if (currentPage == 1) {
            alertMessage = "Tryck OK för att gå vidare till nästa steg."
        }
        let alertCloseText = "OK"
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
        let confirmAction = UIAlertAction(
            title: alertCloseText, style: UIAlertActionStyle.Default) { (action) in
                self.continueToNextStep()
        }
        
        alertController.addAction(confirmAction)
        
        
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
        
        // Hide the blue clock at start - call button is active
        self.blueWatch.hidden = true
        
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
        
        roundedButtons(callButton)
        roundedButtons(processStartButton)
        roundedButtons(continueButton)
        roundedButtons(stillEmergencyButton)
        roundedButtons(noEmergencyButton)
        
        redWatch.layer.cornerRadius = 3
        redWatch.layer.borderWidth = 1
        redWatch.layer.borderColor = UIColor.whiteColor().CGColor
        redWatch.clipsToBounds = true
        
        blueWatch.clipsToBounds = true
        blueWatch.layer.cornerRadius = blueWatch.frame.size.width/2
        blueWatch.layer.borderWidth = 1
        blueWatch.layer.borderColor = UIColor.whiteColor().CGColor
        
        continueButton.layer.cornerRadius = 3
        continueButton.layer.borderWidth = 1
        continueButton.layer.borderColor = UIColor.whiteColor().CGColor
        
        gpsTracker.startTracking()
        userLocation = gpsTracker.getLocationInformation()
        print(userLocation);
        
    }
    
    func roundedButtons(button:UIButton) {
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.clipsToBounds = true
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


