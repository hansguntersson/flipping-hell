//
//  FlippingHell.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//



/*
 - Load base data from JSON
 - Update any records based on array of saved scores
 - When a new record is created, save / overwrite the score in memory
 */

import Foundation
import UIKit
import CoreData

// ********************************** PROTOCOLS ********************************** //

protocol UpdateMainViewDelegate: class {
    func receiveLevel(LevelID: Int, StageID: Int, StageMax: Int, newStage: Bool, GoalFlips: Int16, Sequence: [Int], IsCompleted: Bool, FirstOpen: Bool)
}

protocol UpdateLevelViewDelegate: class {
    func receiveLevelList(LevelList: [Level], CurrentStage: Int, CurrentLevel: Int, LevelsPerStage: Int)
}

protocol UpdateStageViewDelegate: class {
    func receiveStageList(StagesVisible: Int, StagesUnlocked: Int, StagesStars: [Int])
}

protocol UpdateWinViewDelegate: class {
    func receiveWin(GoalFlips: Int16, LevelID: Int, StageID: Int, StageMax: Int, NewStage: Bool)
}

protocol UpdateScoreViewDelegate: class {
    func receiveScores(GoldStars: Int, SilverStars: Int, BronzeStars: Int, TotalStars: Int, RemainingStars: Int)
}

// ********************************** CLASS DEFINITION ********************************** //

class FlippingHell {

    // ********************************** VARIABLES ********************************** //
    
    var stages = [[Level]]()
    
    var currentLevel = 0
    var currentStage = 0
    
    var levelsPerStage = 20 // Ensure that the total levels are a multiplier of this number
    var firstOpen = true // whether or not the user is new
    
    var stagesUnlockedInitial: Int = 1 // number of stages unlocked initially
    var stagesUnlocked: Int = 1 // number of stages unlocked
    var stagesVisible: Int = 2 // number of stages visible
    var newStageUnlocked: Bool = false // Whether a new stage is unlocked
    
    var goldCount: Int = 0
    var silverCount: Int = 0
    var bronzeCount: Int = 0
    var stageStars: [Int] = [0] // number of stars obtained for each stage
    var totalStars: Int = 0 // total tally of stars which drives stage unlocks
    // 4 stars is blue, 3 stars is gold, 2 stars is silver, 1 star is bronze, 0 stars is none
    var remainingStars: Int = 6 // Stars remaining to the next level
    let unlockStarRatio = 6 // Number of stars per stage to unlock the next stage
    /* Core numbers for review
     20 levels per stage
     60 all gold
     40 all silver
     20 all bronze
    */
    
    struct LevelJSON: Codable {
        let levelid: Int
        let flips: Int
    }
    
    struct LevelArrayJSON: Codable {
        let levelfeed: [LevelJSON]
    }
    
    init() {
        
        stagesUnlocked = stagesUnlockedInitial
        loadLevels()
    }
    
    // ********************************** DELEGATES ********************************** //
    
    weak var UpdateMainViewDelegateInstance: UpdateMainViewDelegate!
    weak var UpdateLevelViewDelegateInstance: UpdateLevelViewDelegate!
    weak var UpdateStageViewDelegateInstance: UpdateStageViewDelegate!
    weak var UpdateScoreViewDelegateInstance: UpdateScoreViewDelegate!
    weak var UpdateWinViewDelegateInstance: UpdateWinViewDelegate!
    
    
    // ********************************** CORE DATA ********************************** //
    
    func saveData(levelid: Int32, flips: Int16, minmoves: [Int]) { // SAVE DATA TO CORE DATA
        
        var levelsTest: [NSManagedObject] = []
        
        // Get app delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Could not get save delegate")
            return
        }
        
