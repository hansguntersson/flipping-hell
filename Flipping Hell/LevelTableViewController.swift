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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the sample data.
        loadSampleLevels()

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
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
    
        let level = levels[indexPath.row]
        
        cell.levelStars.text = level.stars

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    private func loadSampleLevels() {
        let level1 = Level(sequence: [0, 0, 0, 0, 0,
                                      0, 0, 0, 0, 0,
                                      0, 1, 1, 1, 0,
                                      0, 0, 0, 0, 0,
                                      0, 0, 0, 0, 0])
        let level2 = Level(sequence: [0, 0, 0, 0, 0,
                                      0, 1, 1, 1, 0,
                                      0, 0, 1, 0, 0,
                                      0, 0, 1, 0, 0,
                                      0, 0, 1, 0, 0])
        let level3 = Level(sequence: [1, 1, 1, 0, 0,
                                      0, 0, 1, 0, 0,
                                      0, 0, 1, 0, 0,
                                      0, 0, 1, 0, 0,
                                      0, 0, 1, 1, 1])
        let level4 = Level(sequence: [0, 0, 0, 0, 0,
                                      1, 1, 1, 1, 1,
                                      1, 0, 0, 0, 1,
                                      1, 1, 1, 1, 1,
                                      0, 0, 0, 0, 0])

        levels += [level1, level2, level3, level4]
        
    }

}
