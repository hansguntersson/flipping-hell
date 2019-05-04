//
//  Level.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 14/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import Foundation

class Level {

    var sequenceID: Int = 0 // The unique sequence ID
    var sequence: Array<Int> // The array sequence for the level
    var GoalFlips: Int // The goal flips for the level
    var currentFlips: Int = 0 // The current flip count
    let levelIndex: Int // Which index the level is at
    var attempts = 0 // Hpw many attempts were made
    var minFlips: Int = 0 // The minimum number of flips the level has been completed in
    var minMoves: Array<Int> = [0] // The minimum moves the level has been completed in
    var isComplete = false // Whether the level has been completed

    static var levelsIndices = 0 // The class index for the levels    
    
    init(sequence: Array<Int>, goalFlips: Int) { // Initialiser
        self.sequence = sequence
        self.GoalFlips = goalFlips
        levelIndex = Level.getLevelNumber()
        self.sequenceID = arrayToNumber(ArrayInput: sequence)
    }
    
    static func getLevelNumber() -> Int { // Get level for display on table etc
        // TODO: - Remove as the array will dictate index
        levelsIndices += 1
        return levelsIndices
    }
    
    func completeLevel(levelCompleted: Level, completeSequence: Array<Int>) { // What happens when level is completed
        isComplete = true
        attempts += 1
        // TODO: - Unlock next level when not yet unlocked
        // TODO: -  Include moves, sequence of moves
    }
    
    func arrayToNumber(ArrayInput: [Int]) -> Int { // Take in an array and converts it to a number
        var TextString: String = ""
        for Digit in ArrayInput {
        TextString += String(Digit)
        }
        return Int(TextString, radix: 2) ?? 0
    }
    
    
    func numberToArray(NumberInput: Int) -> [Int] { // Take a number and converts it to an array
        var IntOutput: [Int] = []
        let BinaryOutput = String(NumberInput, radix: 2)
        let BinaryArray = Array(BinaryOutput)
        
        let AdditionalElements = 25 - BinaryArray.count
        
        for _ in 0..<AdditionalElements {
        IntOutput.append(0)
        }
        
        for index in 0..<BinaryArray.count {
        IntOutput.append(Int(String(BinaryArray[index]))!)
        }
        
        return IntOutput
    }
    
}
