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
    @IBOutlet weak var blueWatch: UILabel!
    @IBOutlet weak var redWatch: UILabel!
    @IBOutlet weak var breadcrumb: UILabel!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var processStartButton: UIButton!
    @IBOutlet weak var soundIcon: UIBarButtonItem!
    
    var currentPage = 1
    let numberOfPages = 4
    var blueClock: Clock?
    var redClock: Clock?
    var soundOn:Bool = true
    var gpsTracker = GPSTracker()
    var userData = [[String: String]]()
    var currentEmergency = Dictionary<String,String>()
    
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
    @IBAction func backToMenu(sender: AnyObject) {
        performSegueWithIdentifier("emergencyToMenu", sender: nil)
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
        
        currentEmergency["Start"] = parseDate()
        
        //blueClock!.play()
        redClock!.play()
        
        timerDone()
    }
    
    func parseDate() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy,MM,dd,HH,mm,ss"
        return formatter.stringFromDate(NSDate())
    }
    
    func continueToNextStep() {
        
        currentPage++
        if(currentPage < numberOfPages) {
            blueClock!.reset()
            blueClock!.play()
        }
        
        if currentPage == 2 {
            currentEmergency["Second"] = parseDate()
        } else if currentPage == 3 {
            currentEmergency["Third"] = parseDate()
        } else {
            textView.text = "STEG 4!"
        }
        
        print(currentEmergency, currentPage)
        
        breadcrumb.text = "Start > Akutsituation > Återfallsprocessen \(currentPage)/\(numberOfPages)"
        navTitle.title = "Återfallsprocessen \(currentPage) av \(numberOfPages)"
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
        let alertTitle = "Ta en nitroglycerin"
        var alertMessage = "5 minuter har gått. Tryck OK för att gå vidare till nästa steg."
        if (currentPage == 1) {
            alertMessage = "Tryck OK för att gå vidare till nästa steg."
        }
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
        
        gpsTracker.startTracking()
        
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


