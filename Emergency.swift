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
    @IBOutlet weak var nextStepButton: UIButton!
    @IBOutlet weak var blueWatch: UILabel!
    @IBOutlet weak var redWatch: UILabel!
    @IBOutlet weak var breadcrumb: UILabel!
    
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var processStartButton: UIButton!
    
    var currentPage = 1
    let numberOfPages = 4
    var blueClock: Clock?
    var redClock: Clock?
    var stepDone = false
    
    // Sound variables
    var audioPlayer = AVAudioPlayer() // Needed for alert sound
    let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("alarm", ofType: "mp3")!)
    
    func openApp() {
        UIApplication.sharedApplication().openURL(NSURL(string: "act4heart://")!)
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
        topTitle.text = "Återfallsprocessen - Steg \(currentPage) av \(numberOfPages)"
        blueClock!.play()
        redClock!.play()
    }
    
    @IBAction func continueToNextStep(sender: AnyObject) {
        // Function that runs when nextStepButton is clicked
        if (stepDone) {
            // Disable the button
            self.nextStepButton.enabled = false
            self.nextStepButton.alpha = 0.25
            
            currentPage++
            if (currentPage == numberOfPages) {
                nextStepButton.hidden = true
            }
            blueClock!.reset()
            blueClock!.play()
            breadcrumb.text = "Start > Akutsituation > Återfallsprocessen \(currentPage)/\(numberOfPages)"
            topTitle.text = "Återfallsprocessen - Steg \(currentPage) av \(numberOfPages)"
        }
        stepDone = false
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imerValue: Int, clockType: String, timerLabel: UILabel)
        self.blueClock = Clock(timerValue: (3), countDown: true, timerLabel: blueWatch, parent: self)
        self.redClock = Clock(timerValue: (0), countDown: false, timerLabel: redWatch, parent: self)
        
        // Disable the button
        self.nextStepButton.enabled = false
        self.nextStepButton.alpha = 0.25
        
        self.breadcrumb.text = "Start > Akutsituation"
        
        callButton.layer.cornerRadius = 3
        callButton.layer.borderWidth = 1
        callButton.layer.borderColor = UIColor.whiteColor().CGColor
        callButton.clipsToBounds = true
        
        nextStepButton.layer.cornerRadius = 3
        nextStepButton.layer.borderWidth = 1
        nextStepButton.layer.borderColor = UIColor.whiteColor().CGColor
        nextStepButton.clipsToBounds = true
        
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerDone() {
        // When the timer is done - activate button at bottom.
        stepDone = true
        
        // Enable the button
        self.nextStepButton.enabled = true
        self.nextStepButton.alpha = 1.0
        
        playSound(alertSound)
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
        let alertMessage = "Ta en ny nitroglycering"
        let alertCloseText = "OK"
        if #available(iOS 8.0, *) {
            let alertController = UIAlertController(title: alertTitle, message:
                alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: alertCloseText, style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            let alert:UIAlertView = UIAlertView(title: alertTitle, message: alertMessage, delegate: self, cancelButtonTitle: alertCloseText)
            alert.delegate = self
            alert.show()
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


