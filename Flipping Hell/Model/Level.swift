//
//  Level.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 14/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import Foundation

class Level {
    /*
     Data taken in:
     - sequence ID
     - goal flips
     - who won the level first
 
     Data stored per user:
     - sequence ID
     - completed (inferred)
     - attempts
     - minFlips
     - minMoves
     
     Data held centrally:
     - sequence ID
     - minFlips
     - minMoves
     - username
     - date
     - attempts
    */

    var sequenceID: Int32 = 0 // The unique sequence ID
    var goalFlips: Int16 // The goal flips for the level
    let levelIndex: Int // Which index the level is at
    var attempts = 0 // Hpw many attempts were made
    var minFlips: Int16 = 0 // The minimum number of flips the level has been completed in
    var minMoves: Array<Int> = [0] // The minimum moves the level has been completed in
    var starScore: Int = 0 // Score of stars for the particular level
    // 4 stars is blue, 3 stars is gold, 2 stars is silver, 1 star is bronze, 0 stars is none
    var isComplete = false // Whether the level has been completed

    static var levelsIndices = 0 // The class index for the levels
    
    init(sequence: Array<Int>, goalFlips: Int16) { // Initialiser when array is available
        self.goalFlips = goalFlips
        levelIndex = Level.getLevelNumber()
        self.sequenceID = arrayToNumber(ArrayInput: sequence)
    }
    
    init(sequenceID: Int32, goalFlips: Int16) { // Initialiser when number is available
        self.sequenceID = sequenceID
        self.goalFlips = goalFlips
        levelIndex = Level.getLevelNumber()
        // self.sequence = numberToArray(NumberInput: sequenceID)
    }
    
    static func getLevelNumber() -> Int { // Get level for display on table etc
        // TODO: - Remove as the array will dictate index
        levelsIndices += 1
        return levelsIndices
    }
    
    func completeLevel(Flips: Int16, completeSequence: Array<Int>) { // Actions when level is completed
        isComplete = true
        
        if (Flips < minFlips || minFlips == 0) {
            minFlips = Flips
            minMoves = completeSequence
            
            if (minFlips - goalFlips > 2) {
                starScore = 1
            } else if (minFlips - goalFlips > 0) {
                starScore = 2
            } else if (minFlips - goalFlips <= 0) {
                starScore = 3
            }
        }
    }
    
    func arrayToNumber(ArrayInput: [Int]) -> Int32 { // Take in an array and converts it to a number
        var TextString: String = ""
        for Digit in ArrayInput {
            TextString += String(Digit)
        }
        return Int32(TextString, radix: 2) ?? 0
    }
    
    
    func numberToArray(NumberInput: Int32) -> [Int] { // Take a number and converts it to an array
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

// TODO: Rationalise this data - it calculates whether the level is valid or not
/*
let tempSum = IntOutput[0] + IntOutput[1] + IntOutput[3] + IntOutput[4] + IntOutput[5] + IntOutput[6] + IntOutput[8] + IntOutput[9] + IntOutput[15] + IntOutput[16] + IntOutput[18] + IntOutput[19] + IntOutput[20] + IntOutput[21] + IntOutput[23] + IntOutput[24]


if tempSum % 2 == 0 {
    print("even")
} else {
    print("odd")
}
*/
