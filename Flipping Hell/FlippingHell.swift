//
//  FlippingHell.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import Foundation

class FlippingHell {
    
    var levels = [Level]()
    var currentLevel = Level(sequence:
        [0, 0, 0, 0, 0,
         0, 0, 1, 0, 0,
         0, 1, 0, 1, 0,
         0, 0, 1, 0, 0,
         0, 0, 0, 0, 0])
    
    var flipperOrientation = 0
    
    func clickButton(at index: Int) {
        // Complete Level
        if(flipperOrientation == 0) {
            flipperOrientation = 1
        } else {
            flipperOrientation = 0
        }
    }
    
    func loadLevel() {
        // Load Level
        // Reset Level
    }
    
}
