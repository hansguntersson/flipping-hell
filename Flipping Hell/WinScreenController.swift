//
//  WinScreenController.swift
//  Flipping Hell
//
//  Created by Daniel Harlos on 12/11/2018.
//  Copyright © 2018 Hans Guntersson Ltd. All rights reserved.
//

import UIKit

class WinScreenController: UIViewController {
    
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
        self.dismiss(animated: true, completion: nil)
        // reset level on view controller then segue to it
        //self.performSegue(withIdentifier: "unwindToMainViewController", sender: self)
    }
    
    @IBAction func nextLevel(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backToLevelView(_ sender: UIButton) {
        // update the level screen with win values
        //unwind all the way back to level screen
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
