//
//  TableViewController.swift
//  Act4Heart
//
//  Created by Emil Nilsson on 06/04/16.
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
        
        pushNavigation("Om symptom")
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
        if indexPath == selectedIndexPath {
            return TableViewCellController.expandableHeight
        } else {
            return TableViewCellController.defaultHeight
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
