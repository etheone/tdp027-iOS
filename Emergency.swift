//
//  Emergency.swift
//  Act4Heart
//
//  Created by Act4Heart on 2016-02-01.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit
import AVFoundation

class Emergency: UIViewController {
    
    @IBOutlet weak var sosView: UIView!
    @IBOutlet weak var blueWatch: UILabel!
    @IBOutlet weak var redWatch: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var blueWatchConstraint: NSLayoutConstraint!
    @IBOutlet weak var blueWatchWidth: NSLayoutConstraint!
    @IBOutlet weak var blueWatchHeight: NSLayoutConstraint!
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var processStartButton: UIButton!
    @IBOutlet weak var soundIcon: UIBarButtonItem!
    @IBOutlet weak var continueButton: UIButton!
    
    // SOS
    @IBOutlet weak var sosLocation: UILabel!
    @IBOutlet weak var sosClickText: UILabel!
    @IBOutlet weak var sosButton: UIButton!
    
    // Step 4
    @IBOutlet weak var noEmergencyButton: UIButton!
    
    var currentPage = 1
    let numberOfPages = 4
    let countdownTimer:Int = 30
    var blueClock : Clock?
    var redClock : Clock?
    var soundOn : Bool = true
    var gpsTracker = GPSTracker()
    var userData = [[String: String]]()
    var currentEmergency = Dictionary<String,String>()
    var userHistory = Dictionary<String,Dictionary<String,String>>()
    var callInProgress : Bool = false
    var audioRunning = false
    var viewActive = true
    
