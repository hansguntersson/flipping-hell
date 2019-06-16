//
//  StageCollectionViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/01/2019.
//  Copyright © 2019 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** PROTOCOLS ********************************** //

protocol UpdateModelStagesDelegate: class {
    func requestStages() -> [Int]
}

// ********************************** CLASS DEFINITION ********************************** //
private let reuseIdentifier = "Cell"

class StageCollectionViewController: UICollectionViewController {

    // TODO: sum of stars and similar - summary elements?
    // TODO: Decide on how numbers by stags are going to be defined
    
    weak var game: FlippingHell?
    var SelectedStage: Int = 40
    
    var stages: [Int] = []
    let cellIdentifier = "StageCollectionViewCell"
    
    // ********************************** DELEGATES ********************************** //
    
    var UpdateModelStagesDelegateInstance: UpdateModelStagesDelegate!
    
    // ********************************** FUNCTIONS ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdateModelStagesDelegateInstance = game
        stages = UpdateModelStagesDelegateInstance.requestStages()
        
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
        return self.stages.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> StageCollectionViewCell {
        
        let cell: StageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! StageCollectionViewCell
    
        // Configure the cell
        let thisStage = stages[indexPath.row]
        cell.CellIndex = indexPath.row
        
        if (thisStage == 0) {
            cell.cellButton.setTitle("☆", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else if (thisStage == 1) {
            cell.cellButton.setTitle("★", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1), for: .normal)
            cell.backgroundColor = #colorLiteral(red: 0.9639343619, green: 0.8337499499, blue: 0.685505569, alpha: 1)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.6425394416, green: 0.3705662191, blue: 0.03817562759, alpha: 1)
        } else if (thisStage == 2) {
            cell.cellButton.setTitle("★", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
            cell.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.4861137271, green: 0.4832279086, blue: 0.4883345366, alpha: 1)
        } else if (thisStage == 3) {
            cell.cellButton.setTitle("★", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1), for: .normal)
            cell.backgroundColor = #colorLiteral(red: 0.9720624089, green: 0.9512637258, blue: 0.7572063208, alpha: 1)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.7436745763, green: 0.5970394611, blue: 0.06599663943, alpha: 1)
        } else if (thisStage == 4) {
            cell.cellButton.setTitle("✮", for: .normal)
            cell.cellButton.setTitleColor(#colorLiteral(red: 0.2984283566, green: 0.8121408224, blue: 0.9792012572, alpha: 1), for: .normal)
            cell.backgroundColor = #colorLiteral(red: 0.8391310573, green: 0.9654389024, blue: 0.9490205646, alpha: 1)
            cell.borderWidth = 1
            cell.cellLabel.textColor = #colorLiteral(red: 0.2127193809, green: 0.5863756537, blue: 0.7115346193, alpha: 1)
        }
        cell.cellLabel.text = String(indexPath.row + 1)
        
        return cell
    }
    
    @IBAction func unwindToLevelMenuFromStages(segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindFromStagesWithSegue" {
            let buttonInstance = sender as! UIButton
            let superView = buttonInstance.superview?.superview?.superview as! StageCollectionViewCell
            
            if let vc = segue.destination as? LevelTableViewController {
                vc.DisplayedStage = superView.CellIndex
                vc.reloadInputViews()
            }
        }
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
