//
//  FlippingHell.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// ********************************** PROTOCOLS ********************************** //

protocol UpdateMainViewDelegate {
    func receiveLevel(LevelID: Int, GoalFlips: Int16, Sequence: [Int])
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
    
    var stages = [[Level]]()
    
    var currentLevel = 0
    
    // TODO: Ensure these arrays are appropriately generated
    var stageUnlocks: [Bool] = []
    var stageStars: [Int] = [0] // number of stars obtained for each level
    /* 4 stars is blue, 3 stars is gold, 2 stars is silver, 1 star is bronze, 0 stars is none */
    
    
    var currentStage = 0
    
    init() {
        loadLevels()
        deleteData()
        
        // ********************************** JSON DATA ********************************** //
        
        /*
        // var JSONversion = 1
        let JSONlink = "https://www.hansguntersson.com/flipping-hell/FH_data.json"
        print(JSONlink)
        
        guard let url = URL(string: JSONlink) else {
            print("HTTP error")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            // What to do with url data
            print("URL session")
            
            guard let data = data else { return }
            
            let dataAsString = String(data: data, encoding: .utf8)
            
            print(dataAsString)
            
        }.resume()
        */
   
    }
    
    // ********************************** DELEGATES ********************************** //
    
    var UpdateMainViewDelegateInstance: UpdateMainViewDelegate!
    var UpdateLevelViewDelegateInstance: UpdateLevelViewDelegate!
    
    
    // ********************************** CORE DATA ********************************** //
    
    func saveData(levelid: Int32, flips: Int16) { // SAVE DATA TO CORE DATA
        
        var levelsTest: [NSManagedObject] = []
        
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // Get managed object context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create entity named Test
        let entity = NSEntityDescription.entity(forEntityName: "Levels", in: managedContext)!
        
        // Create entry in Test table
        let entry = NSManagedObject(entity: entity, insertInto: managedContext)
        
        // Set values for the fields in the table
        entry.setValue(levelid, forKeyPath: "levelid")
        entry.setValue(flips, forKeyPath: "flips")
        
        // save the context
        do {
            try managedContext.save()
            levelsTest.append(entry)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func loadData() -> [Levels] { // LOAD DATA FROM CORE DATA
        
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        // Get managed object context
        let context = appDelegate.persistentContainer.viewContext
        
        // 1
        let request: NSFetchRequest<Levels> = Levels.fetchRequest()
        
        // 2
        //        request.predicate = NSPredicate(format: "title = %@", "MEDIUM")
        do {
            // 3
            let TestItems = try context.fetch(request)
            
            // 4
            TestItems.forEach { item in
                // let levelid = item.levelid
                // print(levelid)
                // let flips = item.flips
                // print(flips)
            }
 
            return TestItems
        }  catch {
            fatalError("This was not supposed to happen")
        }
    }
    
    
    
    func deleteData() { // DELETE DATA FROM CORE DATA
        
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // Get managed object context
        let context = appDelegate.persistentContainer.viewContext
        
        // Load data into memory
        let items = loadData()
        
        // Delete the items
        items.forEach { item in
            context.delete(item)
        }
    }
    
    
    // ********************************** FUNCTIONS ********************************** //
    
    func calculateStars() {
        // Loop through stages
        // loop through each level, and look at star score for minimum
        
    }
    
    func loadLevels() { // Load levels into game
        
        struct LevelJSON: Codable {
            let levelid: Int
            let flips: Int
        }
        
        struct LevelArrayJSON: Codable {
            let levelfeed: [LevelJSON]
        }
        
        // Get url of file
        guard let url = Bundle.main.url(forResource: "FH_data", withExtension: "json") else{
            print("url try didn't work")
            return
        }
        
        // turn contents JSON file at url into data
        guard let data = try? Data(contentsOf: url) else {
            print("data try didn't work")
            return
        }
        
        let jsonoutput = try! JSONDecoder().decode(LevelArrayJSON.self, from: data)
        
        let jsonarray = jsonoutput.levelfeed
        
        
        // Cycle through and create objects
        
        var jsonarrayindex = 20 // index of levels to ensure each stage is only 20 items  long
        var jsonstageindex = -1 // index of stages to cycle through stages
        for jsonlevel in jsonarray {
            
            if (jsonarrayindex == 20) {
                jsonarrayindex = 0
                jsonstageindex += 1
                
                let levelArray = [Level]()
                stages.append(levelArray)
                
                stageUnlocks.append(true) // TODO: Turn this off for full game
                stageStars.append(0)
            }
            
            let levelinstance = Level(sequenceID: Int32(jsonlevel.levelid), goalFlips: Int16(jsonlevel.flips))

            stages[jsonstageindex].append(levelinstance)
            
            jsonarrayindex += 1
            
            stageUnlocks[0] = true // ensures that the first level is available
        }
    }
}

// ********************************** EXTENSIONS ********************************** //

extension FlippingHell: UpdateModelDelegate { // Implements update of model from main view
    func gameWon(LevelID: Int, Flips: Int16, ButtonsClicked: [Int]) {
        
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
        
        saveData(levelid: LevelSelected.sequenceID, flips: Flips)
        
        let ItemList = loadData()
        // print(ItemList)
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
 
 
 // -------------------------------------- OTHER LEVELS -------------------------------------- //
 
 var WinState_0_7 = [0, 1, 1, 1, 0,
                     0, 0, 0, 0, 0,
                     0, 0, 0, 0, 0,
                     0, 0, 1, 0, 0,
                     0, 0, 1, 0, 0]; // 2
 
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
