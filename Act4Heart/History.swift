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
    @IBOutlet weak var titleTop: UILabel!
    @IBOutlet weak var emergencyModal: UIView!
    @IBOutlet weak var infoLeft: UILabel!
    @IBOutlet weak var infoRight: UILabel!
    
    @IBAction func closeModalClicked(sender: AnyObject) {
        emergencyModal.hidden = true
    }
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        pushNavigation("Historik")
        
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
    
    func getDateFromString(dateString:String, outType:String = "") -> String {
        let dateData = dateString.componentsSeparatedByString(",")
        if (outType == "date") {
            return dateData[0] + "-" + dateData[1] + "-" + dateData[2]
        } else if (outType == "clock") {
            return dateData[3] + ":" + dateData[4]
        }
        
        return dateData[0] + "-" + dateData[1] + "-" + dateData[2] + " " + dateData[3] + ":" + dateData[4]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
        let row = indexPath.row
        
        //let dateData = userHistory[historyArray[row]]!["Start"]!.componentsSeparatedByString(",")
        
        var date = ""
        var start = "-"
        var second = "-"
        var third = "-"
        var sos = "-"
        var total = 0
        
        if userHistory[historyArray[row]]!["Start"]! != "" {
            start = userHistory[historyArray[row]]!["Start"]!
            date = getDateFromString(start, outType: "date")
            start = getDateFromString(start, outType: "clock")
            total += 1
        }
        if userHistory[historyArray[row]]!["Second"]! != "" {
            second = userHistory[historyArray[row]]!["Second"]!
            second = getDateFromString(second, outType: "clock")
            total += 1
        }
        if userHistory[historyArray[row]]!["Third"]! != "" {
            third = userHistory[historyArray[row]]!["Third"]!
            third = getDateFromString(third, outType: "clock")
            total += 1
        }
        
        sos = "-" // Fix later
        
        titleTop.text = "Akutsituation " + date
        infoRight.text = "\(start)\n\(second)\n\(third)\n\n\(total)\n\(sos)\n"
        
        print(userHistory[historyArray[row]]!)
        emergencyModal.hidden = false
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
