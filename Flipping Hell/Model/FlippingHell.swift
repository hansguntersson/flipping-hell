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

protocol UpdateLevelViewDelegate {
    func receiveLevelList(StageID: Int, LevelList: [Level])
}

// ********************************** CLASS DEFINITION ********************************** //

class FlippingHell {

    // ********************************** VARIABLES ********************************** //
    
    var levels = [Level]()
    var levels2 = [Level]()
    var stages = [[Level]]()

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
    var UpdateLevelViewDelegateInstance: UpdateLevelViewDelegate!
    
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
        
        // SET 2
        
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
                              goalFlips: 11)
        
        // second stage
        
        let level_31 = Level(sequence: [0, 0, 1, 1, 1,
                                        1, 1, 1, 0, 0,
                                        1, 0, 0, 0, 0,
                                        1, 0, 0, 0, 0,
                                        0, 0, 1, 1, 0],
                             goalFlips: 7)
        let level_32 = Level(sequence: [0, 0, 0, 1, 0,
                                        0, 0, 1, 1, 0,
                                        0, 1, 1, 1, 1,
                                        0, 1, 0, 0, 0,
                                        0, 1, 1, 1, 1],
                             goalFlips: 8)
        let level_33 = Level(sequence: [1, 1, 1, 0, 0,
                                        1, 1, 0, 1, 1,
                                        0, 0, 1, 0, 1,
                                        1, 1, 1, 1, 1,
                                        0, 1, 1, 1, 0],
                             goalFlips: 11)
        let level_34 = Level(sequence: [1, 1, 0, 1, 0,
                                        0, 0, 0, 1, 1,
                                        1, 0, 0, 0, 0,
                                        0, 1, 0, 0, 0,
                                        1, 0, 1, 0, 1],
                             goalFlips: 12)
        let level_35 = Level(sequence: [0, 1, 1, 0, 1,
                                        0, 0, 0, 0, 1,
                                        0, 0, 1, 0, 1,
                                        1, 0, 0, 1, 1,
                                        1, 1, 1, 1, 1],
                             goalFlips: 12)
        let level_36 = Level(sequence: [0, 1, 0, 1, 1,
                                        1, 0, 1, 0, 1,
                                        1, 0, 0, 1, 0,
                                        0, 0, 0, 1, 1,
                                        0, 0, 1, 1, 0],
                             goalFlips: 11)
        let level_37 = Level(sequence: [1, 1, 1, 0, 1,
                                        1, 0, 0, 1, 0,
                                        1, 0, 0, 1, 0,
                                        0, 0, 1, 0, 1,
                                        1, 1, 1, 1, 1],
                             goalFlips: 14)
        let level_38 = Level(sequence: [0, 1, 0, 1, 1,
                                        0, 1, 1, 0, 1,
                                        0, 0, 1, 1, 0,
                                        1, 1, 1, 1, 0,
                                        0, 0, 1, 0, 0],
                             goalFlips: 14)
        let level_39 = Level(sequence: [0, 0, 1, 0, 1,
                                        0, 1, 0, 1, 0,
                                        0, 0, 0, 0, 0,
                                        0, 0, 0, 1, 0,
                                        1, 1, 0, 0, 0],
                             goalFlips: 18)
        let level_40 = Level(sequence: [1, 0, 1, 1, 1,
                                        0, 1, 0, 1, 0,
                                        0, 1, 1, 1, 0,
                                        0, 1, 0, 1, 0,
                                        0, 0, 0, 0, 1],
                             goalFlips: 18)
        
        levels = [level_1, level_2, level_3, level_4, level_5, level_6, level_7, level_8, level_9, level_10, level_11, level_12, level_13, level_14, level_15, level_16, level_17, level_18, level_19, level_20]
        
        levels2 = [level_21, level_22, level_23, level_24, level_25, level_26, level_27, level_28, level_29, level_30, level_31, level_32, level_33, level_34, level_35, level_36, level_37, level_38, level_39, level_40]
        
        stages = [levels, levels2]
    }
    
}


