//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-03-06.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class miscVC: UIViewController {
    
    
    @IBOutlet weak var buttonSymptoms: UIButton!
    @IBOutlet weak var buttonHistory: UIButton!
    @IBOutlet weak var buttonApp: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    @IBOutlet weak var constraint1: NSLayoutConstraint!
    @IBOutlet weak var constraint2: NSLayoutConstraint!
    @IBOutlet weak var constraint3: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        if (width <= 320) {
            constraintTop.constant = 30.0
            constraint1.constant = 30.0
            constraint2.constant = 30.0
            constraint3.constant = 30.0
        }
        
        //roundedButton(buttonDisease)
        roundedButton(buttonSymptoms)
        roundedButton(buttonHistory)
        roundedButton(buttonApp)
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        pushNavigation("Övrigt")
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

