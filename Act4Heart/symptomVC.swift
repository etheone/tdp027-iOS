//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-03-06.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class symptomVC: UIViewController {
    
    @IBOutlet weak var troubleButton: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //roundedButton(troubleButton)
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
    }
    
    func roundedButton(button: UIButton) {
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    /*
    override func prefersStatusBarHidden() -> Bool {
    return true
    }
    */
}

