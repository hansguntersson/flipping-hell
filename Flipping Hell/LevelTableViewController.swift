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
    
    //MARK: Properties
    weak var game: FlippingHell?

    // TODO: create new struct where it's only the level data required for view
    // TODO: add in stage number to heading object
    // TODO: font sizing if the integers are too big?
    // TODO: create custom navbaritem class and change formatting
    // TODO: Change output for orientation to show more text - goal and flips
    
    var levels: [Level] = [] // structure for level
    var CurrentStage = 0 // current stage for sorting sections
    var CurrentLevel = 0; // current level for basic highlighting
    
    // ********************************** DELEGATES ********************************** //
    
    weak var UpdateModelLevelsDelegateInstance: UpdateModelLevelsDelegate!
    
    // ********************************** FUNCTIONs ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        UpdateModelLevelsDelegateInstance = game
        UpdateModelLevelsDelegateInstance.requestLevelList()
        
        // TODO: remove this - self.title = "STAGE " + "\(CurrentStage + 1)"
        // TODO: Check if this needs to be amnended on unwind from stage selection too
        
        scrollToFirstRow()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count / 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LevelTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LevelTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LevelTableViewCell.")
        }
        
        //  TODO: Should this reference be removed as it's accessing values directly?
        let thisLevel = levels[indexPath.row]
        
        if (indexPath.row == 19) {
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
    
    @IBAction func backToScreen(_ sender: Any) { // Back to Win or Main screen from Level screen
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func unwindFromStages(segue:UIStoryboardSegue) { // Stage selected and unwind
        UpdateModelLevelsDelegateInstance.requestLevelList()
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromLevelsWithSegue" {
            let buttonInstance = sender as! UIButton
            if (buttonInstance.currentTitle == "★") {
                UpdateModelLevelsDelegateInstance.changeLevel(StageID: CurrentStage, LevelID: 9)
            } else {
                UpdateModelLevelsDelegateInstance.changeLevel(StageID: CurrentStage, LevelID: Int(buttonInstance.currentTitle ?? "0")! - 1)
            }
        }
        
        /*else if segue.identifier == "LoadStagesSegue" {
            if let vc = segue.destination as? UINavigationController {
                let lvc = vc.children[0] as! ScoreViewController
                lvc.game = game
                lvc.SelectedStage = CurrentStage
            }
        } */
 
         
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "STAGE \(section + 1)"
    }
    
    
    /*override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.white
        return vw
    }*/
    
    
    func scrollToFirstRow() {
        let indexPath = NSIndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)
    }
}

// ********************************** EXTENSIONS ********************************** //

extension LevelTableViewController: UpdateLevelViewDelegate { // Receives and processes level list
    func receiveLevelList(StageID: Int, LevelList: [Level], CurrentStage: Int, CurrentLevel: Int) {
        levels = LevelList
        self.CurrentStage = CurrentStage
        self.CurrentLevel = CurrentLevel
        self.tableView.reloadData()
        
        // TODO: Navigate to the right level immediately
        scrollToFirstRow()
        
        self.title = "LEVEL SELECT"
    }
}
