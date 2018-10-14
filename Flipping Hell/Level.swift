//
//  Level.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 14/10/2018.
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
    
    let stars = "★★★"
    let index = 0
    
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
