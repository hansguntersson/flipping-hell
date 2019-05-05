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
    func receiveLevelList(StageID: Int, LevelList: [Level], CurrentStage: Int, CurrentLevel: Int)
}

protocol UpdateStageViewDelegate {
    func receiveStageList(StageID: Int, LevelList: [Level])
}

// ********************************** CLASS DEFINITION ********************************** //

class FlippingHell {

    // ********************************** VARIABLES ********************************** //
    
    var levels_1 = [Level]()
    var levels_2 = [Level]()
    var levels_3 = [Level]()
    var levels_4 = [Level]()
    var levels_5 = [Level]()
    var stages = [[Level]]()

    var currentLevel = 0
    
    var stageUnlocks: [Bool] = [true, false, false, false, false]
    var stageStars: [Int] = [0, 0, 0, 0, 0] // number of stars obtained for each level
    /* 4 stars is blue, 3 stars is gold, 2 stars is silver, 1 star is bronze, 0 stars is none */
    
    
    var currentStage = 0
    
    init() {
        loadLevels()
    }
    
    // ********************************** DELEGATES ********************************** //
    
    var UpdateMainViewDelegateInstance: UpdateMainViewDelegate!
    var UpdateLevelViewDelegateInstance: UpdateLevelViewDelegate!
    
    // ********************************** FUNCTIONS ********************************** //
    
    func calculateStars() {
        // Loop through stages
        // loop through each level, and look at star score for minimum
        
    }
    
