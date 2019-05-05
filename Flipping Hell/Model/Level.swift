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
    var goalFlips: Int // The goal flips for the level
    var currentFlips: Int = 0 // The current flip count
    let levelIndex: Int // Which index the level is at
    var attempts = 0 // Hpw many attempts were made
    var minFlips: Int = 0 // The minimum number of flips the level has been completed in
    var minMoves: Array<Int> = [0] // The minimum moves the level has been completed in
    var starScore: Int = 0 // Score of stars for the particular level
    var isComplete = false // Whether the level has been completed

    static var levelsIndices = 0 // The class index for the levels    
    
    init(sequence: Array<Int>, goalFlips: Int) { // Initialiser
        self.sequence = sequence
        self.goalFlips = goalFlips
        levelIndex = Level.getLevelNumber()
        self.sequenceID = arrayToNumber(ArrayInput: sequence)
    }
    
    static func getLevelNumber() -> Int { // Get level for display on table etc
        // TODO: - Remove as the array will dictate index
        levelsIndices += 1
        return levelsIndices
    }
    
    func completeLevel(Flips: Int, completeSequence: Array<Int>) { // Actions when level is completed
        isComplete = true
        attempts += 1
        
        
        // What to do when theres a new record, also flag up with mains screen?
        if (Flips < minFlips || minFlips == 0) {
            minFlips = Flips
            minMoves = completeSequence
            
            if (minFlips - goalFlips > 2) {
                starScore = 1
            } else if (minFlips - goalFlips > 0) {
                starScore = 2
            } else if (minFlips - goalFlips == 0) {
                starScore = 3
            } else if (minFlips - goalFlips < 0) {
                starScore = 4
            }
            
            // TODO: Still want to log attempts and sequences even if they're not a new record?
        }
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