    // Sound variables
    var audioPlayer = AVAudioPlayer() // Needed for alert sound
    let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("alarm", ofType: "mp3")!)
    
    func openApp() {
        UIApplication.sharedApplication().openURL(NSURL(string: "act4heart://")!)
    }
    
    // Button that updates the text accordingly
    @IBAction func noEmergencyClicked(sender: AnyObject) {
        blueWatch.hidden = true
        noEmergencyButton.hidden = true
        clockLabel.hidden = true
        topText.text = "Det är viktigt att du är säker på att du inte har några kvarstående besvär\n\nÄr du säker på detta så är det fortfarande viktigt att du är uppmärksam på vad du känner. Du bör även berätta för en närstående eller kollega att du upplevt besvär."
        navTitle.title = "Besvären är borta"
        pushNavigation("Återfall - Besvären är borta")
    }
    
    @IBAction func backToMenu(sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "Tillbaka till menyn", message: "Du kan inte ångra detta val.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Fortsätt", style: .Default, handler: { (action: UIAlertAction!) in
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            self.performSegueWithIdentifier("emergencyToMenu", sender: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Avbryt", style: .Default, handler: { (action: UIAlertAction!) in
            // Cancel
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    // Performs segue to SOS ViewController
    @IBAction func sosStart(sender: AnyObject) {
        self.performSegueWithIdentifier("startSOS", sender: nil)
    }
    
    // Toggle between sound on or off
    @IBAction func soundChanger(sender: AnyObject) {
        soundOn = !soundOn
        NSUserDefaults.standardUserDefaults().setBool(soundOn, forKey: "soundOn")
        changeSoundIcon()
    }
    
    // Function that updates sound icon
    func changeSoundIcon() {
        if soundOn {
            let newImage = UIImage(named:"ic_volume_up_white_36pt.png")
            soundIcon.image = newImage
        } else {
            let newImage = UIImage(named:"ic_volume_off_white_36pt.png")
            soundIcon.image = newImage
        }
    }
    
    // Convert Date string to readable format
    func parseDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy,MM,dd,HH,mm,ss"
        return formatter.stringFromDate(NSDate())
    }
    
    func continueToNextStep() {
        
        // Checks if timer has expired every second.
        // Works if the user has minimized the app and later reopen the app.
        NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(self.countdownTimer), target: self, selector: #selector(self.timerDone), userInfo: nil, repeats: false)
        
        // Update current page
        currentPage += 1
        if(currentPage <= numberOfPages) {
            blueClock!.reset()
            blueWatch.text = "00:30"
            blueClock!.play()
            pushNavigation("Återfall - Steg \(currentPage)")
        }
        
        if currentPage == 2 {
            currentEmergency["Second"] = parseDate()
        } else if currentPage == 3 {
            currentEmergency["Third"] = parseDate()
        }
        
        // Update history
        userHistory[currentEmergency["ID"]!] = currentEmergency
        NSUserDefaults.standardUserDefaults().setObject(userHistory, forKey: "userHistory")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Functions that excecutes at end of timer
    func timerDone() {
        // If the app hasn't changed ViewController
        if (viewActive) {
            // Only play sound if app sound is on
            if (soundOn && currentPage <= numberOfPages) {
                playSound(alertSound)
            }
            if(currentPage <= numberOfPages) {
                alertBox()
            }
            if(currentPage == numberOfPages) {
                noEmergencyButton.hidden = false
                clockLabel.hidden = true
            }
        }
    }
    
    func playSound(soundFile: NSURL) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: soundFile)
        } catch {
            // Handle errors
        }
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        audioPlayer.numberOfLoops = -1
        audioRunning = true
    }
    
    // Popup that displays at end of timerDone()
    func alertBox() {
        var alertTitle = "Ta nästa dos Nitroglycerin"
        var alertMessage = "5 minuter har gått."
        if currentPage == 1 {
            alertTitle = "Ta en dos Nitroglycerin"
            alertMessage = "Den blå klockan räknar ned tills du ska ta nästa dos"
        } else if currentPage == numberOfPages {
            alertTitle = "Det har gått 5 minuter"
            alertMessage = "Välj det alternativ alternativ som beskriver din situation"
        }
        let alertCloseText = "OK"
        let alertController = UIAlertController(title: alertTitle, message:
            alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        // Opens alert box
        self.presentViewController(alertController, animated: true, completion: nil)
        
        let confirmAction = UIAlertAction(
            title: alertCloseText, style: UIAlertActionStyle.Default) { (action) in
                self.continueToNextStep()
                if (self.audioRunning) {
                    self.audioPlayer.stop()
                }
        }
        
        alertController.addAction(confirmAction)
        
    }
    
    // Notifications
    func scheduleLocal(sender: AnyObject) {
        let settings = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        if settings!.types == .None {
            let ac = UIAlertController(title: "Can't schedule", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            return
        }
        
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: Double(countdownTimer))
        notification.alertBody = "5 minuter har gått"
        notification.alertAction = "Öppna appen"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.applicationIconBadgeNumber = 1
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init notification
        scheduleLocal(self)

        // If iPhone 4s
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        if (width <= 320) {
            blueWatchConstraint.constant = 10.0
            blueWatchHeight.constant = 150.0
            blueWatch.frame.size.height = 150
            blueWatchWidth.constant = 150.0
            blueWatch.frame.size.width = 150
        }
        
        // Prevent sleep mode
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        // Overrides user mute
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
        
        // Get saved user history
        if (NSUserDefaults.standardUserDefaults().objectForKey("userHistory") != nil) {
            self.userHistory = NSUserDefaults.standardUserDefaults().objectForKey("userHistory") as! Dictionary<String,Dictionary<String,String>>
        }
        
        // Gets saved sound option and updates icon if needed
        self.soundOn = NSUserDefaults.standardUserDefaults().boolForKey("soundOn")
        changeSoundIcon()
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        self.blueClock = Clock(timerValue: (self.countdownTimer), countDown: true, timerLabel: blueWatch, parent: self)
        self.redClock = Clock(timerValue: (0), countDown: false, timerLabel: redWatch, parent: self)
        
        roundedButton(continueButton)
        roundedButton(noEmergencyButton)
        
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
        
        currentEmergency["ID"] = String(Int(NSDate().timeIntervalSince1970)) // To get rid of decimals
        currentEmergency["Start"] = parseDate()
        currentEmergency["Second"] = ""
        currentEmergency["Third"] = ""
        currentEmergency["SOS"] = ""
        currentEmergency["Outcome"] = parseDate()
        
        userHistory[currentEmergency["ID"]!] = currentEmergency
        NSUserDefaults.standardUserDefaults().setObject(userHistory, forKey: "userHistory")
        
        redClock!.play()
        
        performSelector(#selector(Emergency.alertBox), withObject: nil, afterDelay: 0.1)
        
        pushNavigation("Återfall - Start")
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func viewWillDisappear(animated: Bool) {
        viewActive = false;
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