    func loadLevels() { // Load levels into game
        
        // STAGE 1
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
        
        // STAGE 2
        
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
        
        // STAGE 3
        
        let level_41 = Level(sequence: [1, 0, 0, 0, 0,
                                        1, 0, 0, 1, 1,
                                        1, 0, 1, 1, 0,
                                        1, 1, 0, 0, 1,
                                        0, 0, 0, 1, 0],
                             goalFlips: 13)
        let level_42 = Level(sequence: [0, 0, 1, 1, 0,
                                        1, 0, 1, 0, 0,
                                        1, 1, 1, 1, 1,
                                        1, 1, 0, 0, 1,
                                        1, 0, 1, 1, 1],
                             goalFlips: 11)
        let level_43 = Level(sequence: [1, 0, 1, 1, 0,
                                        0, 0, 1, 0, 0,
                                        0, 0, 0, 1, 0,
                                        0, 1, 1, 1, 1,
                                        0, 1, 0, 1, 1],
                             goalFlips: 11)
        let level_44 = Level(sequence: [1, 1, 1, 0, 1,
                                        1, 0, 1, 0, 0,
                                        1, 0, 1, 0, 1,
                                        1, 1, 0, 1, 1,
                                        1, 0, 0, 0, 1],
                             goalFlips: 13)
        let level_45 = Level(sequence: [1, 0, 1, 1, 1,
                                        0, 0, 0, 1, 1,
                                        0, 0, 1, 0, 1,
                                        0, 1, 1, 0, 1,
                                        0, 1, 0, 0, 0],
                             goalFlips: 14)
        let level_46 = Level(sequence: [1, 1, 0, 0, 0,
                                        0, 1, 1, 1, 1,
                                        0, 1, 1, 0, 1,
                                        0, 0, 0, 1, 0,
                                        1, 0, 0, 0, 1],
                             goalFlips: 16)
        let level_47 = Level(sequence: [0, 1, 0, 0, 1,
                                        0, 1, 0, 0, 1,
                                        1, 1, 0, 0, 0,
                                        0, 0, 1, 0, 1,
                                        0, 1, 0, 1, 1],
                             goalFlips: 8)
        let level_48 = Level(sequence: [0, 0, 0, 0, 1,
                                        1, 1, 1, 1, 1,
                                        0, 0, 0, 0, 1,
                                        0, 0, 0, 0, 0,
                                        1, 1, 1, 1, 0],
                             goalFlips: 11)
        let level_49 = Level(sequence: [1, 1, 0, 0, 0,
                                        1, 0, 0, 0, 0,
                                        0, 1, 1, 0, 0,
                                        0, 0, 0, 1, 1,
                                        1, 1, 1, 1, 0],
                             goalFlips: 24)
        let level_50 = Level(sequence: [0, 0, 0, 1, 0,
                                        0, 0, 1, 0, 1,
                                        1, 1, 0, 0, 1,
                                        0, 1, 0, 1, 0,
                                        1, 0, 1, 0, 1],
                             goalFlips: 10)
        let level_51 = Level(sequence: [1, 1, 1, 0, 0,
                                        0, 1, 0, 1, 1,
                                        0, 0, 0, 0, 0,
                                        0, 1, 1, 1, 1,
                                        0, 0, 0, 1, 1],
                             goalFlips: 9)
        let level_52 = Level(sequence: [1, 0, 1, 0, 1,
                                        0, 1, 0, 0, 0,
                                        0, 0, 0, 0, 1,
                                        1, 1, 1, 0, 0,
                                        0, 1, 1, 1, 1],
                             goalFlips: 9)
        let level_53 = Level(sequence: [1, 0, 0, 0, 1,
                                        0, 0, 0, 0, 1,
                                        1, 1, 1, 0, 1,
                                        0, 0, 1, 0, 0,
                                        1, 1, 0, 0, 1],
                             goalFlips: 17)
        let level_54 = Level(sequence: [0, 0, 1, 0, 0,
                                        0, 1, 1, 0, 0,
                                        1, 1, 1, 0, 0,
                                        0, 1, 0, 1, 1,
                                        1, 0, 1, 0, 1],
                             goalFlips: 15)
        let level_55 = Level(sequence: [0, 1, 1, 0, 0,
                                        1, 1, 0, 0, 1,
                                        0, 1, 0, 1, 0,
                                        0, 0, 0, 0, 0,
                                        0, 1, 1, 1, 0],
                             goalFlips: 12)
        let level_56 = Level(sequence: [1, 1, 0, 1, 1,
                                        0, 0, 0, 1, 0,
                                        0, 0, 0, 1, 1,
                                        0, 0, 1, 1, 1,
                                        1, 0, 0, 1, 1],
                             goalFlips: 7)
        let level_57 = Level(sequence: [0, 1, 0, 1, 1,
                                        1, 0, 0, 1, 0,
                                        1, 1, 1, 0, 1,
                                        0, 0, 1, 1, 0,
                                        1, 1, 0, 0, 0],
                             goalFlips: 31)
        let level_58 = Level(sequence: [0, 1, 0, 0, 1,
                                        0, 1, 1, 0, 1,
                                        1, 0, 1, 1, 1,
                                        0, 0, 1, 0, 1,
                                        0, 1, 0, 0, 0],
                             goalFlips: 20)
        let level_59 = Level(sequence: [0, 0, 1, 0, 0,
                                        1, 1, 0, 1, 1,
                                        1, 1, 0, 1, 1,
                                        0, 0, 1, 0, 0,
                                        1, 0, 0, 1, 0],
                             goalFlips: 16)
        let level_60 = Level(sequence: [1, 1, 0, 0, 0,
                                        0, 1, 1, 1, 1,
                                        0, 1, 0, 0, 1,
                                        0, 1, 0, 0, 0,
                                        1, 1, 1, 0, 0],
                             goalFlips: 6)
        
        // STAGE 4
        let level_61 = Level(sequence: [1, 1, 0, 1, 0,
                                        1, 1, 0, 0, 0,
                                        0, 0, 1, 1, 0,
                                        0, 0, 1, 1, 0,
                                        1, 1, 1, 0, 0],
                            goalFlips: 6)
        let level_62 = Level(sequence: [0, 0, 0, 0, 0,
                                        0, 0, 0, 1, 1,
                                        1, 0, 1, 1, 0,
                                        0, 1, 1, 1, 1,
                                        0, 1, 1, 1, 1],
                            goalFlips: 10)
        let level_63 = Level(sequence: [1, 0, 0, 1, 1,
                                        1, 0, 0, 1, 1,
                                        1, 1, 1, 1, 0,
                                        0, 1, 0, 0, 1,
                                        1, 0, 0, 1, 0],
                            goalFlips: 10)
        let level_64 = Level(sequence: [0, 0, 0, 0, 1,
                                        0, 0, 1, 0, 1,
                                        0, 1, 1, 1, 0,
                                        1, 0, 0, 1, 1,
                                        0, 0, 1, 1, 0],
                            goalFlips: 12)
        let level_65 = Level(sequence: [0, 0, 1, 1, 1,
                                        1, 1, 1, 0, 0,
                                        1, 0, 0, 0, 0,
                                        1, 1, 1, 1, 1,
                                        1, 0, 1, 0, 1],
                            goalFlips: 10)
        let level_66 = Level(sequence: [1, 1, 0, 0, 1,
                                        1, 0, 0, 1, 0,
                                        0, 1, 0, 1, 0,
                                        1, 1, 0, 1, 0,
                                        0, 0, 0, 0, 0],
                            goalFlips: 12)
        let level_67 = Level(sequence: [0, 1, 0, 1, 1,
                                        1, 0, 1, 0, 0,
                                        1, 1, 0, 0, 1,
                                        0, 0, 0, 1, 0,
                                        1, 1, 1, 0, 1],
                            goalFlips: 9)
        let level_68 = Level(sequence: [1, 1, 1, 0, 0,
                                        1, 0, 0, 1, 1,
                                        1, 0, 0, 1, 0,
                                        1, 0, 1, 1, 0,
                                        1, 0, 0, 0, 0],
                            goalFlips: 11)
        let level_69 = Level(sequence: [0, 1, 1, 1, 0,
                                        0, 1, 0, 0, 0,
                                        0, 0, 0, 0, 1,
                                        1, 0, 0, 1, 1,
                                        1, 0, 1, 0, 1],
                            goalFlips: 9)
        let level_70 = Level(sequence: [0, 0, 1, 1, 0,
                                        0, 1, 0, 0, 0,
                                        1, 1, 1, 0, 0,
                                        1, 0, 0, 1, 0,
                                        0, 0, 1, 0, 0],
                             goalFlips: 11)
        let level_71 = Level(sequence: [0, 1, 0, 1, 0,
                                        0, 0, 0, 0, 0,
                                        0, 0, 1, 1, 0,
                                        1, 1, 0, 0, 1,
                                        0, 0, 1, 1, 0],
                             goalFlips: 7)
        let level_72 = Level(sequence: [0, 1, 1, 0, 1,
                                        1, 0, 0, 0, 1,
                                        1, 0, 0, 1, 0,
                                        0, 0, 1, 0, 1,
                                        1, 0, 1, 1, 1],
                             goalFlips: 11)
        let level_73 = Level(sequence: [1, 0, 1, 1, 0,
                                        1, 0, 1, 1, 0,
                                        1, 0, 0, 0, 1,
                                        0, 1, 1, 0, 0,
                                        1, 0, 1, 0, 0],
                             goalFlips: 10)
        let level_74 = Level(sequence: [0, 1, 0, 1, 1,
                                        1, 1, 0, 0, 1,
                                        0, 1, 1, 0, 0,
                                        1, 0, 1, 0, 0,
                                        1, 0, 0, 1, 1],
                             goalFlips: 11)
        let level_75 = Level(sequence: [1, 1, 1, 1, 1,
                                        0, 1, 1, 1, 0,
                                        0, 1, 0, 0, 0,
                                        0, 0, 1, 0, 1,
                                        0, 0, 1, 0, 1],
                             goalFlips: 10)
        let level_76 = Level(sequence: [1, 1, 0, 1, 1,
                                        0, 1, 1, 1, 1,
                                        0, 0, 0, 0, 1,
                                        1, 1, 0, 1, 0,
                                        0, 0, 1, 0, 0],
                             goalFlips: 12)
        let level_77 = Level(sequence: [1, 1, 0, 1, 1,
                                        0, 1, 0, 0, 1,
                                        1, 1, 0, 0, 1,
                                        0, 0, 0, 0, 0,
                                        1, 0, 1, 1, 0],
                             goalFlips: 11)
        let level_78 = Level(sequence: [0, 0, 1, 1, 1,
                                        1, 0, 0, 0, 0,
                                        1, 1, 0, 1, 1,
                                        0, 0, 0, 1, 0,
                                        1, 1, 0, 0, 0],
                             goalFlips: 13)
        let level_79 = Level(sequence: [1, 1, 1, 0, 0,
                                        1, 0, 0, 1, 0,
                                        1, 0, 1, 1, 1,
                                        1, 1, 0, 0, 1,
                                        1, 1, 1, 1, 0],
                             goalFlips: 12)
        let level_80 = Level(sequence: [1, 1, 1, 0, 0,
                                        0, 1, 1, 1, 0,
                                        0, 0, 1, 0, 0,
                                        1, 1, 1, 1, 0,
                                        1, 1, 0, 1, 0],
                             goalFlips: 14)
        
        // STAGE 5
        let level_81 = Level(sequence: [0, 0, 1, 0, 1,
                                        1, 0, 0, 0, 0,
                                        1, 0, 1, 0, 0,
                                        1, 1, 0, 0, 0,
                                        1, 0, 1, 1, 0],
                            goalFlips: 8)
        let level_82 = Level(sequence: [0, 1, 1, 1, 0,
                                        1, 1, 0, 0, 0,
                                        1, 1, 1, 0, 0,
                                        1, 0, 0, 1, 0,
                                        0, 1, 1, 1, 0],
                            goalFlips: 10)
        let level_83 = Level(sequence: [0, 0, 1, 1, 0,
                                        1, 1, 1, 0, 0,
                                        1, 0, 0, 0, 0,
                                        1, 0, 0, 0, 1,
                                        1, 0, 1, 1, 1],
                            goalFlips: 6)
        let level_84 = Level(sequence: [0, 0, 1, 0, 0,
                                        0, 1, 0, 1, 1,
                                        0, 1, 0, 0, 0,
                                        1, 1, 0, 0, 1,
                                        0, 1, 1, 0, 1],
                            goalFlips: 16)
        let level_85 = Level(sequence: [1, 0, 0, 1, 1,
                                        0, 0, 0, 1, 1,
                                        0, 1, 0, 1, 1,
                                        0, 1, 0, 0, 1,
                                        1, 0, 1, 1, 1],
                            goalFlips: 11)
        let level_86 = Level(sequence: [1, 0, 0, 0, 0,
                                        1, 1, 0, 1, 1,
                                        1, 0, 1, 0, 0,
                                        1, 0, 0, 0, 0,
                                        1, 1, 1, 0, 0],
                            goalFlips: 10)
        let level_87 = Level(sequence: [1, 1, 0, 1, 0,
                                        0, 0, 1, 0, 1,
                                        1, 0, 0, 1, 0,
                                        1, 1, 0, 0, 0,
                                        0, 1, 1, 0, 1],
                            goalFlips: 17)
        let level_88 = Level(sequence: [1, 1, 0, 0, 0,
                                        1, 1, 1, 1, 0,
                                        0, 1, 1, 0, 1,
                                        0, 1, 1, 1, 1,
                                        1, 0, 0, 0, 1],
                            goalFlips: 21)
        let level_89 = Level(sequence: [1, 1, 1, 1, 0,
                                        0, 1, 1, 0, 0,
                                        0, 0, 0, 1, 1,
                                        0, 0, 1, 1, 0,
                                        1, 1, 0, 1, 0],
                            goalFlips: 7)
        let level_90 = Level(sequence: [1, 0, 0, 0, 0,
                                        1, 1, 1, 0, 1,
                                        0, 0, 1, 1, 0,
                                        1, 1, 1, 0, 0,
                                        1, 0, 1, 1, 0],
                             goalFlips: 21)
        let level_91 = Level(sequence: [1, 1, 1, 0, 0,
                                        0, 0, 0, 1, 1,
                                        1, 0, 0, 1, 0,
                                        0, 0, 1, 1, 0,
                                        0, 1, 1, 0, 0],
                             goalFlips: 18)
        let level_92 = Level(sequence: [1, 1, 0, 0, 1,
                                        0, 1, 0, 1, 0,
                                        0, 1, 1, 0, 0,
                                        0, 1, 1, 0, 0,
                                        1, 1, 1, 0, 0],
                             goalFlips: 11)
        let level_93 = Level(sequence: [1, 0, 0, 1, 0,
                                        0, 0, 0, 1, 1,
                                        0, 0, 0, 1, 1,
                                        1, 1, 1, 1, 0,
                                        1, 0, 0, 1, 1],
                             goalFlips: 10)
        let level_94 = Level(sequence: [0, 0, 1, 1, 1,
                                        0, 0, 0, 0, 0,
                                        0, 0, 0, 0, 1,
                                        1, 1, 1, 0, 0,
                                        1, 0, 0, 1, 0],
                             goalFlips: 15)
        let level_95 = Level(sequence: [0, 0, 0, 0, 0,
                                        0, 1, 0, 0, 0,
                                        0, 1, 0, 0, 1,
                                        0, 0, 1, 1, 1,
                                        1, 1, 1, 1, 0],
                             goalFlips: 5)
        let level_96 = Level(sequence: [0, 0, 1, 1, 1,
                                        1, 1, 1, 1, 1,
                                        1, 1, 0, 1, 1,
                                        1, 1, 1, 1, 0,
                                        1, 0, 0, 0, 0],
                             goalFlips: 11)
        let level_97 = Level(sequence: [0, 1, 0, 0, 1,
                                        0, 0, 0, 0, 0,
                                        1, 0, 0, 1, 1,
                                        1, 1, 1, 0, 1,
                                        0, 0, 0, 0, 1],
                             goalFlips: 8)
        let level_98 = Level(sequence: [0, 1, 0, 0, 0,
                                        1, 1, 1, 1, 0,
                                        0, 1, 0, 1, 1,
                                        0, 1, 0, 1, 0,
                                        0, 1, 0, 0, 1],
                             goalFlips: 8)
        let level_99 = Level(sequence: [0, 0, 0, 1, 1,
                                        1, 0, 0, 1, 1,
                                        1, 1, 0, 1, 0,
                                        1, 0, 0, 0, 1,
                                        1, 0, 0, 1, 1],
                             goalFlips: 29)
        let level_100 = Level(sequence: [0, 1, 0, 1, 0,
                                         1, 0, 1, 1, 1,
                                         0, 0, 0, 0, 0,
                                         1, 1, 0, 0, 1,
                                         0, 0, 0, 0, 0],
                             goalFlips: 17)
        
        
        levels_1 = [level_1, level_2, level_3, level_4, level_5, level_6, level_7, level_8, level_9, level_10, level_11, level_12, level_13, level_14, level_15, level_16, level_17, level_18, level_19, level_20]
        
        levels_2 = [level_21, level_22, level_23, level_24, level_25, level_26, level_27, level_28, level_29, level_30, level_31, level_32, level_33, level_34, level_35, level_36, level_37, level_38, level_39, level_40]
        
        levels_3 = [level_41, level_42, level_43, level_44, level_45, level_46, level_47, level_48, level_49, level_50, level_51, level_52, level_53, level_54, level_55, level_56, level_57, level_58, level_59, level_60]
        
        levels_4 = [level_61, level_62, level_63, level_64, level_65, level_66, level_67, level_68, level_69, level_70, level_71, level_72, level_73, level_74, level_75, level_76, level_77, level_78, level_79, level_80]
        
        levels_5 = [level_81, level_82, level_83, level_84, level_85, level_86, level_87, level_88, level_89, level_90, level_91, level_92, level_93, level_94, level_95, level_96, level_97, level_98, level_99, level_100]
        
        stages = [levels_1, levels_2, levels_3, levels_4, levels_5]
        
        // TODO: Interface with core data for this data, and a JSON file etc
        // TODO: Put these levels into a data structure outside of the FH object
    }
}

