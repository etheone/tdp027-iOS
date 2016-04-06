//
//  TableViewCellController.swift
//  Act4Heart
//
//  Created by Emil Nilsson on 06/04/16.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class TableViewCellController : UITableViewCell {
    
    var frameAdded = false
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var textField: UITextField!
    
    class var expandableHeight: CGFloat { get { return 200 } }
    class var defaultHeight: CGFloat    { get { return 44 } }
    
    func checkHeight() {
        textField.hidden = (frame.size.height < TableViewCellController.expandableHeight)
    }
    
    func watchFrameChanges() {
        if(!frameAdded) {
            addObserver(self, forKeyPath: "frame", options: .New, context: nil)
            frameAdded = true
            checkHeight()
        }
    }
    
    func ignoreFrameChanges() {
        if(frameAdded){
            removeObserver(self, forKeyPath: "frame")
            frameAdded = false
        }
    
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "frame" {
            checkHeight()
        }
    }
    
    
    
}
