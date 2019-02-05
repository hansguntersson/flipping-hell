//
//  LevelTableViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 14/10/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class LevelTableViewController: UITableViewController {

    //MARK: Properties
    var levels = [Level]()
    var CurrentLevel = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "LevelTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? LevelTableViewCell  else {
            fatalError("The dequeued cell is not an instance of LevelTableViewCell.")
        }
        
        let level = levels[indexPath.row]
        
        if (level.levelIndex == 20) {
            cell.levelIndex.setTitle("★", for: .normal)
        } else {
            cell.levelIndex.setTitle(String(level.levelIndex), for: .normal)
        }
        
        cell.levelGoal.text = "GOAL: " + "\(level.GoalFlips)"
        
        if(level.minFlips == 0) {
            cell.levelStars.text = "☆ ☆ ☆"
            cell.levelStars.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else if (level.minFlips - level.GoalFlips > 2) {
            cell.levelStars.text = "★"
            cell.levelStars.textColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        } else if (level.minFlips - level.GoalFlips > 0) {
            cell.levelStars.text = "★ ★"
            cell.levelStars.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else if (level.minFlips - level.GoalFlips == 0) {
            cell.levelStars.text = "★ ★ ★"
            cell.levelStars.textColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        } else if (level.minFlips - level.GoalFlips < 0) {
            cell.levelStars.text = "✮ ✮ ✮"
           cell.levelStars.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "loadLevelSegue" {
            if let levelIndex = Int((sender as! UIButton).currentTitle ?? "1") {
                let level = levels[levelIndex - 1]
                if let mvc = segue.destination as? MainViewController {
                    mvc.UpdateLevelsDelegate = self
                    mvc.CurrentLevel = level.sequence
                    mvc.GoalFlips = level.GoalFlips
                    mvc.LevelNum = levelIndex
                    CurrentLevel = levelIndex
                }
            }
        }
    }
}

extension LevelTableViewController: UpdateLevelsScreenDelegate {
    func updateLevels(WinStars: String, WinColour: UIColor, WinFlips: Int) {
        // Update cells as appropriate
    }

}
