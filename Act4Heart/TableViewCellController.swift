//
//  TableViewCellController.swift
//  Act4Heart
//
//  Created by Emil Nilsson on 06/04/16.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class TableViewCellController : UITableViewCell {
    
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var textField: UITextField!
    
    class var expandableHeight: CGFloat { get { return 200 } }
    class var defaultHeight: CGFloat    { get { return 44 } }
    
    func checkHeight() {
        textField.hidden = (frame.size.height < TableViewCellController.expandableHeight)
    }
    
}
