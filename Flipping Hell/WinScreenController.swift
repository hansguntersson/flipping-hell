//
//  WinScreenController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 12/11/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

// ********************************** PROTOCOLS ********************************** //

protocol ReplayLevelDelegate: class {
    func replayLevel()
}

protocol UpdateModelWinDelegate: class {
    func nextLevel()
}

import UIKit

// ********************************** CLASS DEFINITION ********************************** //

class WinScreenController: UIViewController {
    
    weak var game: FlippingHell?
    
    var WinFlips: Int16 = 0
    var GoalFlips: Int16 = 0
    var LevelNumber = 0
    var StageNumber = 0
    var StageMax = 2
    
    var levels: [Level] = []
   
    @IBOutlet var NextLevelButton: UIRoundedButton!
    @IBOutlet var NextLevelText: UILabel!
    @IBOutlet var WinStarsText: UILabel!
    @IBOutlet var WinFlipsText: UILabel!
    @IBOutlet var GoalFlipsText: UILabel!

    @IBOutlet weak var WinStarBoxOuter: UIView!
    @IBOutlet weak var WinStarBoxInner: UIView!
    
    var WinStarsString: String = ""
    var WinStarColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

    
    // ********************************** DELEGATES ********************************** //
    
    weak var ReplayButtonsDelegateInstance: ReplayLevelDelegate!
    weak var UpdateModelWinDelegateInstance: UpdateModelWinDelegate!
    
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
            WinStarBoxOuter.backgroundColor = #colorLiteral(red: 1, green: 0.5764705882, blue: 0, alpha: 1)
            WinStarBoxInner.backgroundColor = #colorLiteral(red: 1, green: 0.8517647059, blue: 0.65, alpha: 1)
        } else if (WinFlips - GoalFlips > 0) {
            WinStarsText.text = "★ ★"
            WinStarsText.textColor = #colorLiteral(red: 0.712579906, green: 0.712579906, blue: 0.712579906, alpha: 1)
            WinStarBoxOuter.backgroundColor = #colorLiteral(red: 0.712579906, green: 0.712579906, blue: 0.712579906, alpha: 1)
            WinStarBoxInner.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
        } else if (WinFlips - GoalFlips <= 0) {
            WinStarsText.text = "★ ★ ★"
            WinStarsText.textColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            WinStarBoxOuter.backgroundColor = #colorLiteral(red: 1, green: 0.8, blue: 0, alpha: 1)
            WinStarBoxInner.backgroundColor = #colorLiteral(red: 1, green: 0.94, blue: 0.7, alpha: 1)
        }
        
        
        // New stage or level button defined by current stage etc
        if (StageNumber == (StageMax - 1) && LevelNumber == 19) {
            NextLevelText.isHidden = true
            NextLevelButton.isHidden = true
        } else if (LevelNumber == 19) {
            NextLevelText.text = "Next Stage"
        } else {
            NextLevelText.text = "Next Level"
        }
    }
    
    @IBAction func replayLevel(_ sender: UIButton) {
        ReplayButtonsDelegateInstance.replayLevel()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextLevel(_ sender: UIButton) {
        UpdateModelWinDelegateInstance.nextLevel()
        ReplayButtonsDelegateInstance.replayLevel()
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
