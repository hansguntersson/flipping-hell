//
//  StageViewController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 07/01/2019.
//  Copyright © 2019 Hans Guntersson Ltd. All rights reserved.
//

import UIKit
import AVFoundation

// ********************************** PROTOCOLS ********************************** //

protocol UpdateModelStagesDelegate: AnyObject {
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
    
    // ********************************** SOUNDS ********************************** //
    
    let pagesoundurl = URL(fileURLWithPath: Bundle.main.path(forResource: "pageturn.mp3", ofType: nil)!)
    let swooshsoundurl = URL(fileURLWithPath: Bundle.main.path(forResource: "swoosh.mp3", ofType: nil)!)

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
    
    @IBAction func backToScreen(_ sender: Any) { // Back to Title screen
        self.dismiss(animated: true, completion: nil)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: self.pagesoundurl)
            audioPlayer?.volume = 1
            audioPlayer?.play()
        } catch {
            print("Unable to locate audio file")
        }
    }
    
    @IBAction func selectStage(_ sender: UIRoundedButton) {
        let lockedLevel: String = sender.titleLabel!.text!
        if (lockedLevel != "✕") {
            performSegue(withIdentifier: "LoadLevelsSegue", sender: sender)
        }
    }
    
    // ********************************** OVERRIDE FUNCTIONS ********************************** //

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return the number of items
        return stagesVisible
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StageCollectionViewCell", for: indexPath) as! StageViewCell
        
        // Configure the cell
        if (stagesStars[indexPath.row] == 60) {
            cell.cellContainer.backgroundColor = #colorLiteral(red: 1, green: 0.9210685055, blue: 0.6053425276, alpha: 1)
            cell.cellButton.backgroundColor = #colorLiteral(red: 0.9507014476, green: 0.5781816967, blue: 0, alpha: 1)
            cell.cellButton.setTitle(String(indexPath.row + 1), for: .normal)
            cell.cellText.text = "★ \(stagesStars[indexPath.row])"
            cell.cellText.textColor = #colorLiteral(red: 0.9507014476, green: 0.5781816967, blue: 0, alpha: 1)
            
        } else if (indexPath.row < stagesUnlocked) {
            cell.cellContainer.backgroundColor = #colorLiteral(red: 0.9213842275, green: 0.9213842275, blue: 0.9213842275, alpha: 1)
            cell.cellButton.backgroundColor = #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)
            cell.cellButton.setTitle(String(indexPath.row + 1), for: .normal)
            cell.cellText.text = "★ \(stagesStars[indexPath.row])"
            cell.cellText.textColor = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
        } else {
            cell.cellContainer.backgroundColor = #colorLiteral(red: 0.9213842275, green: 0.9213842275, blue: 0.9213842275, alpha: 1)
            cell.cellButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cell.cellButton.setTitle("✕", for: .normal)
            cell.cellText.text = "LOCKED"
            cell.cellText.textColor = #colorLiteral(red: 0.262745098, green: 0.262745098, blue: 0.262745098, alpha: 1)
        }
        
        return cell
    }
    
    
    // ********************************** SEGUES ********************************** //

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoadLevelsSegue" {
            let buttonInstance = sender as! UIButton
            if let vc = segue.destination as? UINavigationController {
                let lvc = vc.children[0] as! LevelTableViewController
                let StageSelected = Int(buttonInstance.currentTitle ?? "1")! - 1
                lvc.game = self.game
                lvc.StageSelected = StageSelected
                game?.UpdateLevelViewDelegateInstance = lvc
                UpdateModelStagesDelegateInstance.changeStage(StageID: StageSelected)
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: self.pagesoundurl)
                    audioPlayer?.volume = 1
                    audioPlayer?.play()
                } catch {
                    print("Unable to locate audio file")
                }
                
            }
        } else if segue.identifier == "LoadScoresFromStagesSegue" {
            if let vc = segue.destination as? ScoreViewController {
                vc.game = self.game
                game?.UpdateScoreViewDelegateInstance = vc
                
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: self.swooshsoundurl)
                    audioPlayer?.volume = 1
                    audioPlayer?.play()
                } catch {
                    print("Unable to locate audio file")
                }
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
