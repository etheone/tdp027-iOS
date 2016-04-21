//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-03-06.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class miscVC: UIViewController {
    
    
    @IBOutlet weak var buttonDisease: UIButton!
    @IBOutlet weak var buttonSymptoms: UIButton!
    @IBOutlet weak var buttonHistory: UIButton!
    @IBOutlet weak var buttonApp: UIButton!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBAction func diseasePressed(sender: AnyObject) {
    }
    
    @IBAction func symptomsPressed(sender: AnyObject) {
    }
    
    @IBAction func historyPressed(sender: AnyObject) {
    }
    
    @IBAction func appPressed(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundedButton(buttonDisease)
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

