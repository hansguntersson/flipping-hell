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
    @IBOutlet weak var StageCollectionView: UICollectionView!
    
    // ********************************** SETUP FUNCTION ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let width = (view.frame.size.width / 3) - 15
        let layout = StageCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: (width * 1.2))
        
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
        
        let cellIndex = String(indexPath.row + 1)
        cell.cellButton.setTitle(cellIndex, for: .normal)
        
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


}
