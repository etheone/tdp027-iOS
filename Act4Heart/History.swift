//
//  Game.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-02-25.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class History: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var historyArray = [String]()
    let textCellIdentifier = "TextCell"
    var userHistory = Dictionary<String,Dictionary<String,String>>()
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func menuClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("historyToMenu", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get saved user history
        if (NSUserDefaults.standardUserDefaults().objectForKey("userHistory") != nil) {
            self.userHistory = NSUserDefaults.standardUserDefaults().objectForKey("userHistory") as! Dictionary<String,Dictionary<String,String>>
            for (key, _) in userHistory {
                historyArray.insert(key, atIndex: 0)
            }
        }
        
        //self.historyArray = ["Ray Wenderlich", "NSHipster", "iOS Developer Tips", "Jameson Quave", "Natasha The Robot", "Coding Explorer", "That Thing In Swift", "Andrew Bancroft", "iAchieved.it", "Airspeed Velocity"]
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
        
        
        let row = indexPath.row
        let dateData = userHistory[historyArray[row]]!["Start"]!.componentsSeparatedByString(",")
        
        cell.textLabel?.text = dateData[0] + "-" + dateData[1] + "-" + dateData[2] + " " + dateData[3] + ":" + dateData[4]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(userHistory[historyArray[row]]!)
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
