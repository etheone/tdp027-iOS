//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-04-07.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class HasPrevious: UIViewController {
    
    @IBOutlet weak var miscButton: UIButton!
    @IBOutlet weak var emergencyButton: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var soundIcon: UIBarButtonItem!
    
    var soundOn : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gets saved sound option and updates icon if needed
        self.soundOn = NSUserDefaults.standardUserDefaults().boolForKey("soundOn")
        changeSoundIcon()
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        roundedButton(miscButton)
        roundedButton(emergencyButton)
        
        pushNavigation("Har haft infarkt tidigare")
    }
    
    @IBAction func backToMenu(sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "Tillbaka till menyn", message: "Du kan inte ångra detta val.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Fortsätt", style: .Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("hasPrevToMenu", sender: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Avbryt", style: .Default, handler: { (action: UIAlertAction!) in
            // Cancel
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    // Sound icon
    @IBAction func soundChanger(sender: AnyObject) {
        soundOn = !soundOn
        NSUserDefaults.standardUserDefaults().setBool(soundOn, forKey: "soundOn")
        changeSoundIcon()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}

