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

    var timerValue: Int = 0
    var countDown: Bool
    var timerLabel: UILabel
    var time: Int = 0
    var parent: Emergency
    var initialTime: Int = 0
    
    init (timerValue: Int, countDown: Bool, timerLabel: UILabel, parent: Emergency) {
        self.timerValue = timerValue
        self.initialTime = timerValue
        self.countDown = countDown
        self.timerLabel = timerLabel
        self.parent = parent
        if countDown {
            time = timerValue
        }
    }
    
    var timer = NSTimer()

    func updateTimer() {
        // Determine if the clock ticks up or down
        if countDown {
            time -= 1
        } else {
            time += 1

        }
        // Only display hours if needed
        if time < 3600 {
            timerLabel.text = String(format: "%02d:%02d", ((time % 3600) / 60), ((time % 3600) % 60))
        } else {
            timerLabel.text = String(format: "%02d:%02d:%02d", (time / 3600), ((time % 3600) / 60), ((time % 3600) % 60))
        }
        // When the timer extends its limit
        if !countDown && time == timerValue {
            pause()
            parent.timerDone()
        } else if countDown && time == 0 {
            pause()
            parent.timerDone()
        }
    }
    
    func play() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(Clock.updateTimer), userInfo: nil, repeats: true)
    }
    
    func pause() {
        timer.invalidate()
    }
    
    func reset() {
        timer.invalidate()
        time = initialTime
    }
}