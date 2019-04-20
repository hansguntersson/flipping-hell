//
//  WinScreenController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 12/11/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

// ********************************** PROTOCOLS ********************************** //

protocol ResetButtonsDelegate {
    func resetToLevel(Stage: Int, Level: Int)
}

protocol UpdateModelWinDelegate {
    func temporary()
}

import UIKit

// ********************************** CLASS DEFINITION ********************************** //

class WinScreenController: UIViewController {
    
    weak var game = FlippingHell()
    
    var WinFlips = 0
    var GoalFlips = 0
    var LevelNumber = 0
    var StageNumber = 0
    
    var levels: [Level] = []
   
    @IBOutlet var WinPopup: UIView!
    @IBOutlet var NextLevelButton: UIButton!
    
    @IBOutlet var WinStarsText: UILabel!
    @IBOutlet var WinFlipsText: UILabel!
    @IBOutlet var GoalFlipsText: UILabel!

    var WinStarsString: String = "TBD"
    var WinStarColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    // ********************************** DELEGATES ********************************** //
    
    var ResetButtonsDelegateInstance: ResetButtonsDelegate!
    var UpdateModelWinDelegateInstance: UpdateModelDelegate!
    
    // ********************************** FUNCTIONS ********************************** //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UpdateModelWinDelegateInstance = game
        
        GoalFlipsText.text = "GOAL: \(GoalFlips)"
        WinFlipsText.text = "FLIPS: \(WinFlips)"
        
        if (WinFlips - GoalFlips > 2) {
            WinStarsText.text = "★"
            WinStarsText.textColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
        } else if (WinFlips - GoalFlips > 0) {
            WinStarsText.text = "★ ★"
            WinStarsText.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        } else if (WinFlips - GoalFlips == 0) {
            WinStarsText.text = "★ ★ ★"
            WinStarsText.textColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
        } else if (WinFlips - GoalFlips < 0) {
            WinStarsText.text = "✮ ✮ ✮"
            WinStarsText.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        }
        
        // New stage trigger
        if(LevelNumber == 19) {
            NextLevelButton.setTitle("NEXT STAGE", for: .normal)
            // StageNumber += 1
        } else {
            NextLevelButton.setTitle("NEXT LEVEL", for: .normal)
        }
    }
    
    @IBAction func replayLevel(_ sender: UIButton) {
        // resets level buttons etc and segues to it
        ResetButtonsDelegateInstance.resetToLevel(Stage: StageNumber, Level: LevelNumber)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextLevel(_ sender: UIButton) {
        if(LevelNumber == 19) {
            ResetButtonsDelegateInstance.resetToLevel(Stage: StageNumber + 1, Level: 0)
        } else {
            ResetButtonsDelegateInstance.resetToLevel(Stage: StageNumber, Level: LevelNumber + 1)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectLevel(_ sender: UIButton) {
        self.performSegue(withIdentifier: "WinSelectLevelSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WinSelectLevelSegue" {
            if let vc = segue.destination as? UINavigationController {
                let lvc = vc.children[0] as! LevelTableViewController
                lvc.game = self.game
                // lvc.UpdateModelLevelsDelegateInstance = UpdateModelWinDelegateInstance as? UpdateModelLevelsDelegate
                lvc.levels = levels
                lvc.CurrentLevel = LevelNumber
            }
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
