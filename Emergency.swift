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
    
    var currentPage = 1
    let numberOfPages = 4
    var blueClock: Clock?
    var redClock: Clock?
    var stepDone = false
    
    let buttonImageEnabled = UIImage(named: "buttonNextEnabled.png")
    let buttonImageDisabled = UIImage(named: "buttonNextDisabled.png")
    
    // Sound variables
    var audioPlayer = AVAudioPlayer() // Needed for alert sound
    let alertSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("alarm", ofType: "mp3")!)
    
    @IBAction func emergencyStart(sender: AnyObject) {
        // Function that runs when emergencyButton is clicked
        secondMenu.hidden = true
        let url:NSURL = NSURL(string: "tel://0708565661")! // Jockes nr
        UIApplication.sharedApplication().openURL(url)
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
            self.nextStepButton.setImage(buttonImageDisabled, forState: UIControlState.Normal)
            self.nextStepButton.enabled = false
            
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
        self.nextStepButton.setImage(buttonImageDisabled, forState: UIControlState.Normal)
        self.nextStepButton.enabled = false
        
        self.breadcrumb.text = "Start > Akutsituation"
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerDone() {
        // When the timer is done - activate button at bottom.
        stepDone = true
        
        // Enable the button
        self.nextStepButton.setImage(buttonImageEnabled, forState: UIControlState.Normal)
        self.nextStepButton.enabled = true
        
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
        let alertMessage = "Lorem ipsum"
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
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}


