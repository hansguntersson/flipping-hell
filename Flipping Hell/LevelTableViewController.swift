//
//  LevelTableViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 14/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** PROTOCOLS ********************************** //

protocol UpdateModelLevelsDelegate: class {
    func requestLevelList()
    func changeLevel(StageID: Int, LevelID: Int)
}

// ********************************** CLASS DEFINITION ********************************** //

class LevelTableViewController: UITableViewController {
    
    weak var game: FlippingHell?
    
    var levels: [Level] = [] // structure for level
    var CurrentStage = 0 // current stage for sorting sections
    var CurrentLevel = 0; // current level for basic highlighting
    var LevelsPerStage = 0 // Number of levels per stage
    
    // ********************************** DELEGATES ********************************** //
    
    weak var UpdateModelLevelsDelegateInstance: UpdateModelLevelsDelegate!
    
    // ********************************** LOAD FUNCTION ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        UpdateModelLevelsDelegateInstance = game
        UpdateModelLevelsDelegateInstance.requestLevelList()
        
        scrollToFirstRow()
    }
    
    // ********************************** OVERRIDE FUNCTIONS ********************************** //
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LevelsPerStage
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LevelTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LevelTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LevelTableViewCell.")
        }
        
        let thisLevel = levels[indexPath.row]
        
        if (indexPath.row == LevelsPerStage - 1) {
            cell.levelIndex.setTitle("★", for: .normal)
        } else {
            cell.levelIndex.setTitle(String(indexPath.row + 1), for: .normal)
        }
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.levelGoal.text = "FLIPS " + "\(thisLevel.minFlips)" + " | " + "\(thisLevel.goalFlips)"
        
        if(thisLevel.starScore == 0) {
            cell.levelStars.text = "☆ ☆ ☆"
            cell.levelStars.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else if (thisLevel.starScore == 1) {
            cell.levelStars.text = "★ ☆ ☆"
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        } else if (thisLevel.starScore == 2) {
            cell.levelStars.text = "★ ★ ☆"
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        } else if (thisLevel.starScore == 3) {
            cell.levelStars.text = "★ ★ ★"
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        } else if (thisLevel.starScore == 4) {
            cell.levelStars.text = "✮ ✮ ✮"
            cell.levelStars.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
        
        if (indexPath.row == CurrentLevel && CurrentStage == CurrentStage) {
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cell.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
        }
        
        return cell
    }
    
    // ********************************** ACTIONS ********************************** //
    
    @IBAction func backToScreen(_ sender: Any) { // Back to Win or Main screen from Level screen
        game?.requestStages()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // ********************************** SEGUES ********************************** //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameStartSegue" {
            if let vc = segue.destination as? MainViewController {
                vc.game = self.game
                game!.UpdateMainViewDelegateInstance = vc
                let buttonInstance = sender as! UIButton
                
                if (buttonInstance.currentTitle == "★") {
                    UpdateModelLevelsDelegateInstance.changeLevel(StageID: CurrentStage, LevelID: 19)
                } else {
                    UpdateModelLevelsDelegateInstance.changeLevel(StageID: CurrentStage, LevelID: Int(buttonInstance.currentTitle ?? "0")! - 1)
                }
            }
        } else if segue.identifier == "LoadScoresFromLevelsSegue" {
            if let vc = segue.destination as? ScoreViewController {
                vc.game = self.game
                game?.UpdateScoreViewDelegateInstance = vc
            }
       }
    }
    
    @IBAction func unwindFromWintoLevel( _ seg: UIStoryboardSegue) {
        game?.requestLevelList()
    }
    

    // ********************************** FUNCTIONS ********************************** //
    
    func scrollToFirstRow() {
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
}

// ********************************** EXTENSIONS ********************************** //

extension LevelTableViewController: UpdateLevelViewDelegate { // Receives and processes level list
    func receiveLevelList(LevelList: [Level], CurrentStage: Int, CurrentLevel: Int, LevelsPerStage: Int) {
        levels = LevelList
        self.LevelsPerStage = LevelsPerStage
        self.CurrentStage = CurrentStage
        self.CurrentLevel = CurrentLevel
        self.tableView.reloadData()
        
        scrollToFirstRow()
        
        self.title = "STAGE \(CurrentStage + 1)"
    }
}