        // Get managed object context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Create entity named Levels
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
            print("Delegate failed")
            return []
        }
        
        // Get managed object context
        let context = appDelegate.persistentContainer.viewContext
        
        // TODO: Temporary data delete
        // context.deleteAllData()
        
        // TODO: What happens if the data isn't there?
        let request: NSFetchRequest<Levels> = Levels.fetchRequest()
        
        // TODO: Work out what this is
        //  request.predicate = NSPredicate(format: "title = %@", "MEDIUM")
        
        // Return contents
        do {
            let SavedItems = try context.fetch(request)
            return SavedItems
        }  catch {
            fatalError("This was not supposed to happen")
        }
    }
    
    
    func sendResults() { // Send results from weblink
        let userid = 15
        let stageid = 1
        let sequenceid = 1111
        let bestid  = 10
        
        let useridstring = "?a=\(userid)"
        let stageidstring = "?b=\(stageid)"
        let sequenceidstring = "?c=\(sequenceid)"
        let bestidstring  = "?d=\(bestid)"
        
        let urlString = "https://www.hansguntersson.com/flipping-hell/service.php"
        
        print(urlString)
        
        //created URL
        guard let requestURL = URL(string: urlString) else {
            print("URL didn't work")
            return
        }
        
        //creating URLRequest
        var request = URLRequest(url: requestURL)
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let phpParameters: String = useridstring + stageidstring + sequenceidstring + bestidstring
        
        //adding the parameters to request body
        request.httpBody = phpParameters.data(using: .utf8)
        
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {        // check for fundamental networking error
                    print("network error")
                    // print("error", error ?? "Unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {
                print("response error")
                
                // check for http errors
                //print("statusCode should be 2xx, but is \(response.statusCode)")
                //print("response = \(response)")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print("responseString = \(responseString ?? "No response string")")
        }
        
        task.resume()
        
    }
    
    func getFromURL() { // TRY TO GET DATA FROM WEB LINK
        
        let urlString = "https://hansguntersson.com/flipping-hell/FH_data.json"
        // let urlString = "https://learnappmaking.com/ex/users.json"
        
        print(urlString)
        
        guard let url = URL(string: urlString) else {
            print("url failure")
            return
        }
        
        print(url)
    }
    
    // ********************************** FUNCTIONS ********************************** //
    
    func loadLevels() { // Load levels into game
        
        // Get url of file
        guard let url = Bundle.main.url(forResource: "FH_data", withExtension: "json") else {
            print("url try didn't work")
            return
        }
        
        // Turn contents JSON file at url into data type
        guard let data = try? Data(contentsOf: url) else {
            print("data try didn't work")
            return
        }
        
        let jsonoutput = try! JSONDecoder().decode(LevelArrayJSON.self, from: data)
        
        let jsonarray = jsonoutput.levelfeed

        // Load data from memory
        let SavedData = loadData()
        
        // Cycle through and create objects
        var jsonarrayindex = levelsPerStage // index of levels to ensure each stage is only 20 items long
        var jsonstageindex = -1 // index of stages to cycle through stages
        for jsonlevel in jsonarray {
            
            // Create set of Arrays for each stage
            if (jsonarrayindex == levelsPerStage) {
                jsonarrayindex = 0
                jsonstageindex += 1
                
                let levelArray = [Level]() // Create array of levels
                stages.append(levelArray) // Add array of levels to stages
                stageStars.append(0) // initialise stage with 0 stars
            }

            var MinFlips: Int16 = 0
            
            // Overwrite the minflips based on stored value
            SavedData.forEach { item in
                if (jsonlevel.levelid == item.levelid)
                {
                    if (item.flips < MinFlips || MinFlips == 0) {
                        MinFlips = item.flips
                        // print(item.levelid)
                        // print(item.flips)
                    }
                }
            }
            
            // Initialise the level based on the id and flip count, mincount
            let levelinstance = Level(sequenceID: Int32(jsonlevel.levelid), goalFlips: Int16(jsonlevel.flips))
            
            if (MinFlips != 0) { // If the level has been won before, ensure level is marked as complete
                // TODO: Add sequence to the load and save function?
                levelinstance.completeLevel(Flips: MinFlips)
            }
            
            // Add level to the relevant stage array
            stages[jsonstageindex].append(levelinstance)
        
            jsonarrayindex += 1
        }
        
        calculateStars()
        
        // getFromURL()
        // sendResults()
    }
    
    func calculateStars() { // Load levels into game
        
        // Establish how many stages are unlocked
        goldCount = 0
        silverCount = 0
        bronzeCount = 0
        totalStars = 0

        for (index, stageindex)  in stages.enumerated() {
           stageStars[index] = 0
           for levelIndex in stageindex {
               let tempScore = levelIndex.starScore
               if (tempScore == 1) {
                   bronzeCount += tempScore
               } else if (tempScore == 2) {
                   silverCount += tempScore
               } else if (tempScore == 3) {
                   goldCount += tempScore
               }
               totalStars += tempScore
               stageStars[index] += tempScore
           }
        }

        // Calculate number of unlocked stages based on total stars etc
        let newStageCalc = stagesUnlockedInitial + (totalStars / unlockStarRatio)
        
        if (newStageCalc == stagesUnlocked) {
                   newStageUnlocked = false
        } else {
           newStageUnlocked = true
        }

        // Calculate number of unlocked stages based on total stars etc
        stagesUnlocked = newStageCalc

        // If the number of stars is exactly the number required, unlock the next stage
        if (totalStars == (stagesUnlocked * unlockStarRatio)) {
           stagesUnlocked += 1
           newStageUnlocked = true
        }

        // Adds visible locked stage and residual stars provided the maximum number of stages isn't reached
        if (stagesUnlocked >= stages.count) {
           stagesUnlocked = stages.count
           stagesVisible = stages.count
           remainingStars = 0
        } else {
           stagesVisible = stagesUnlocked + 1
           remainingStars = (stagesUnlocked * unlockStarRatio) - totalStars
        }
        
        if (totalStars > 0) {
            firstOpen = false
        }
    }
}

