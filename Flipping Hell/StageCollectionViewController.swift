//
//  StageCollectionViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/01/2019.
//  Copyright © 2019 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** PROTOCOLS ********************************** //

protocol UpdateModelStagesDelegate {
    func requestStages()
}

// ********************************** CLASS DEFINITION ********************************** //
private let reuseIdentifier = "Cell"

class StageCollectionViewController: UICollectionViewController {

    // TODO: sum of stars and similar - summary elements?
    // TODO: create new struct where it's only the stage data required for view
    
    weak var game: FlippingHell?
    
    var Stages: [[Level]]?
    let cellIdentifier = "StageCollectionViewCell"
    
    // ********************************** DELEGATES ********************************** //
    
    var UpdateModelStagesDelegateInstance: UpdateModelStagesDelegate!
    
    // ********************************** FUNCTIONS ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdateModelStagesDelegateInstance = game
        UpdateModelStagesDelegateInstance.requestStages()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Stages?.count ?? 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> StageCollectionViewCell {
        
        let cell: StageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! StageCollectionViewCell
    
        // Configure the cell
        
        cell.cellButton.setTitle("☆", for: .normal)
        cell.cellButton.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        cell.cellLabel.text = String(indexPath.count)
        
        // StageCollectionViewCell
        
        // TODO: Stage formatting
        
        /* cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.levelGoal.text = "GOAL: " + "\(level.GoalFlips)"
        
        if(level.minFlips == 0) {
            cell.levelStars.text = "☆"
            // cell.levelStars.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.levelStars.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else if (level.minFlips - level.GoalFlips > 2) {
            cell.levelStars.text = "★"
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            // cell.levelStars.textColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        } else if (level.minFlips - level.GoalFlips > 0) {
            cell.levelStars.text = "★"
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            // cell.levelStars.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else if (level.minFlips - level.GoalFlips == 0) {
            cell.levelStars.text = "★"
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            // cell.levelStars.textColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        } else if (level.minFlips - level.GoalFlips < 0) {
            cell.levelStars.text = "✮"
            cell.levelStars.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
        
        if (indexPath.row == CurrentLevel) {
            cell.levelStars.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        } */
        
        return cell
    }
    
    @IBAction func unwindToLevelMenuFromStages(segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionVieiw(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
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

}
