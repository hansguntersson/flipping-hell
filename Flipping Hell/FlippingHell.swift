//
//  FlippingHell.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import Foundation

class Level {
    var isUnlocked = false
    var isComplete = false
    var attempts = 0
    var minFlips: Int? = nil
    var minMoves: Array<Int> = [0]
    let sequence: Array<Int>
    
    init(sequence: Array<Int>) {
        self.sequence = sequence
    }
    
    func completeLevel(levelCompleted: Level, completeSequence: Array<Int>) { // Include moves, sequence of moves
        isComplete = true
        let moveCount = completeSequence.count
        
        if let flipExists = minFlips {
            if(moveCount < flipExists) {
                minFlips = moveCount
                minMoves = completeSequence
            }
        } else {
            minFlips = moveCount
            minMoves = completeSequence
        }
        attempts += 1
        // Unlock next level when not yet unlocked
    }
    
}


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
