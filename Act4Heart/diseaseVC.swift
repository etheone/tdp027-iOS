//
//  diseaseVC.swift
//  Act4Heart
//
//  Created by Act4Heart on 2016-03-06.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class diseaseVC: UIViewController {
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBAction func readOnButton(sender: AnyObject) {
            UIApplication.sharedApplication().openURL(NSURL(string: "https://www.1177.se/Stockholm/Fakta-och-rad/Sjukdomar/Hjartinfarkt/")!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        scrollView.contentSize.height = 3300
        
        pushNavigation("Om hjärtinfarkt")
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