// ********************************** EXTENSIONS ********************************** //

extension FlippingHell: UpdateModelDelegate { // Implements update of model from main view
    func gameWon(LevelID: Int, Flips: Int, ButtonsClicked: [Int]) {
        
        // TODO: process game won via level method, not via accessing elements directly
        let LevelSelected = stages[currentStage][currentLevel]
        
        LevelSelected.completeLevel(Flips: Flips, completeSequence: ButtonsClicked)
        
        
        
        // TODO: check completion of all levels in a stage to unlock and generate a new one
        // TODO: check completed list of levels before generating one
        
        
        // TODO: Count level stars in stages to see if the next stage should be unlocked
        var StageWinTest = true
        for levelIndex in stages[currentStage] {
            if (levelIndex.isComplete == false) {
                StageWinTest = false
                break
            }
        }
        
        if(StageWinTest == true) {
            stageUnlocks[currentStage + 1] = true
        }
    }
    
    func gameReset() {
        stages[currentStage][currentLevel].attempts += 1
    }
    
    func requestLevel() {
        let LevelSelected = stages[currentStage][currentLevel]
        UpdateMainViewDelegateInstance.receiveLevel(LevelID: currentLevel, GoalFlips: LevelSelected.goalFlips, Sequence: LevelSelected.sequence)
    }
}

