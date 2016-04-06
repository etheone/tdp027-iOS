//
//  TableViewController.swift
//  Act4Heart
//
//  Created by Emil Nilsson on 06/04/16.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

let cellId = "cell"

class TableViewController: UITableViewController {
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        
        //temp return or maybe not?
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath) as! TableViewCellController
        cell.titleLabel.text = "Test title"
        cell.textField.text = "Lorem ipsum hejsan svejsanLorem ipsum hejsan svejsanLorem ipsum hejsan svejsanLorem ipsum hejsan svejsanLorem ipsum hejsan svejsanLorem ipsum hejsan svejsanLorem ipsum hejsan svejsanLorem ipsum hejsan svejsanLorem ipsum hejsan svejsanLorem ipsum hejsan svejsan"
        return cell
    }
    
}
