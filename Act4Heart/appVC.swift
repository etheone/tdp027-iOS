//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-03-06.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class appVC: UIViewController {
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    @IBOutlet var imageVIew: UIImageView!
    
    @IBOutlet var nextButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var backButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        imageVIew.image = UIImage(named: "guideImage1")
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let sizeToSet = screenSize.width * 0.45
        nextButtonWidthConstraint.constant = sizeToSet
        
        imageVIew.layer.borderWidth = 1.0
        //imageVIew.layer.masksToBounds = false
        imageVIew.layer.borderColor = UIColor.whiteColor().CGColor
        imageVIew.layer.cornerRadius = 2.0
        
        backButtonWidthConstraint.constant = sizeToSet
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        pushNavigation("Om appen")
        
        roundedButton(nextButton)
        roundedButton(backButton)
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