// ********************************** EXTENSIONS ********************************** //

extension FlippingHell: UpdateModelDelegate { // Implements update of model from main view
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

extension FlippingHell: UpdateModelWinDelegate { // Implements update of model from Win view
    func temporary() {
        // anything needed here?
    }
}

extension FlippingHell: UpdateModelLevelsDelegate { // Receives request from Level screen for levels
    func requestLevelList(StageID: Int) {
        UpdateLevelViewDelegateInstance.receiveLevelList(StageID: StageID, LevelList: stages[currentStage])
    }
}


/*
 
 
 // -------------------------------------- TUTORIAL DATA -------------------------------------- //
 
 var WinState_0_7 = [0, 1, 1, 1, 0,
                     0, 0, 0, 0, 0,
                     0, 0, 0, 0, 0,
                     0, 0, 1, 0, 0,
                     0, 0, 1, 0, 0]; // 2
 
 
 // -------------------------------------- 1 - FLIPPING DATA -------------------------------------- //
 
 
 var WinRandom_1_11 = [1, 0, 0, 0, 0,
 1, 0, 0, 1, 1,
 1, 0, 1, 1, 0,
 1, 1, 0, 0, 1,
 0, 0, 0, 1, 0]; // 13
 
 var WinRandom_1_12 = [0, 0, 1, 1, 0,
 1, 0, 1, 0, 0,
 1, 1, 1, 1, 1,
 1, 1, 0, 0, 1,
 1, 0, 1, 1, 1]; // 11
 
 var WinRandom_1_13 = [1, 0, 1, 1, 0,
 0, 0, 1, 0, 0,
 0, 0, 0, 1, 0,
 0, 1, 1, 1, 1,
 0, 1, 0, 1, 1]; // 11
 
 var WinRandom_1_14 = [1, 1, 1, 0, 1,
 1, 0, 1, 0, 0,
 1, 0, 1, 0, 1,
 1, 1, 0, 1, 1,
 1, 0, 0, 0, 1]; // 13
 
 var WinRandom_1_15 = [1, 0, 1, 1, 1,
 0, 0, 0, 1, 1,
 0, 0, 1, 0, 1,
 0, 1, 1, 0, 1,
 0, 1, 0, 0, 0]; // 14
 
 var WinRandom_1_16 = [1, 1, 0, 0, 0,
 0, 1, 1, 1, 1,
 0, 1, 1, 0, 1,
 0, 0, 0, 1, 0,
 1, 0, 0, 0, 1]; // 16
 
 var WinRandom_1_17 = [0, 1, 0, 0, 1,
 0, 1, 0, 0, 1,
 1, 1, 0, 0, 0,
 0, 0, 1, 0, 1,
 0, 1, 0, 1, 1]; // 8
 
 var WinRandom_1_18 = [0, 0, 0, 0, 1,
 1, 1, 1, 1, 1,
 0, 0, 0, 0, 1,
 0, 0, 0, 0, 0,
 1, 1, 1, 1, 0]; // 11
 
 var WinRandom_1_19 = [1, 1, 0, 0, 0,
 1, 0, 0, 0, 0,
 0, 1, 1, 0, 0,
 0, 0, 0, 1, 1,
 1, 1, 1, 1, 0]; // 24
 
 var WinRandom_1_20 = [0, 0, 0, 1, 0,
 0, 0, 1, 0, 1,
 1, 1, 0, 0, 1,
 0, 1, 0, 1, 0,
 1, 0, 1, 0, 1]; // 10
 
 var WinRandom_1_21 = [1, 1, 1, 0, 0,
 0, 1, 0, 1, 1,
 0, 0, 0, 0, 0,
 0, 1, 1, 1, 1,
 0, 0, 0, 1, 1]; // 9
 
 var WinRandom_1_22 = [1, 0, 1, 0, 1,
 0, 1, 0, 0, 0,
 0, 0, 0, 0, 1,
 1, 1, 1, 0, 0,
 0, 1, 1, 1, 1]; // 9
 
 var WinRandom_1_23 = [1, 0, 0, 0, 1,
 0, 0, 0, 0, 1,
 1, 1, 1, 0, 1,
 0, 0, 1, 0, 0,
 1, 1, 0, 0, 1]; // 17
 
 var WinRandom_1_24 = [0, 0, 1, 0, 0,
 0, 1, 1, 0, 0,
 1, 1, 1, 0, 0,
 0, 1, 0, 1, 1,
 1, 0, 1, 0, 1]; // 15
 
 var WinRandom_1_25 = [0, 1, 1, 0, 0,
 1, 1, 0, 0, 1,
 0, 1, 0, 1, 0,
 0, 0, 0, 0, 0,
 0, 1, 1, 1, 0]; // 12
 
 var WinRandom_1_26 = [1, 1, 0, 1, 1,
 0, 0, 0, 1, 0,
 0, 0, 0, 1, 1,
 0, 0, 1, 1, 1,
 1, 0, 0, 1, 1]; // 7
 
 var WinRandom_1_27 = [0, 1, 0, 1, 1,
 1, 0, 0, 1, 0,
 1, 1, 1, 0, 1,
 0, 0, 1, 1, 0,
 1, 1, 0, 0, 0]; // 31
 
 var WinRandom_1_28 = [0, 1, 0, 0, 1,
 0, 1, 1, 0, 1,
 1, 0, 1, 1, 1,
 0, 0, 1, 0, 1,
 0, 1, 0, 0, 0]; // 20
 
 var WinRandom_1_29 = [0, 0, 1, 0, 0,
 1, 1, 0, 1, 1,
 1, 1, 0, 1, 1,
 0, 0, 1, 0, 0,
 1, 0, 0, 1, 0]; // 16
 
 var WinRandom_1_30 = [1, 1, 0, 0, 0,
 0, 1, 1, 1, 1,
 0, 1, 0, 0, 1,
 0, 1, 0, 0, 0,
 1, 1, 1, 0, 0]; // 9
 
 var WinRandom_1_31 = [1, 1, 0, 1, 0,
 1, 1, 0, 0, 0,
 0, 0, 1, 1, 0,
 0, 0, 1, 1, 0,
 1, 1, 1, 0, 0]; // 20
 
 var WinRandom_1_32 = [0, 0, 0, 0, 0,
 0, 0, 0, 1, 1,
 1, 0, 1, 1, 0,
 0, 1, 1, 1, 1,
 0, 1, 1, 1, 1]; // 10
 
 var WinRandom_1_33 = [1, 0, 0, 1, 1,
 1, 0, 0, 1, 1,
 1, 1, 1, 1, 0,
 0, 1, 0, 0, 1,
 1, 0, 0, 1, 0]; // 10
 
 var WinRandom_1_34 = [0, 0, 0, 0, 1,
 0, 0, 1, 0, 1,
 0, 1, 1, 1, 0,
 1, 0, 0, 1, 1,
 0, 0, 1, 1, 0]; // 16
 
 var WinRandom_1_35 = [0, 0, 1, 1, 1,
 1, 1, 1, 0, 0,
 1, 0, 0, 0, 0,
 1, 1, 1, 1, 1,
 1, 0, 1, 0, 1]; // 10
 
 var WinRandom_1_36 = [1, 1, 0, 0, 1,
 1, 0, 0, 1, 0,
 0, 1, 0, 1, 0,
 1, 1, 0, 1, 0,
 0, 0, 0, 0, 0]; // 12
 
 var WinRandom_1_37 = [0, 1, 0, 1, 1,
 1, 0, 1, 0, 0,
 1, 1, 0, 0, 1,
 0, 0, 0, 1, 0,
 1, 1, 1, 0, 1]; // 21
 
 var WinRandom_1_38 = [1, 1, 1, 0, 0,
 1, 0, 0, 1, 1,
 1, 0, 0, 1, 0,
 1, 0, 1, 1, 0,
 1, 0, 0, 0, 0]; // 11
 
 var WinRandom_1_39 = [0, 1, 1, 1, 0,
 0, 1, 0, 0, 0,
 0, 0, 0, 0, 1,
 1, 0, 0, 1, 1,
 1, 0, 1, 0, 1]; // 9
 
 var WinRandom_1_40 = [0, 0, 1, 1, 0,
 0, 1, 0, 0, 0,
 1, 1, 1, 0, 0,
 1, 0, 0, 1, 0,
 0, 0, 1, 0, 0]; // 11
 
 var WinRandom_1_41 = [0, 1, 0, 1, 0,
 0, 0, 0, 0, 0,
 0, 0, 1, 1, 0,
 1, 1, 0, 0, 1,
 0, 0, 1, 1, 0]; // 7
 
 var WinRandom_1_42 = [0, 1, 1, 0, 1,
 1, 0, 0, 0, 1,
 1, 0, 0, 1, 0,
 0, 0, 1, 0, 1,
 1, 0, 1, 1, 1]; // 11
 
 var WinRandom_1_43 = [1, 0, 1, 1, 0,
 1, 0, 1, 1, 0,
 1, 0, 0, 0, 1,
 0, 1, 1, 0, 0,
 1, 0, 1, 0, 0]; // 10
 
 var WinRandom_1_44 = [0, 1, 0, 1, 1,
 1, 1, 0, 0, 1,
 0, 1, 1, 0, 0,
 1, 0, 1, 0, 0,
 1, 0, 0, 1, 1]; // 11
 
 var WinRandom_1_45 = [1, 1, 1, 1, 1,
 0, 1, 1, 1, 0,
 0, 1, 0, 0, 0,
 0, 0, 1, 0, 1,
 0, 0, 1, 0, 1]; // 10
 
 var WinRandom_1_46 = [1, 1, 0, 1, 1,
 0, 1, 1, 1, 1,
 0, 0, 0, 0, 1,
 1, 1, 0, 1, 0,
 0, 0, 1, 0, 0]; // 37
 
 var WinRandom_1_47 = [1, 1, 0, 1, 1,
 0, 1, 0, 0, 1,
 1, 1, 0, 0, 1,
 0, 0, 0, 0, 0,
 1, 0, 1, 1, 0]; // 11
 
 var WinRandom_1_48 = [0, 0, 1, 1, 1,
 1, 0, 0, 0, 0,
 1, 1, 0, 1, 1,
 0, 0, 0, 1, 0,
 1, 1, 0, 0, 0]; // 17
 
 var WinRandom_1_49 = [1, 1, 1, 0, 0,
 1, 0, 0, 1, 0,
 1, 0, 1, 1, 1,
 1, 1, 0, 0, 1,
 1, 1, 1, 1, 0]; // 12
 
 var WinRandom_1_50 = [1, 1, 1, 0, 0,
 0, 1, 1, 1, 0,
 0, 0, 1, 0, 0,
 1, 1, 1, 1, 0,
 1, 1, 0, 1, 0]; // 14
 
 var WinRandom_1_51 = [0, 0, 1, 0, 1,
 1, 0, 0, 0, 0,
 1, 0, 1, 0, 0,
 1, 1, 0, 0, 0,
 1, 0, 1, 1, 0]; // 8
 
 var WinRandom_1_52 = [0, 1, 1, 1, 0,
 1, 1, 0, 0, 0,
 1, 1, 1, 0, 0,
 1, 0, 0, 1, 0,
 0, 1, 1, 1, 0]; // 10
 
 var WinRandom_1_53 = [0, 0, 1, 1, 0,
 1, 1, 1, 0, 0,
 1, 0, 0, 0, 0,
 1, 0, 0, 0, 1,
 1, 0, 1, 1, 1]; // 6
 
 var WinRandom_1_54 = [0, 0, 1, 0, 0,
 0, 1, 0, 1, 1,
 0, 1, 0, 0, 0,
 1, 1, 0, 0, 1,
 0, 1, 1, 0, 1]; // 16
 
 var WinRandom_1_55 = [1, 0, 0, 1, 1,
 0, 0, 0, 1, 1,
 0, 1, 0, 1, 1,
 0, 1, 0, 0, 1,
 1, 0, 1, 1, 1]; // 11
 
 var WinRandom_1_56 = [1, 0, 0, 0, 0,
 1, 1, 0, 1, 1,
 1, 0, 1, 0, 0,
 1, 0, 0, 0, 0,
 1, 1, 1, 0, 0]; // 10
 
 var WinRandom_1_57 = [1, 1, 0, 1, 0,
 0, 0, 1, 0, 1,
 1, 0, 0, 1, 0,
 1, 1, 0, 0, 0,
 0, 1, 1, 0, 1]; // 17
 
 var WinRandom_1_58 = [1, 1, 0, 0, 0,
 1, 1, 1, 1, 0,
 0, 1, 1, 0, 1,
 0, 1, 1, 1, 1,
 1, 0, 0, 0, 1]; // 21
 
 var WinRandom_1_59 = [1, 1, 1, 1, 0,
 0, 1, 1, 0, 0,
 0, 0, 0, 1, 1,
 0, 0, 1, 1, 0,
 1, 1, 0, 1, 0]; // 7
 
 var WinRandom_1_60 = [1, 0, 0, 0, 0,
 1, 1, 1, 0, 1,
 0, 0, 1, 1, 0,
 1, 1, 1, 0, 0,
 1, 0, 1, 1, 0]; // 21
 
 var WinRandom_1_61 = [1, 1, 1, 0, 0,
 0, 0, 0, 1, 1,
 1, 0, 0, 1, 0,
 0, 0, 1, 1, 0,
 0, 1, 1, 0, 0]; // 18
 
 var WinRandom_1_62 = [1, 1, 0, 0, 1,
 0, 1, 0, 1, 0,
 0, 1, 1, 0, 0,
 0, 1, 1, 0, 0,
 1, 1, 1, 0, 0]; // 11
 
 var WinRandom_1_63 = [1, 0, 0, 1, 0,
 0, 0, 0, 1, 1,
 0, 0, 0, 1, 1,
 1, 1, 1, 1, 0,
 1, 0, 0, 1, 1]; // 10
 
 var WinRandom_1_64 = [0, 0, 1, 1, 1,
 0, 0, 0, 0, 0,
 0, 0, 0, 0, 1,
 1, 1, 1, 0, 0,
 1, 0, 0, 1, 0]; // 15
 
 var WinRandom_1_65 = [0, 0, 0, 0, 0,
 0, 1, 0, 0, 0,
 0, 1, 0, 0, 1,
 0, 0, 1, 1, 1,
 1, 1, 1, 1, 0]; // 5
 
 var WinRandom_1_66 = [0, 0, 1, 1, 1,
 1, 1, 1, 1, 1,
 1, 1, 0, 1, 1,
 1, 1, 1, 1, 0,
 1, 0, 0, 0, 0]; // 11
 
 var WinRandom_1_67 = [0, 1, 0, 0, 1,
 0, 0, 0, 0, 0,
 1, 0, 0, 1, 1,
 1, 1, 1, 0, 1,
 0, 0, 0, 0, 1]; // 8
 
 var WinRandom_1_68 = [0, 1, 0, 0, 0,
 1, 1, 1, 1, 0,
 0, 1, 0, 1, 1,
 0, 1, 0, 1, 0,
 0, 1, 0, 0, 1]; // 8
 
 var WinRandom_1_69 = [0, 0, 0, 1, 1,
 1, 0, 0, 1, 1,
 1, 1, 0, 1, 0,
 1, 0, 0, 0, 1,
 1, 0, 0, 1, 1]; // 29
 
 var WinRandom_1_70 = [0, 1, 0, 1, 0,
 1, 0, 1, 1, 1,
 0, 0, 0, 0, 0,
 1, 1, 0, 0, 1,
 0, 0, 0, 0, 0]; // 17
 
 var WinRandom_1_71 = [1, 0, 0, 0, 0,
 1, 0, 0, 0, 1,
 0, 0, 1, 0, 0,
 0, 0, 0, 0, 0,
 1, 1, 1, 1, 0]; // 14
 
 var WinRandom_1_72 = [0, 0, 0, 1, 1,
 0, 1, 1, 0, 1,
 0, 1, 0, 1, 0,
 0, 0, 0, 1, 1,
 1, 1, 0, 0, 0]; // 12
 
 var WinRandom_1_73 = [0, 0, 0, 1, 0,
 1, 1, 1, 1, 0,
 0, 0, 0, 1, 1,
 0, 0, 0, 1, 0,
 1, 1, 1, 0, 1]; // 5
 
 var WinRandom_1_74 = [1, 1, 0, 1, 1,
 1, 0, 1, 0, 1,
 1, 0, 0, 1, 1,
 0, 0, 1, 0, 0,
 0, 0, 1, 0, 0]; // 13
 
 var WinRandom_1_75 = [1, 1, 0, 1, 0,
 0, 1, 1, 1, 0,
 0, 0, 0, 1, 0,
 0, 0, 0, 1, 0,
 0, 1, 0, 0, 1]; // 14
 
 var WinRandom_1_76 = [1, 1, 0, 1, 0,
 0, 0, 0, 0, 1,
 1, 1, 1, 0, 0,
 1, 0, 0, 1, 0,
 0, 0, 0, 0, 0]; // 14
 
 var WinRandom_1_77 = [1, 1, 1, 1, 0,
 1, 1, 0, 1, 0,
 0, 1, 1, 1, 0,
 0, 0, 1, 0, 1,
 1, 0, 0, 0, 0]; // 14
 
 var WinRandom_1_78 = [1, 0, 1, 1, 1,
 0, 0, 0, 1, 0,
 0, 0, 1, 0, 1,
 0, 0, 0, 0, 0,
 1, 0, 1, 1, 0]; // 11
 
 var WinRandom_1_79 = [1, 1, 0, 1, 0,
 0, 0, 0, 0, 0,
 1, 1, 0, 1, 0,
 1, 0, 1, 1, 1,
 0, 0, 0, 1, 1]; // 13
 
 var WinRandom_1_80 = [1, 1, 0, 0, 0,
 0, 0, 0, 1, 1,
 0, 0, 0, 0, 0,
 1, 0, 1, 0, 1,
 1, 1, 1, 0, 1]; // 13
 
 var WinRandom_1_81 = [1, 1, 0, 0, 1,
 0, 0, 1, 0, 1,
 1, 1, 1, 1, 1,
 1, 0, 0, 1, 0,
 0, 0, 0, 1, 1]; // 14
 
 var WinRandom_1_82 = [0, 0, 0, 1, 0,
 1, 1, 1, 1, 1,
 0, 0, 0, 0, 0,
 0, 0, 0, 1, 0,
 1, 1, 1, 0, 0]; //  8
 
 var WinRandom_1_83 = [0, 0, 1, 0, 1,
 0, 0, 0, 0, 1,
 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0,
 0, 1, 1, 0, 1]; //  7
 
 var WinRandom_1_84 = [1, 1, 1, 0, 1,
 1, 0, 0, 0, 1,
 0, 1, 0, 1, 1,
 1, 0, 0, 0, 1,
 1, 0, 1, 0, 0]; //  12
 
 var WinRandom_1_85 = [0, 0, 1, 1, 0,
 0, 0, 0, 1, 0,
 0, 0, 0, 1, 0,
 0, 1, 1, 1, 0,
 1, 1, 0, 1, 1]; //  10
 
*/
