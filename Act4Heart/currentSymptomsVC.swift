//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-04-07.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

let user = UIDevice.currentDevice().identifierForVendor!.UUIDString

class CurrentSymptoms: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var soundIcon: UIBarButtonItem!
    
    var symptomsArray = symptoms
    var selectedRows = [Int]()
    var checkboxArray = [UITableViewCell]()
    var soundOn : Bool = true
    let textCellIdentifier = "TextCell"
    var gpsTracker = GPSTracker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gets saved sound option and updates icon if needed
        self.soundOn = NSUserDefaults.standardUserDefaults().boolForKey("soundOn")
        changeSoundIcon()
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        roundedButton(continueButton)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if ( !defaults.boolForKey("acceptedTerms") ) {
            print("first")
            gpsTracker.startTracking()
            gpsTracker.stopTracking()
            defaults.setBool(true, forKey: "acceptedTerms")
        }
        
        // Make user get notification popup at start
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        pushNavigation("Start - Välj symptom")

    }
    
    @IBAction func continueButton(sender: AnyObject) {
        if(selectedRows.count == 0) {
            self.performSegueWithIdentifier("segueToMisc", sender: nil)
        } else if (selectedRows.contains(3) || selectedRows.contains(5)) {
            self.performSegueWithIdentifier("segueToSOS", sender: nil)
        } else if (true) {
            self.performSegueWithIdentifier("segueToSeriousSymptom", sender: nil)
        }
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptomsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = symptomsArray[row]
        checkboxArray.append(cell)
        
        if self.selectedRows.contains(row) {
            cell.imageView?.image = UIImage(named: "icon-checked")
        } else {
            cell.imageView?.image = UIImage(named: "icon-unchecked")
        }
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        
        if self.selectedRows.contains(row) {
            checkboxArray[row].imageView?.image = UIImage(named: "icon-unchecked")
            selectedRows.removeAtIndex(selectedRows.indexOf(row)!)
        } else {
            checkboxArray[row].imageView?.image = UIImage(named: "icon-checked")
            selectedRows.append(row)
        }
        
        if(selectedRows.count == 0) {
            continueButton.setTitle("Hoppa över", forState: UIControlState.Normal)
        } else {
            continueButton.setTitle("Fortsätt", forState: UIControlState.Normal)
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

