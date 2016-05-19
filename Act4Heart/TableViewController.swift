//
//  TableViewController.swift
//  Act4Heart
//
//  Created by Act4Heart on 06/04/16.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

let cellId = "cell"

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBar: UINavigationBar!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        
        //roundedButton(troubleButton)
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        pushNavigation("Om hjärtinfarkt")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var selectedIndexPath : NSIndexPath?
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        //temp return or maybe not?
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return symptoms.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! TableViewCellController
        cell.titleLabel.text = symptoms[indexPath.row]
        cell.titleLabel.textColor = UIColor.whiteColor()
        cell.textLabel2.text = symptomsInfo[indexPath.row]
        cell.textLabel2.textColor = UIColor.whiteColor()
        
        
        //print("hej")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let previousIndexPath = selectedIndexPath
        if(indexPath == selectedIndexPath) {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        var indexPaths : Array<NSIndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        
        if indexPaths.count > 0 {
            tableView.reloadRowsAtIndexPaths(indexPaths, withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
        //print(indexPaths)
        //print("above")
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! TableViewCellController).watchFrameChanges()
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        (cell as! TableViewCellController).ignoreFrameChanges()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //print(" tja")
        //print(indexPath)
        var expandableHeight: CGFloat
        var expandableHeight2: CGFloat
        var expandableHeight4: CGFloat
        var expandableHeight1: CGFloat
        var expandableHeight3: CGFloat
        
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        if (width <= 320) {
            expandableHeight = 970 as CGFloat
            expandableHeight2 = 520 as CGFloat
            expandableHeight4 = 500 as CGFloat
            expandableHeight1 = 240 as CGFloat
            expandableHeight3 = 955 as CGFloat
        } else {
            expandableHeight = 800 as CGFloat
            expandableHeight2 = 470 as CGFloat
            expandableHeight4 = 500 as CGFloat
            expandableHeight1 = 240 as CGFloat
            expandableHeight3 = 700 as CGFloat
        }
        
        
        var defaultHeight: CGFloat    { get { return 44 } }
        var defaultHeight1: CGFloat    { get { return 65 } }
        

        //print("indexPath is \(indexPath.row)")
        if indexPath == selectedIndexPath {
            switch(indexPath.row) {
            case 0:
                print("case 0")
                return expandableHeight
            case 2:
                return expandableHeight1
            case 1:
                print("case 123")
                return expandableHeight4
            case 3:
                return expandableHeight2
            case 4:
                print("Case 4")
                return expandableHeight3
            default:
                return TableViewCellController.defaultHeight
            }
            
        } else {
            switch(indexPath.row) {
            case 0, 1, 4:
                return defaultHeight
            case 2, 3:
                return defaultHeight1
            default:
                return defaultHeight
            }
            
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
