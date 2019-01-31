//
//  Level.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 14/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import Foundation

class Level {
    
    // Core data
    var sequenceID: Int = 0 // The unique sequence ID
    var sequence: Array<Int> // The array sequence for the level
    var goalFlips: Int // The goal flips for the level
    var currentFlips: Int = 0 // The current flip count
    let levelIndex: Int // Which index the level is at

    static var levelsIndices = -1 // The class index for the levels
    
    // Move to game
    var attempts = 0 // Hpw many attempts were made
    var minFlips: Int = 0 // The minimum number of flips the level has been completed in
    var minMoves: Array<Int> = [0] // The minimum moves the level has been completed in
    var isComplete = false // Whether the level has been completed
    var isUnlocked = false // Whether the level is unlocked

    
    // Passed to Win
    var LevelScore = 0
    var levelstars = "☆ ☆ ☆" // The star sequence for the level


 

    
    
    
    init(sequence: Array<Int>, goalFlips: Int) {
        self.sequence = sequence
        self.sequence = sequence
        self.goalFlips = goalFlips
        levelIndex = Level.getLevelNumber()
    }
    
    static func getLevelNumber() -> Int {
        levelsIndices += 1
        return levelsIndices
    }
    
    func completeLevel(levelCompleted: Level, completeSequence: Array<Int>) { // Include moves, sequence of moves
        isComplete = true
        let moveCount = completeSequence.count
        if(moveCount < minFlips) {
            minFlips = moveCount
            minMoves = completeSequence
            if (moveCount - goalFlips >= 2) {
                levelstars = "★"
            } else if (moveCount - goalFlips > 0) {
                levelstars = "★ ★"
            } else if (moveCount - goalFlips == 0) {
                levelstars = "★ ★ ★"
            } else if (moveCount - goalFlips < 0) {
                levelstars = "✮ ✮ ✮"
            }
        }
        attempts += 1
        // Unlock next level when not yet unlocked
    }
    
}
