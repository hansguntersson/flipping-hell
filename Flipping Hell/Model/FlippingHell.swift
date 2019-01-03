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
         0, 0, 0, 0, 0], goalFlips: 2)
    
    var flipperOrientation = 0
    
    func flipButton(at index: Int) {
        // Complete Level
        if(flipperOrientation == 0) {
            flipperOrientation = 1
        } else {
            flipperOrientation = 0
        }
    }
    
    func loadLevels() {
        let level_1 = Level(sequence: [0, 0, 0, 0, 0,
                                       0, 0, 0, 0, 0,
                                       0, 1, 1, 1, 0,
                                       0, 0, 0, 0, 0,
                                       0, 0, 0, 0, 0],
                            goalFlips: 1)
        let level_2 = Level(sequence: [0, 0, 0, 0, 0,
                                       0, 1, 1, 1, 0,
                                       0, 0, 1, 0, 0,
                                       0, 0, 1, 0, 0,
                                       0, 0, 1, 0, 0],
                            goalFlips: 2)
        let level_3 = Level(sequence: [1, 1, 1, 0, 0,
                                       0, 0, 1, 0, 0,
                                       0, 0, 1, 0, 0,
                                       0, 0, 1, 0, 0,
                                       0, 0, 1, 1, 1],
                            goalFlips: 3)
        let level_4 = Level(sequence: [0, 0, 0, 0, 0,
                                       1, 1, 1, 1, 1,
                                       1, 0, 0, 0, 1,
                                       1, 1, 1, 1, 1,
                                       0, 0, 0, 0, 0],
                            goalFlips: 4)
        let level_5 = Level(sequence: [0, 0, 0, 0, 0,
                                       0, 0, 1, 0, 0,
                                       0, 1, 0, 1, 0,
                                       0, 0, 1, 0, 0,
                                       0, 0, 0, 0, 0],
                            goalFlips: 2)
        let level_6 = Level(sequence: [0, 0, 0, 0, 0,
                                       0, 0, 1, 0, 0,
                                       1, 1, 1, 1, 1,
                                       0, 0, 1, 0, 0,
                                       0, 0, 0, 0, 0],
                            goalFlips: 3)
        let level_7 = Level(sequence: [0, 0, 1, 0, 0,
                                       0, 0, 1, 0, 0,
                                       1, 1, 0, 1, 1,
                                       0, 0, 1, 0, 0,
                                       0, 0, 1, 0, 0],
                            goalFlips: 4)
        let level_8 = Level(sequence: [0, 1, 1, 1, 0,
                                       0, 0, 0, 0, 0,
                                       0, 0, 0, 0, 0,
                                       0, 0, 1, 0, 0,
                                       0, 0, 1, 0, 0],
                            goalFlips: 2)
        let level_9 = Level(sequence: [1, 1, 0, 0, 1,
                                       0, 0, 0, 0, 1,
                                       0, 0, 0, 0, 0,
                                       1, 0, 0, 0, 0,
                                       1, 0, 0, 1, 1],
                            goalFlips: 4)
        let level_10 = Level(sequence: [0, 1, 0, 1, 0,
                                        0, 1, 0, 1, 0,
                                        0, 1, 0, 1, 0,
                                        0, 1, 0, 1, 0,
                                        0, 1, 0, 1, 0],
                             goalFlips: 6)
        
        levels = [level_1, level_2, level_3, level_4, level_5, level_6, level_7, level_8, level_9, level_10]
    }
}
