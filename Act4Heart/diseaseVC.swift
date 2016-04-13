//
//  ViewController.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-03-06.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class diseaseVC: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        scrollView.contentSize.height = 800
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