extension FlippingHell: UpdateModelWinDelegate { // Implements update of model from Win view
    func nextLevel() {
        if (currentLevel < 19) {
            currentLevel += 1
        } else {
            if (currentStage < 4 ) { // TODO: remove this logic restriction, game won should generate new stage
                currentStage += 1
                currentLevel = 0
            }
        }
    }
}

extension FlippingHell: UpdateModelLevelsDelegate { // Receives request from Level screen for levels
    func requestLevelList(StageID: Int) {
        UpdateLevelViewDelegateInstance.receiveLevelList(StageID: StageID, LevelList: stages[StageID], CurrentStage: currentStage, CurrentLevel: currentLevel)
    }
    
    func changeLevel(StageID: Int, LevelID: Int) {
        currentStage = StageID
        currentLevel = LevelID
        stages[currentStage][currentLevel].attempts += 1
    }
}

extension FlippingHell: UpdateModelStagesDelegate {
    func requestStages() -> [Int] {
        var stageOutput: [Int] = []
        var stageCount = 0
        for stageIndex in stages {
            var starMin = 4
            for levelIndex in stageIndex {
                if (levelIndex.starScore < starMin) {
                    starMin = levelIndex.starScore
                }
            }
            if (stageUnlocks[stageCount] == true) {
                stageOutput.append(starMin)
            }
            stageCount += 1
        }
        return stageOutput
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
