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
    func requestStages()
    func changeStage(StageID: Int)
}

// ********************************** CLASS DEFINITION ********************************** //
private let reuseIdentifier = "Cell"

class StageViewController: UICollectionViewController {
    
    weak var game: FlippingHell?
    var SelectedStage: Int = 0
    
    var stagesStars: [Int] = [0, 0, 0]
    var stagesVisible = 3
    var stagesUnlocked = 3
    let cellIdentifier = "StageCollectionViewCell"
    
    // ********************************** DELEGATES ********************************** //
    
    weak var UpdateModelStagesDelegateInstance: UpdateModelStagesDelegate!
    @IBOutlet weak var StageCollectionView: UICollectionView!
    
    // ********************************** SETUP FUNCTION ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width / 3) - 15
        let layout = StageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: (width * 1.2))
        
        UpdateModelStagesDelegateInstance = game
        UpdateModelStagesDelegateInstance.requestStages()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)

        // Do any additional setup after loading the view.
    }
    
    
    
    // ********************************** ACTIONS ********************************** //
    
    @IBAction func backToScreen(_ sender: Any) { // Back to Win or Main screen from Level screen
        // TODO: Build reset routine to trigger when
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // ********************************** OVERRIDE FUNCTIONS ********************************** //

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return stagesVisible
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StageCollectionViewCell", for: indexPath) as! StageViewCell
        
        // Configure the cell
        if (indexPath.row < stagesUnlocked) {
            cell.cellButton.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
            cell.cellButton.setTitle(String(indexPath.row + 1), for: .normal)
            cell.cellText.text = "Stars: \(stagesStars[indexPath.row])"
        } else {
            cell.cellButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            cell.cellButton.setTitle("✕", for: .normal)
            cell.cellText.text = "LOCKED"
        }
        
        return cell
    }
    
    
    // ********************************** SEGUES ********************************** //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Account for segue only with buttons that do not have X's on them
        let buttonInstance = sender as! UIButton
        if segue.identifier == "LoadLevelsSegue" {
            // Correct for inert stages that are not yet unlocked
            
            if let vc = segue.destination as? UINavigationController {
                let lvc = vc.children[0] as! LevelTableViewController
                lvc.game = self.game
                game?.UpdateLevelViewDelegateInstance = lvc
                UpdateModelStagesDelegateInstance.changeStage(StageID: Int(buttonInstance.currentTitle ?? "1")! - 1)
            }
        }
    }
   
}
    
// ********************************** EXTENSIONS ********************************** //

extension StageViewController: UpdateStageViewDelegate {
    func receiveStageList(StagesVisible: Int, StagesUnlocked: Int, StagesStars: [Int]) {
        
        self.stagesVisible = StagesVisible
        self.stagesUnlocked = StagesUnlocked
        self.stagesStars = StagesStars
        
        self.collectionView.reloadData()
    }
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



