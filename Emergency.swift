//
//  Emergency.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-02-01.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class Emergency: UIViewController {
    
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var secondMenu: UIView!
    @IBOutlet weak var nextStepButton: UIButton!
    @IBOutlet weak var blueWatch: UILabel!
    
    var currentPage = 1;
    let numberOfPages = 4;
    var clock: Clock?

    @IBAction func emergencyStart(sender: AnyObject) {
        secondMenu.hidden = true;
        let url:NSURL = NSURL(string: "tel://0708565661")! // Jockes nr
        UIApplication.sharedApplication().openURL(url)
    }
    
    
    @IBAction func relapseStart(sender: AnyObject) {
        secondMenu.hidden = true;
        topTitle.text = "Återfallsprocessen - Steg \(currentPage) av \(numberOfPages)"
        clock!.play()
    }
    
    @IBAction func continueToNextStep(sender: AnyObject) {
        currentPage++
        if (currentPage == numberOfPages) {
            nextStepButton.hidden = true
        }
        topTitle.text = "Återfallsprocessen - Steg \(currentPage) av \(numberOfPages)"
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imerValue: Int, clockType: String, timerLabel: UILabel)
        self.clock = Clock(timerValue: (120), countDown: true, timerLabel: blueWatch, parent: self)
        let clock2 = Clock(timerValue: (0), countDown: false, timerLabel: topTitle, parent: self)
        clock2.play()
        self.nextStepButton.setTitle("Vänta...", forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerDone() {
        self.nextStepButton.setTitle("Gå vidare", forState: UIControlState.Normal)
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