// ********************************** EXTENSIONS ********************************** //

extension FlippingHell: UpdateModelDelegate { // Implements update of model from main view
    func gameWon(LevelID: Int, Flips: Int16, ButtonsClicked: [Int]) {
        
        gameAttemptAdd()
        
        let LevelSelected = stages[currentStage][currentLevel]
        
        LevelSelected.completeLevel(Flips: Flips)
        
        calculateStars()
    
        saveData(levelid: LevelSelected.sequenceID, flips: Flips, minmoves: ButtonsClicked)

    }
    
    func gameAttemptAdd() {
        stages[currentStage][currentLevel].attempts += 1
    }
    
    func requestLevel() {
        let LevelSelected = stages[currentStage][currentLevel]
        let LevelArray = LevelSelected.numberToArray(NumberInput: LevelSelected.sequenceID)
        UpdateMainViewDelegateInstance.receiveLevel(LevelID: currentLevel, StageID: currentStage, StageMax: stagesUnlocked, newStage: newStageUnlocked, GoalFlips: LevelSelected.goalFlips, Sequence: LevelArray, IsCompleted: LevelSelected.isComplete, FirstOpen: firstOpen)
    }
}

extension FlippingHell: UpdateModelWinDelegate { // Implements update of model from Win view
    func nextLevel() {
        if (currentLevel < levelsPerStage - 1) {
            currentLevel += 1
        } else {
            if (currentStage < stages.count ) {
                currentStage += 1
                currentLevel = 0
            }
        }
    }
    func requestWin() {
        UpdateWinViewDelegateInstance.receiveWin(GoalFlips: stages[currentStage][currentLevel].goalFlips, LevelID: currentLevel, StageID: currentStage, StageMax: stagesUnlocked, NewStage: newStageUnlocked)
    }
}

extension FlippingHell: UpdateModelLevelsDelegate {
    func requestLevelList() {
        UpdateLevelViewDelegateInstance.receiveLevelList(LevelList: stages[currentStage], CurrentStage: currentStage, CurrentLevel: currentLevel, LevelsPerStage: levelsPerStage)
    }
    
    func changeLevel(StageID: Int, LevelID: Int) {
        currentStage = StageID
        currentLevel = LevelID
    }
}

extension FlippingHell: UpdateModelStagesDelegate {
    func requestStages() {
        UpdateStageViewDelegateInstance.receiveStageList(StagesVisible: stagesVisible, StagesUnlocked: stagesUnlocked, StagesStars: stageStars)
    }
    
    func changeStage(StageID: Int) {
        currentStage = StageID
    }
}


extension FlippingHell: UpdateModelScoresDelegate {
    func requestScores() {
        UpdateScoreViewDelegateInstance.receiveScores(GoldStars: goldCount, SilverStars: silverCount, BronzeStars: bronzeCount, TotalStars: totalStars, RemainingStars: remainingStars)
    }
}

extension NSManagedObjectContext
{
    func deleteAllData() {
        guard let persistentStore = persistentStoreCoordinator?.persistentStores.last else {
            return
        }

        guard let url = persistentStoreCoordinator?.url(for: persistentStore) else   {
            return
        }

        performAndWait { () -> Void in
            self.reset()
             do
            {
                try self.persistentStoreCoordinator?.remove(persistentStore)
                try FileManager.default.removeItem(at: url)
                try self.persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
             }
            catch { /*dealing with errors up to the usage*/ }
         }
    }
}
