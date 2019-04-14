//
//  FlippingHell.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import Foundation

// ********************************** PROTOCOLS ********************************** //

protocol UpdateMainViewDelegate {
    func receiveLevel(LevelID: Int, GoalFlips: Int, Sequence: [Int])
}

// ********************************** CLASS DEFINITION ********************************** //

class FlippingHell {

    // ********************************** VARIABLES ********************************** //
    
    var levels = [Level]()
    var currentLevel = 0
    var currentStage = 0
    
    init() {
        loadLevels()
        // synchronise
        // load current level from memory
        // unlocks and settings
    }
    
    // ********************************** DELEGATES ********************************** //
    
    var UpdateMainViewDelegateInstance: UpdateMainViewDelegate!
    
    // ********************************** FUNCTIONS ********************************** //
    
    func loadLevels() { // Load levels into game
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
        let level_8 = Level(sequence: [0, 0, 0, 0, 0,
                                       0, 1, 1, 1, 0,
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
        let level_11 = Level(sequence: [0, 0, 0, 0, 0,
                                        0, 0, 0, 0, 0,
                                        0, 0, 1, 0, 0,
                                        0, 0, 0, 0, 0,
                                        0, 0, 0, 0, 0],
                             goalFlips: 4)
        let level_12 = Level(sequence: [0, 0, 0, 0, 0,
                                        0, 1, 1, 1, 0,
                                        0, 0, 1, 0, 0,
                                        0, 0, 1, 0, 0,
                                        0, 0, 0, 0, 0],
                             goalFlips: 5)
        let level_13 = Level(sequence: [1, 0, 0, 0, 0,
                                        1, 0, 0, 0, 0,
                                        1, 1, 1, 1, 1,
                                        0, 0, 0, 0, 1,
                                        0, 0, 0, 0, 1],
                             goalFlips: 4)
        let level_14 = Level(sequence: [0, 0, 0, 0, 0,
                                        0, 1, 1, 1, 0,
                                        0, 1, 0, 1, 0,
                                        0, 1, 1, 1, 0,
                                        0, 0, 0, 0, 0],
                             goalFlips: 5)
        let level_15 = Level(sequence: [0, 0, 0, 0, 0,
                                        0, 0, 1, 0, 0,
                                        0, 1, 1, 1, 0,
                                        0, 0, 1, 0, 0,
                                        0, 0, 0, 0, 0],
                             goalFlips: 6)
        let level_16 = Level(sequence: [0, 0, 0, 0, 0,
                                        0, 1, 1, 1, 0,
                                        1, 1, 0, 1, 1,
                                        0, 1, 1, 1, 0,
                                        0, 0, 0, 0, 0],
                             goalFlips: 6)
        let level_17 = Level(sequence: [0, 0, 1, 0, 0,
                                        0, 0, 0, 0, 0,
                                        1, 0, 0, 0, 1,
                                        0, 0, 0, 0, 0,
                                        0, 0, 1, 0, 0],
                             goalFlips: 6)
        let level_18 = Level(sequence: [0, 0, 0, 0, 0,
                                        1, 1, 1, 1, 1,
                                        0, 1, 0, 1, 0,
                                        1, 1, 1, 1, 1,
                                        0, 0, 0, 0, 0],
                             goalFlips: 7)
        let level_19 = Level(sequence: [0, 0, 1, 0, 0,
                                        0, 1, 0, 1, 0,
                                        1, 0, 0, 0, 1,
                                        0, 1, 0, 1, 0,
                                        0, 0, 1, 0, 0],
                             goalFlips: 7)
        let level_20 = Level(sequence: [0, 1, 1, 1, 0,
                                        0, 1, 0, 1, 0,
                                        0, 0, 0, 0, 0,
                                        0, 1, 0, 1, 0,
                                        0, 1, 1, 1, 0],
                             goalFlips: 7)
        /*
         let level_21 = Level(sequence: [0, 0, 1, 0, 0,
         0, 1, 1, 1, 0,
         1, 1, 1, 1, 1,
         0, 1, 0, 1, 0,
         0, 1, 1, 1, 0],
         goalFlips: 7)
         let level_22 = Level(sequence: [0, 1, 1, 1, 0,
         0, 1, 0, 1, 0,
         0, 1, 1, 1, 0,
         0, 1, 0, 1, 0,
         0, 1, 1, 1, 0],
         goalFlips: 8)
         let level_23 = Level(sequence: [1, 1, 1, 1, 1,
         0, 0, 0, 0, 1,
         0, 1, 1, 0, 1,
         0, 1, 0, 0, 1,
         0, 1, 1, 1, 1],
         goalFlips: 8)
         let level_24 = Level(sequence: [1, 1, 0, 1, 1,
         1, 1, 1, 1, 1,
         0, 1, 0, 1, 0,
         1, 1, 1, 1, 1,
         1, 1, 0, 1, 1],
         goalFlips: 8)
         let level_25 = Level(sequence: [0, 1, 0, 1, 0,
         1, 0, 1, 0, 1,
         0, 1, 0, 1, 0,
         1, 0, 1, 0, 1,
         0, 1, 0, 1, 0],
         goalFlips: 8)
         let level_26 = Level(sequence: [1, 1, 1, 1, 1,
         0, 1, 1, 1, 0,
         0, 0, 1, 0, 0,
         0, 1, 1, 1, 0,
         1, 1, 1, 1, 1],
         goalFlips: 9)
         let level_27 = Level(sequence: [1, 0, 0, 0, 1,
         0, 1, 0, 1, 0,
         0, 0, 1, 0, 0,
         0, 1, 0, 1, 0,
         1, 0, 0, 0, 1],
         goalFlips: 9)
         let level_28 = Level(sequence: [1, 1, 1, 0, 1,
         1, 0, 1, 0, 1,
         1, 0, 1, 0, 1,
         1, 0, 1, 0, 1,
         1, 0, 1, 1, 1],
         goalFlips: 9)
         let level_29 = Level(sequence: [0, 1, 1, 1, 0,
         1, 1, 0, 1, 1,
         0, 1, 0, 1, 0,
         1, 1, 0, 1, 1,
         0, 1, 1, 1, 0],
         goalFlips: 9)
         let level_30 = Level(sequence: [1, 1, 0, 1, 1,
         1, 0, 0, 0, 1,
         0, 0, 0, 0, 0,
         1, 0, 0, 0, 1,
         1, 1, 0, 1, 1],
         goalFlips: 11) */
        
        
        levels = [level_1, level_2, level_3, level_4, level_5, level_6, level_7, level_8, level_9, level_10, level_11, level_12, level_13, level_14, level_15, level_16, level_17, level_18, level_19, level_20, ] // level_21, level_22, level_23, level_24, level_25, level_26, level_27, level_28, level_29, level_30
    }
    
}


// ********************************** EXTENSIONS ********************************** //

extension FlippingHell: UpdateModelDelegate { // Implements update of model
    func gameWon(LevelID: Int, Flips: Int, ButtonsClicked: [Int]) {
    
        levels[currentLevel].attempts += 1
        levels[currentLevel].isComplete = true
        
        if (Flips < levels[currentLevel].minFlips) {
            levels[currentLevel].minFlips = Flips
            levels[currentLevel].minMoves = ButtonsClicked
        }
        
        if (currentLevel == 19) {
            print("Stage completed")
        } else {
            print("Level completed")
        }
    }
    
    func gameReset(LevelID: Int) {
        levels[currentLevel].attempts += 1
    }
    
    func requestLevel(StageID: Int, LevelID: Int) {
        currentLevel = LevelID
        currentStage = StageID
        
        UpdateMainViewDelegateInstance.receiveLevel(LevelID: currentLevel, GoalFlips: levels[currentLevel].GoalFlips, Sequence: levels[currentLevel].sequence)
    }
}
