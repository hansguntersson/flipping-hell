//
//  StageViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/01/2019.
//  Copyright © 2019 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** PROTOCOLS ********************************** //

protocol UpdateModelStagesDelegate: class {
    func requestScores() -> [Int]
}

// ********************************** CLASS DEFINITION ********************************** //
private let reuseIdentifier = "Cell"

class StageViewController: UICollectionViewController {

    // TODO: sum of stars and similar - summary elements?
    // TODO: Decide on how numbers by stars are going to be defined
    
    weak var game: FlippingHell?
    var SelectedStage: Int = 0
    
    var stages: [Int] = [1, 2, 3, 4, 5]
    let cellIdentifier = "StageCollectionViewCell"
    
    // ********************************** DELEGATES ********************************** //
    
    weak var UpdateModelStagesDelegateInstance: UpdateModelStagesDelegate!
    
    
    // ********************************** SETUP FUNCTION ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdateModelStagesDelegateInstance = game
        stages = UpdateModelStagesDelegateInstance.requestScores()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        // Do any additional setup after loading the view.
    }
    
    
    
    // ********************************** ACTIONS ********************************** //
    
    @IBAction func backToScreen(_ sender: Any) { // Back to Win or Main screen from Level screen
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    // ********************************** SEGUES ********************************** //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoadLevelsSegue" {
            if let vc = segue.destination as? UINavigationController {
                let lvc = vc.children[0] as! LevelTableViewController
                lvc.game = self.game
                game?.UpdateLevelViewDelegateInstance = lvc
                //lvc.DisplayedStage = self.game.currentStage ?? 0
                
            }
        }
    }
    
    
    // ********************************** OVERRIDE FUNCTIONS ********************************** //

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return stages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StageCollectionViewCell", for: indexPath) as! StageViewCell
    
            // Configure the cell
        cell.cellButton.setTitle("☆", for: .normal)
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    
    
    
    
    
    
    
 /*

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! UICollectionViewCell
     
        // Configure the cell
        let thisStage = stages[indexPath.row]
        cell.CellIndex = indexPath.row
        
        if (thisStage == 0) {
            cell.cellButton.setTitle("☆", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
            cell.cellButton.cornerCalculation(r: 1)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else if (thisStage == 1) {
            cell.cellButton.setTitle("★", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1), for: .normal)
            cell.cellButton.cornerCalculation(r: 1)
            cell.backgroundColor = #colorLiteral(red: 0.9639343619, green: 0.8337499499, blue: 0.685505569, alpha: 1)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.6425394416, green: 0.3705662191, blue: 0.03817562759, alpha: 1)
        } else if (thisStage == 2) {
            cell.cellButton.setTitle("★", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
            cell.cellButton.cornerCalculation(r: 1)
            cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.4861137271, green: 0.4832279086, blue: 0.4883345366, alpha: 1)
        } else if (thisStage == 3) {
            cell.cellButton.setTitle("★", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1), for: .normal)
            cell.cellButton.cornerCalculation(r: 1)
            cell.backgroundColor = #colorLiteral(red: 0.9720624089, green: 0.9512637258, blue: 0.7572063208, alpha: 1)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.7436745763, green: 0.5970394611, blue: 0.06599663943, alpha: 1)
        } else if (thisStage == 4) {
            cell.cellButton.setTitle("✮", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 0.2984283566, green: 0.8121408224, blue: 0.9792012572, alpha: 1), for: .normal)
            cell.cellButton.cornerCalculation(r: 1)
            cell.backgroundColor = #colorLiteral(red: 0.8391310573, green: 0.9654389024, blue: 0.9490205646, alpha: 1)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.2127193809, green: 0.5863756537, blue: 0.7115346193, alpha: 1)
        }
        cell.cellLabel.text = String(indexPath.row + 1)

        
        return cell
    } */


}
