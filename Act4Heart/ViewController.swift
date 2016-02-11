//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-01-27.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var informationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        informationButton.layer.cornerRadius = 3
        informationButton.layer.borderWidth = 1
        informationButton.layer.borderColor = UIColor.whiteColor().CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

}

