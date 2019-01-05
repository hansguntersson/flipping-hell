//
//  WinScreenController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 12/11/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

// ********************************** PROTOCOLS ********************************** //

protocol ResetDelegate {
    func resetToLevel(NextLevel: Bool)
}

// ********************************** CLASS DEFINITION ********************************** //

class WinScreenController: UIViewController {
    
    var ResetButtonsDelegate: ResetDelegate!
    
    @IBOutlet var WinStars: UILabel!
    @IBOutlet var WinFlips: UILabel!
    @IBOutlet var GoalFlips: UILabel!

    var WinStarsString: String = "TBD"
    var GoalFlipsString: String = "FLIPS: 0"
    var WinFlipsString: String = "GOAL: 0"
    var WinStarColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GoalFlips.text = GoalFlipsString
        WinFlips.text = WinFlipsString
        WinStars.text = WinStarsString
        WinStars.textColor = WinStarColor
    }
    
    @IBAction func replayLevel(_ sender: UIButton) {
        // resets level buttons etc and segues to it
        ResetButtonsDelegate.resetToLevel(NextLevel: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextLevel(_ sender: UIButton) {
        ResetButtonsDelegate.resetToLevel(NextLevel: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backToLevelView(_ sender: UIButton) {
        // unwind all the way back to level screen
        self.performSegue(withIdentifier: "unwindToLevelViewController", sender: self)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
