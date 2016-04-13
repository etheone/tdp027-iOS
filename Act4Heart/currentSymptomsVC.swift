//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-04-07.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class CurrentSymptoms: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    var symptomsArray = symptoms
    let textCellIdentifier = "TextCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        pushNavigation("Välj symptom")
    }
    
    func roundedButton(button: UIButton) {
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    @IBAction func backToMenu(sender: AnyObject) {
        let refreshAlert = UIAlertController(title: "Tillbaka till menyn", message: "Du kan inte ångra detta val.", preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "Fortsätt", style: .Default, handler: { (action: UIAlertAction!) in
            self.performSegueWithIdentifier("currentSympToMenu", sender: nil)
        }))
        refreshAlert.addAction(UIAlertAction(title: "Avbryt", style: .Default, handler: { (action: UIAlertAction!) in
            // Cancel
        }))
        presentViewController(refreshAlert, animated: true, completion: nil)
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
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //let row = indexPath.row
        
        self.performSegueWithIdentifier("segueToSeriousSymptom", sender: nil)
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
 
}

