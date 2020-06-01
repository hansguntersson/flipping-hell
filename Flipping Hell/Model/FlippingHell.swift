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

protocol UpdateMainViewDelegate: class {
    func receiveLevel(LevelID: Int, StageID: Int, StageMax: Int, GoalFlips: Int16, Sequence: [Int], IsCompleted: Bool, FirstOpen: Bool)
}

protocol UpdateLevelViewDelegate: class {
    func receiveLevelList(LevelList: [Level], CurrentStage: Int, CurrentLevel: Int, LevelsPerStage: Int)
}

protocol UpdateStageViewDelegate: class {
    func receiveStageList(StagesVisible: Int, StagesUnlocked: Int, StagesStars: [Int])
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
    var goldCount: Int = 0
    var silverCount: Int = 0
    var bronzeCount: Int = 0
    var stageStars: [Int] = [0] // number of stars obtained for each stage
    var totalStars: Int = 0 // total tally of stars which drives stage unlocks
    // 4 stars is blue, 3 stars is gold, 2 stars is silver, 1 star is bronze, 0 stars is none
    var remainingStars: Int = 0 // Stars remaining to the next level
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
        /*
        let TestArray = [0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0]
        
        let templevel = Level(sequence: TestArray, goalFlips: 2)
        print(templevel.sequenceID)
 
        */
        
        // deleteData()
        // getFromURL()
        // sendResults()
   
    }
    
    // ********************************** DELEGATES ********************************** //
    
    weak var UpdateMainViewDelegateInstance: UpdateMainViewDelegate!
    weak var UpdateLevelViewDelegateInstance: UpdateLevelViewDelegate!
    weak var UpdateStageViewDelegateInstance: UpdateStageViewDelegate!
    weak var UpdateScoreViewDelegateInstance: UpdateScoreViewDelegate!
    
    
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
    
    func calculateStars() {
        // Loop through stages
        // loop through each level, and look at star score for number of instances of star values
    }
    
    func loadLevels() { // Load levels into game
        
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
        
        var jsonarrayindex = levelsPerStage // index of levels to ensure each stage is only 20 items long
        var jsonstageindex = -1 // index of stages to cycle through stages
        for jsonlevel in jsonarray {
            
            if (jsonarrayindex == levelsPerStage) {
                jsonarrayindex = 0
                jsonstageindex += 1
                
                let levelArray = [Level]()
                stages.append(levelArray)
                stageStars.append(0)
            }
            
            let levelinstance = Level(sequenceID: Int32(jsonlevel.levelid), goalFlips: Int16(jsonlevel.flips))

            stages[jsonstageindex].append(levelinstance)
            
            jsonarrayindex += 1
            
        }
    }
}

// ********************************** EXTENSIONS ********************************** //

extension FlippingHell: UpdateModelDelegate { // Implements update of model from main view
    func gameWon(LevelID: Int, Flips: Int16, ButtonsClicked: [Int]) {
        
        gameAttemptAdd()
        
        let LevelSelected = stages[currentStage][currentLevel]
        
        LevelSelected.completeLevel(Flips: Flips, completeSequence: ButtonsClicked)
        
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
        stagesUnlocked = stagesUnlockedInitial + (totalStars / unlockStarRatio)
        
        // If the number of stars is exactly the number required, unlock the next stage
        if (totalStars == (stagesUnlocked * unlockStarRatio)) {
            stagesUnlocked += 1
        }
        
        // Adds visible locked stage and residual stars provided the maximum number of stages isn't reached
        if (stagesUnlocked >= stages.count) {
            stagesUnlocked = stages.count
            stagesVisible = stages.count
            remainingStars = 0
        } else {
            print("-- Else statement triggered -- ")
            stagesVisible = stagesUnlocked + 1
            remainingStars = (stagesUnlocked * unlockStarRatio) - totalStars
        }

        saveData(levelid: LevelSelected.sequenceID, flips: Flips)
        
        // let ItemList = loadData()
        // print(ItemList)
    }
    
    func gameAttemptAdd() {
        stages[currentStage][currentLevel].attempts += 1
    }
    
    func requestLevel() {
        let LevelSelected = stages[currentStage][currentLevel]
        let LevelArray = LevelSelected.numberToArray(NumberInput: LevelSelected.sequenceID)
        UpdateMainViewDelegateInstance.receiveLevel(LevelID: currentLevel, StageID: currentStage, StageMax: stagesUnlocked, GoalFlips: LevelSelected.goalFlips, Sequence: LevelArray, IsCompleted: LevelSelected.isComplete, FirstOpen: firstOpen)
        firstOpen = false
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
