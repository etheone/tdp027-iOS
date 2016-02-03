//
//  Clock.swift
//  Act4Heart
//
//  Created by Joel Karlsson on 2016-02-03.
//  Copyright © 2016 act4heart. All rights reserved.
//

import Foundation
import UIKit

class Clock : NSObject {
    // BLÅ TICKAR NED
    // RÖD RÄKNAR UPP
    
    var timerValue: Int = 0
    var countDown: Bool
    var timerLabel: UILabel
    var time: Int = 0
    var parent: Emergency
    
    init (timerValue: Int, countDown: Bool, timerLabel: UILabel, parent: Emergency) {
        self.timerValue = timerValue
        self.countDown = countDown
        self.timerLabel = timerLabel
        self.parent = parent
        if countDown {
            time = timerValue
        }
    }
    
    var timer = NSTimer()
    
    func updateTimer() {
        if countDown {
            time--
        } else {
            time++
        }
        timerLabel.text = String(format: "%02d:%02d", ((time % 3600) / 60), ((time % 3600) % 60))
        if !countDown && time == timerValue {
            timerLabel.text = "SLUT"
            pause()
            parent.timerDone()
        } else if countDown && time == 0 {
            timerLabel.text = "SLUT"
            pause()
            parent.timerDone()
        }
    }
    
    func play() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTimer"), userInfo: nil, repeats: true)
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func reset() {
        timer.invalidate()
        time = 0
        //timerLabel.text = "0"
    }
}