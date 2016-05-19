//
//  appVC.swift
//  Act4Heart
//
//  Created by Act4Heart on 2016-03-06.
//  Copyright © 2016 act4heart. All rights reserved.
//

import UIKit

class appVC: UIViewController {
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var nextButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var backButtonWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet var backButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var currentImage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentImage = 1
        
        imageView.image = UIImage(named: "image" + String(currentImage))
        
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let sizeToSet = screenSize.width * 0.45
        nextButtonWidthConstraint.constant = sizeToSet
        
        imageView.layer.borderWidth = 1.0
        //imageVIew.layer.masksToBounds = false
        imageView.layer.borderColor = UIColor.whiteColor().CGColor
        imageView.layer.cornerRadius = 2.0
        
        backButtonWidthConstraint.constant = sizeToSet
        
        self.navBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navBar.shadowImage = UIImage()
        self.navBar.translucent = true
        
        pushNavigation("Om appen")
        
        roundedButton(nextButton)
        roundedButton(backButton)
        
        nextButton.addTarget(self, action: #selector(appVC.changeImage(_:)), forControlEvents: .TouchUpInside)
        
        backButton.addTarget(self, action: #selector(appVC.changeImage(_:)), forControlEvents: .TouchUpInside)
        
        backButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func changeImage(sender: UIButton) {
        
        if sender == nextButton {
            
            if(currentImage < 16) {
                
                currentImage += 1
                let imageToSet = "image" + String(currentImage)
                imageView.image = UIImage(named: imageToSet)
            }
            
        } else if(sender == backButton) {
            
            if(currentImage > 1) {
                currentImage -= 1
                let imageToSet = "image" + String(currentImage)
                imageView.image = UIImage(named: imageToSet)
            }
        }
        
        print(currentImage)
        
        if(currentImage == 1) {
            
            backButton.hidden = true
            
        } else if(currentImage == 16) {
          
            nextButton.hidden = true
            
        } else {
            nextButton.hidden = false
            backButton.hidden = false
        }
        
    }

    
    /*
    override func prefersStatusBarHidden() -> Bool {
    return true
    }
    */
}

