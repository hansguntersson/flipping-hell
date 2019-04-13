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
    
    struct level {
        let sequenceID: Int
        let goalFlips: Int
        let minFlips: Int
    }
    
    var levels: [Level] = [] // structure for level
    var CurrentStage = 0 // current stage for identification in
    var CurrentLevel = 0; // current level for basic highlighting
    
    // What actual data do we need? List of IDs, goal, min, current,
    
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
        
        let thisLevel = levels[indexPath.row]
        
        if (indexPath.row == 19) {
            cell.levelIndex.setTitle("★", for: .normal)
        } else {
            cell.levelIndex.setTitle(String(indexPath.row + 1), for: .normal)
        }
        
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.levelGoal.text = "GOAL: " + "\(thisLevel.GoalFlips)"
        
        if(thisLevel.minFlips == 0) {
            cell.levelStars.text = "☆ ☆ ☆"
            // cell.levelStars.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.levelStars.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else if (thisLevel.minFlips - thisLevel.GoalFlips > 2) {
            cell.levelStars.text = "★ ☆ ☆"
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            // cell.levelStars.textColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        } else if (thisLevel.minFlips - thisLevel.GoalFlips > 0) {
            cell.levelStars.text = "★ ★ ☆"
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            // cell.levelStars.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else if (thisLevel.minFlips - thisLevel.GoalFlips == 0) {
            cell.levelStars.text = "★ ★ ★"
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            // cell.levelStars.textColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        } else if (thisLevel.minFlips - thisLevel.GoalFlips < 0) {
            cell.levelStars.text = "✮ ✮ ✮"
           cell.levelStars.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
        
        if (indexPath.row == CurrentLevel) {
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cell.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.9372549057, blue: 0.9568627477, alpha: 1)
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
    
    @IBAction func backToScreen(_ sender: Any) { // Back to Win or Main screen from Level screen
        self.dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "unwindFromLevel") {
            if let vc = segue.destination as? MainViewController {
                let cellInput = (sender as AnyObject).currentTitle ?? "0"
                if (cellInput == "★") {
                    vc.LevelNum = 19
                } else {
                    vc.LevelNum = (Int(cellInput ?? "0") ?? 0) - 1
                }
            }
        }
    }
}
