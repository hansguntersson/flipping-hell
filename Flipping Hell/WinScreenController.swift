//
//  WinScreenController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 12/11/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

// ********************************** PROTOCOLS ********************************** //

protocol ResetDelegate {
    func resetToLevel(Level: Int)
}

import UIKit

// ********************************** CLASS DEFINITION ********************************** //

class WinScreenController: UIViewController {
    
    var ResetButtonsDelegate: ResetDelegate!
    
    var WinFlips = 0
    var GoalFlips = 0
    var LevelNumber = 0
    
    var levels: [Level] = []
   
    @IBOutlet weak var WinPopup: UIView!
    @IBOutlet weak var NextLevelButton: UIButton!
    
    @IBOutlet var WinStarsText: UILabel!
    @IBOutlet var WinFlipsText: UILabel!
    @IBOutlet var GoalFlipsText: UILabel!

    var WinStarsString: String = "TBD"
    var WinStarColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        
        if(LevelNumber == 19) {
            NextLevelButton.isHidden = true
        } else {
             NextLevelButton.isHidden = false
        }
    }
    
    @IBAction func replayLevel(_ sender: UIButton) {
        // resets level buttons etc and segues to it
        ResetButtonsDelegate.resetToLevel(Level: LevelNumber)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextLevel(_ sender: UIButton) {
        ResetButtonsDelegate.resetToLevel(Level: LevelNumber + 1)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectLevel(_ sender: UIButton) {
        self.performSegue(withIdentifier: "WinSelectLevelSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WinSelectLevelSegue" {
            if let vc = segue.destination as? UINavigationController {
                let lvc = vc.children[0] as! LevelTableViewController
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
